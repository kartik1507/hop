`timescale 1ns / 1ps
`include "Const.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/02/2015 02:09:36 PM
// Design Name: 
// Module Name: testSetupWrap
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module testSetupWrap;
    `include "FSM.vh"
    `include "PathORAM.vh"
            
    `include "DMLocal.vh"
    `include "DDR3SDRAMLocal.vh"
    `include "BucketLocal.vh"
    `include "CommandsLocal.vh"
    `include "JTAG.vh"
    parameter NetworkWidth = 64;
    wire                        Clock;
    reg                         Reset; // making this reg so that a value can be set if needed
    reg                         DataInValid;
    reg [DataWidth-1:0]         DataIn;
    wire                        DataInReady; // unused
    
    wire [DataWidth-1:0]        DataOut;
    wire                        DataOutValid;
    reg                         DataOutReady; // unused
    wire [SetupStatesWidth-1:0] Cmd;
    reg [DataWidth-1:0]         Inputs [MaxInputLength-1:0];
    reg [DataWidth-1:0]			Program [MaxProgramLength-1:0];
    
    wire [DDRAWidth-1:0]        DDR3SDRAM_Address;
    wire [DDRCWidth-1:0]        DDR3SDRAM_Command;
    wire                        DDR3SDRAM_CommandValid;
    wire                         DDR3SDRAM_CommandReady;
    wire [NetworkWidth-1:0]         DDR3SDRAM_ReadData;
    wire                         DDR3SDRAM_ReadValid;
    //reg                         DDR3SDRAM_ReadReady;
    wire [NetworkWidth-1:0]        DDR3SDRAM_WriteData;
    wire                        DDR3SDRAM_WriteValid;
    wire                         DDR3SDRAM_WriteReady;
    
    wire	[DDRDWidth-1:0]		DDR3SDRAM_ReadData_Wide,	DDR3SDRAM_ReadData_Wide_Pre;
    wire                        DDR3SDRAM_ReadValid_Wide,     DDR3SDRAM_ReadReady_Wide;
    wire                        DDR3SDRAM_ReadValid_Wide_Pre, DDR3SDRAM_ReadReady_Wide_Pre;
    
    wire    [DDRDWidth-1:0]        DDR3SDRAM_WriteData_Wide;
    wire                        DDR3SDRAM_WriteValid_Wide, DDR3SDRAM_WriteReady_Wide;
    
    localparam                  InputLength = 3;
    localparam					ProgramLength = 3;
    
    SetupWrap setupWrap(    .Clock(                     Clock),
                            .Reset(                     Reset),
                            .DataIn(                    DataIn),
                            .DataInValid(               DataInValid),
                            .DataInReady(               DataInReady), // unused
                            .DataOut(                   DataOut),
                            .DataOutValid(              DataOutValid),
                            .DataOutReady(              DataOutReady), // unused
                            .Cmd(                       Cmd),
                            .DDR3SDRAM_Address(         DDR3SDRAM_Address),
                            .DDR3SDRAM_Command(         DDR3SDRAM_Command),
                            .DDR3SDRAM_CommandValid(    DDR3SDRAM_CommandValid),
                            .DDR3SDRAM_CommandReady(    DDR3SDRAM_CommandReady),
                            .DDR3SDRAM_ReadData(        DDR3SDRAM_ReadData),
                            .DDR3SDRAM_ReadValid(       DDR3SDRAM_ReadValid),
                            .DDR3SDRAM_WriteData(       DDR3SDRAM_WriteData),
                            .DDR3SDRAM_WriteValid(      DDR3SDRAM_WriteValid),
                            .DDR3SDRAM_WriteReady(      DDR3SDRAM_WriteReady)
    );
    
    FIFOShiftRound #(		.IWidth(				DDRDWidth),
                                .OWidth(                NetworkWidth),
                                .Reverse(                1))
                    in_shft(    .Clock(                    Clock),
                                .Reset(                    Reset),
                                .InData(                DDR3SDRAM_ReadData_Wide),
                                .InValid(                DDR3SDRAM_ReadValid_Wide),
                                .InAccept(                DDR3SDRAM_ReadReady_Wide),
                                .OutData(                DDR3SDRAM_ReadData),
                                .OutValid(                DDR3SDRAM_ReadValid),
                                .OutReady(                1'b1));
                                
    FIFOShiftRound #(		.IWidth(				NetworkWidth),
                            .OWidth(                DDRDWidth),
                            .Reverse(                1))
                out_shft(    .Clock(                    Clock),
                            .Reset(                    Reset),
                            .InData(                DDR3SDRAM_WriteData),
                            .InValid(                DDR3SDRAM_WriteValid),
                            .InAccept(                DDR3SDRAM_WriteReady),
                            .OutData(                DDR3SDRAM_WriteData_Wide),
                            .OutValid(                DDR3SDRAM_WriteValid_Wide),
                            .OutReady(                DDR3SDRAM_WriteReady_Wide));
    
    wire    [DDRAWidth-1:0]    DRAMReadAddr;
    wire                    DRAMReadAddrValid;
    FIFORAM    #(                .Width(                    DDRAWidth),
                            .Buffering(                500))
        rd_addr(            .Clock(                    Clock),
                            .Reset(                    Reset),
                            .InData(                DDR3SDRAM_Address),
                            .InValid(                DDR3SDRAM_Command == DDR3CMD_Read && DDR3SDRAM_CommandValid && DDR3SDRAM_CommandReady),
                            .InAccept(                ),
                            .OutData(                DRAMReadAddr),
                            .OutSend(                DRAMReadAddrValid),
                            .OutReady(                DDR3SDRAM_ReadValid_Wide && DDR3SDRAM_ReadReady_Wide));
                                
    localparam				InBufDepth = 6,
							OutInitLat = 30,
							OutBandWidth = 57,
							InBandWidth = 100;
	SynthesizedRandDRAM	#(	.InBufDepth(			InBufDepth),
	                        .OutInitLat(			OutInitLat),
	                        .OutBandWidth(			OutBandWidth),
							.InBandWidth(			InBandWidth),
                            .UWidth(				64),
                            .AWidth(				DDRAWidth),
                            .DWidth(				DDRDWidth),
                            .BurstLen(				1),
                            .EnableMask(			1),
                            .Class1(				1),
                            .RLatency(				1),
                            .WLatency(				1)) 
        ddr3model(	        .Clock(					Clock),
                            .Reset(					Reset),
                            
                            .CommandAddress(		DDR3SDRAM_Address),
                            .Command(				DDR3SDRAM_Command),
                            .CommandValid(			DDR3SDRAM_CommandValid),
                            .CommandReady(			DDR3SDRAM_CommandReady),
                            
                            .DataIn(				DDR3SDRAM_WriteData_Wide),
                            .DataInMask(			8'h00), // TODO: this may get mis-aligned because of the shifters, but we won't change it anyway
                            .DataInValid(			DDR3SDRAM_WriteValid_Wide),
                            .DataInReady(			DDR3SDRAM_WriteReady_Wide),
                            
                            .DataOut(				DDR3SDRAM_ReadData_Wide_Pre),
                            .DataOutValid(			DDR3SDRAM_ReadValid_Wide_Pre),
                            .DataOutReady(			DDR3SDRAM_ReadReady_Wide_Pre));
    
    FIFORAM	#(				.Width(					DDRDWidth),
                            .Buffering(                1023))
        rd_data(            .Clock(                    Clock),
                            .Reset(                    Reset),
                            .InData(                DDR3SDRAM_ReadData_Wide_Pre),
                            .InValid(                DDR3SDRAM_ReadValid_Wide_Pre),
                            .InAccept(                DDR3SDRAM_ReadReady_Wide_Pre),
                            .OutData(                DDR3SDRAM_ReadData_Wide),
                            .OutSend(                DDR3SDRAM_ReadValid_Wide),
                            .OutReady(                DDR3SDRAM_ReadReady_Wide));
                                                        
    reg [7:0] i;
    initial begin
        Reset = 0;
        #(ClockCycle * 4);
        Reset = 1;
        #(ClockCycle);
        Reset = 0;
        Inputs[0] = 11;
        Inputs[1] = 14;
        Inputs[2] = 20;
        Program[0] = 7; // r[Inst[15:11]] = r[Inst[20:16]] >> Inst[10:6];
        Program[1] = {6'h23, 5'h0, 5'h4, 16'h2}; // lw 4, 2
        Program[2] = {6'h23, 5'h0, 5'h5, 16'h1}; // lw 5, 1
        Program[3] = {6'h20, 5'h5, 5'h4, 5'h3, 11'h0}; // add 3, 4, 5
        Program[4] = {6'h2,  5'h0, 5'h3, 5'h3, 5'h1, 6'h0}; // srl 3, 3, 1
        Program[5] = {6'h2B, 5'h0, 5'h3, 16'h5}; // sw 4, 5
        Program[6] = 0;
    end
    
    always @(posedge Clock) begin
        DataInValid = 0;
        if (Cmd == St_Header) begin
            DataIn = InputLength;       
            DataInValid = 1;
            #(ClockCycle);
            DataInValid = 0;
            #(ClockCycle);
            
            while (DataOutValid !== 1) #(ClockCycle);
            DataIn = Program[0];       
            DataInValid = 1;
            #(ClockCycle);
            DataInValid = 0;
            #(ClockCycle);
        end else if (Cmd == St_InputEncryption) begin
            if (DataOutValid) begin
                DataIn = Inputs[DataOut]; // DataOut contains inputsRead
                DataInValid = 1;
                #(ClockCycle);
                DataInValid = 0;
                #(ClockCycle);
            end
        end else if (Cmd == St_ProgramLoad) begin
            if (DataOutValid) begin
                DataIn = Program[DataOut];
                DataInValid = 1;
                #(ClockCycle);
                DataInValid = 0;
                #(ClockCycle);
            end
        end else if (Cmd == St_Execute) begin
//            $finish;
        end
    end
    
    
    ClockSource #(ClockFreq) ClockGen(1'b1, Clock);
endmodule
