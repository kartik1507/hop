`timescale 1ns / 1ps
`include "Const.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2015 04:45:55 PM
// Design Name: 
// Module Name: testCPU
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


module testCPU;
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
    reg [DataWidth-1:0]            Program [MaxProgramLength-1:0];
    
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
    
    wire    [DDRDWidth-1:0]        DDR3SDRAM_ReadData_Wide,    DDR3SDRAM_ReadData_Wide_Pre;
    wire                        DDR3SDRAM_ReadValid_Wide,     DDR3SDRAM_ReadReady_Wide;
    wire                        DDR3SDRAM_ReadValid_Wide_Pre, DDR3SDRAM_ReadReady_Wide_Pre;
    
    wire    [DDRDWidth-1:0]        DDR3SDRAM_WriteData_Wide;
    wire                        DDR3SDRAM_WriteValid_Wide, DDR3SDRAM_WriteReady_Wide;
   wire 			initializtion_done;
   
    
    localparam                  InputLength = 3;
    localparam                    ProgramLength = 3;
    
    SodorTile cpu(.clk(                             Clock),
                  .io_host_reset(                   Reset),
                  .io_host_debug_stats_csr(                 ),
                  .io_host_id(                      1'h0 ),
                  .io_host_csr_req_ready(           ),
                  .io_host_csr_req_valid(               0),
                  .io_host_csr_req_bits_rw(         0),
                  .io_host_csr_req_bits_addr(       0),
                  .io_host_csr_req_bits_data(       0),
                  .io_host_csr_rep_ready(           0),
                  .io_host_csr_rep_valid(           ),
                  .io_host_csr_rep_bits(            ),
                  .io_host_ipi_req_ready(               0),
                  .io_host_ipi_req_valid(           ),
                  .io_host_ipi_req_bits(            ),
                  .io_host_ipi_rep_ready(           ),
                  .io_host_ipi_rep_valid(           0),
                  .io_host_ipi_rep_bits(            0),
                  .io_host_mem_req_ready(           ),
                  .io_host_mem_req_valid(           0),
                  .io_host_mem_req_bits_rw(         0),
                  .io_host_mem_req_bits_addr(       0),
                  .io_host_mem_req_bits_data(       0),
                  .io_host_mem_rep_valid(           ),
                  .io_host_mem_rep_bits(            ),
                  .DDR3SDRAM_Address(               DDR3SDRAM_Address),
                  .DDR3SDRAM_Command(               DDR3SDRAM_Command),
                  .DDR3SDRAM_CommandValid(          DDR3SDRAM_CommandValid),
                  .DDR3SDRAM_CommandReady(          DDR3SDRAM_CommandReady),
    
                  .DDR3SDRAM_ReadData(              DDR3SDRAM_ReadData),
                  .DDR3SDRAM_ReadValid(             DDR3SDRAM_ReadValid),
    
                  .DDR3SDRAM_WriteData(             DDR3SDRAM_WriteData),
                  .DDR3SDRAM_WriteValid(            DDR3SDRAM_WriteValid),
                  .DDR3SDRAM_WriteReady(            DDR3SDRAM_WriteReady),
		  .initialization_done(             initialization_done)
    );

    FIFOShiftRound #(        .IWidth(                DDRDWidth),
                                .OWidth(                NetworkWidth),
                                .Reverse(                1))
                    in_shft(    .Clock(                    Clock),
                                .Reset(                    Reset & !initialization_done),
                                .InData(                DDR3SDRAM_ReadData_Wide),
                                .InValid(                DDR3SDRAM_ReadValid_Wide),
                                .InAccept(                DDR3SDRAM_ReadReady_Wide),
                                .OutData(                DDR3SDRAM_ReadData),
                                .OutValid(                DDR3SDRAM_ReadValid),
                                .OutReady(                1'b1));
                                
    FIFOShiftRound #(        .IWidth(                NetworkWidth),
                            .OWidth(                DDRDWidth),
                            .Reverse(                1))
                out_shft(    .Clock(                    Clock),
                            .Reset(                    Reset & !initialization_done),
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
                            .Reset(                    Reset & !initialization_done),
                            .InData(                DDR3SDRAM_Address),
                            .InValid(                DDR3SDRAM_Command == DDR3CMD_Read && DDR3SDRAM_CommandValid && DDR3SDRAM_CommandReady),
                            .InAccept(                ),
                            .OutData(                DRAMReadAddr),
                            .OutSend(                DRAMReadAddrValid),
                            .OutReady(                DDR3SDRAM_ReadValid_Wide && DDR3SDRAM_ReadReady_Wide));
                                
    localparam                InBufDepth = 6,
                            OutInitLat = 30,
                            OutBandWidth = 57,
                            InBandWidth = 100;
    SynthesizedRandDRAM    #(    .InBufDepth(            InBufDepth),
                            .OutInitLat(            OutInitLat),
                            .OutBandWidth(            OutBandWidth),
                            .InBandWidth(            InBandWidth),
                            .UWidth(                64),
                            .AWidth(                DDRAWidth),
                            .DWidth(                DDRDWidth),
                            .BurstLen(                1),
                            .EnableMask(            1),
                            .Class1(                1),
                            .RLatency(                1),
                            .WLatency(                1)) 
        ddr3model(            .Clock(                    Clock),
                            .Reset(                    Reset & !initialization_done),
                            
                            .CommandAddress(        DDR3SDRAM_Address),
                            .Command(                DDR3SDRAM_Command),
                            .CommandValid(            DDR3SDRAM_CommandValid),
                            .CommandReady(            DDR3SDRAM_CommandReady),
                            
                            .DataIn(                DDR3SDRAM_WriteData_Wide),
                            .DataInMask(            8'h00), // TODO: this may get mis-aligned because of the shifters, but we won't change it anyway
                            .DataInValid(            DDR3SDRAM_WriteValid_Wide),
                            .DataInReady(            DDR3SDRAM_WriteReady_Wide),
                            
                            .DataOut(                DDR3SDRAM_ReadData_Wide_Pre),
                            .DataOutValid(            DDR3SDRAM_ReadValid_Wide_Pre),
                            .DataOutReady(            DDR3SDRAM_ReadReady_Wide_Pre));
    
    FIFORAM    #(                .Width(                    DDRDWidth),
                            .Buffering(                1023))
        rd_data(            .Clock(                    Clock),
                            .Reset(                    Reset & !initialization_done),
                            .InData(                DDR3SDRAM_ReadData_Wide_Pre),
                            .InValid(                DDR3SDRAM_ReadValid_Wide_Pre),
                            .InAccept(                DDR3SDRAM_ReadReady_Wide_Pre),
                            .OutData(                DDR3SDRAM_ReadData_Wide),
                            .OutSend(                DDR3SDRAM_ReadValid_Wide),
                            .OutReady(                DDR3SDRAM_ReadReady_Wide));
                                                        
    reg [7:0] i;
    initial begin
       Reset = 1;
       #(ClockCycle);
       Reset = 0;
        $display("Starting initialization -------------------------");
       while(initialization_done == 1'b0) #(ClockCycle);
       $display("Initialization done-------------------------");
        Reset = 1;
        #(ClockCycle * 10);
        Reset = 0;
        $display("Starting Execution -------------------------");
    end
    
    ClockSource #(ClockFreq) ClockGen(1'b1, Clock);
endmodule

