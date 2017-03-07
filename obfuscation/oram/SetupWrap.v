`timescale 1ns / 1ps
`include "Const.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2015 12:15:54 PM
// Design Name: 
// Module Name: SetupWrap
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


module SetupWrap(Clock, Reset,
    DataIn,
    DataInValid,
    DataInReady,
    DataOut,
    DataOutValid,
    DataOutReady,
    Cmd,
    DDR3SDRAM_Address,
    DDR3SDRAM_Command,            
    DDR3SDRAM_CommandValid,
    DDR3SDRAM_CommandReady,    
    DDR3SDRAM_ReadData, // i
    DDR3SDRAM_ReadValid,    // i    
    DDR3SDRAM_WriteData, // o
    DDR3SDRAM_WriteValid, // o
    DDR3SDRAM_WriteReady // i
    );
    `include "FSM.vh"
    `include "PathORAM.vh"
        
    `include "DMLocal.vh"
    `include "DDR3SDRAMLocal.vh"
    `include "BucketLocal.vh"
    `include "CommandsLocal.vh"
    `include "JTAG.vh"
    
    parameter				NetworkWidth =		64; // Princeton's network
    parameter               JTPWidth =            8;
    
    wire 						Clock; 
    wire                        Reset; 
    input                   Clock;
    input                   Reset;
    input[DataWidth-1:0]    DataIn;
    input                   DataInValid;
    output                  DataInReady;
    
    output[DataWidth-1:0]   DataOut;
    output                  DataOutValid;
    input                   DataOutReady;
    
    output[SetupStatesWidth-1:0]                  Cmd;
    
    //--------------------------------------------------------------------------
    //    DRAM interface
    //--------------------------------------------------------------------------

    output    [DDRAWidth-1:0]    DDR3SDRAM_Address;
    output    [DDRCWidth-1:0]    DDR3SDRAM_Command;
    output                    DDR3SDRAM_CommandValid;
    input                    DDR3SDRAM_CommandReady;

    input    [NetworkWidth-1:0] DDR3SDRAM_ReadData;
    input                    DDR3SDRAM_ReadValid;

    output    [NetworkWidth-1:0] DDR3SDRAM_WriteData;
    output                    DDR3SDRAM_WriteValid;
    input                    DDR3SDRAM_WriteReady;
    
    // wires for ORAM
    wire                         CmdInValidORAM, DataInValidORAM, ReturnDataReadyORAM;
    wire                        CmdInReadyORAM, DataInReadyORAM, ReturnDataValidORAM;
    wire [1:0]                   CmdInORAM;
    wire [ORAMU-1:0]             AddrInORAM;
    // reg [DMWidth-1:0]           WMaskIn;
    wire [FEDWidth-1:0]         ReturnDataORAM;
    wire  [FEDWidth-1:0]         DataInORAM;
    
    wire    [DDRCWidth-1:0]     DDR3SDRAM_Command;
    wire    [DDRAWidth-1:0]     DDR3SDRAM_Address;
    wire    [NetworkWidth-1:0]  DDR3SDRAM_WriteData, DDR3SDRAM_ReadData; 

    wire    [DDRDWidth-1:0]     DDR3SDRAM_ReadData_Wide,    DDR3SDRAM_ReadData_Wide_Pre;
    wire                        DDR3SDRAM_ReadValid_Wide,     DDR3SDRAM_ReadReady_Wide;
    wire                        DDR3SDRAM_ReadValid_Wide_Pre, DDR3SDRAM_ReadReady_Wide_Pre;
    
    wire    [DDRDWidth-1:0]     DDR3SDRAM_WriteData_Wide;
    wire                        DDR3SDRAM_WriteValid_Wide, DDR3SDRAM_WriteReady_Wide;
    
    wire                        DDR3SDRAM_CommandValid, DDR3SDRAM_CommandReady;
    wire                        DDR3SDRAM_WriteValid, DDR3SDRAM_WriteReady;
    wire                        DDR3SDRAM_ReadValid;
    wire	[JTPWidth-1:0]	oram_ctap_res_data;
    TinyORAMASICWrap ORAM(	    .Clock(					Clock),
                                .Reset(                 Reset),
                                
                                // interface with Setup            
                                .Cmd(                   CmdInORAM),
                                .PAddr(                 AddrInORAM),
                                .WMask(                 {DMWidth{1'b1}}),
                                .CmdValid(              CmdInValidORAM),
                                .CmdReady(              CmdInReadyORAM),
                                .DataInReady(           DataInReadyORAM), 
                                .DataInValid(           DataInValidORAM), 
                                .DataIn(                DataInORAM),                                    
                                .DataOutReady(          ReturnDataReadyORAM), 
                                .DataOutValid(          ReturnDataValidORAM), 
                                .DataOut(               ReturnDataORAM),
                                
                                // interface with DRAM        
                                .DRAMAddress(           DDR3SDRAM_Address),
                                .DRAMCommand(           DDR3SDRAM_Command),            
                                .DRAMCommandValid(      DDR3SDRAM_CommandValid),
                                .DRAMCommandReady(      DDR3SDRAM_CommandReady),    
                                .DRAMReadData(          DDR3SDRAM_ReadData),
                                .DRAMReadDataValid(     DDR3SDRAM_ReadValid),     
                                .DRAMWriteData(         DDR3SDRAM_WriteData),
                                .DRAMWriteDataValid(    DDR3SDRAM_WriteValid),
                                .DRAMWriteDataReady(    DDR3SDRAM_WriteReady),
                                
                                .Mode_TrafficGen(       1'b0), // For the chip, just run traffic gen for a long time
                                .Mode_DummyGen(         1'b0),
                                
                                .ctap_oram_req_val(     1'b0),
                                .oram_ctap_res_data(    oram_ctap_res_data));
     
     // internal wires for setup
     wire [DataWidth-1:0]         DataOut;
     wire                         DataOutValid;
     wire [SetupStatesWidth-1:0]  Cmd;
     wire [BECMDWidth-1:0]        CmdSetup;
     wire [ORAMU-1:0]          PAddrSetup;
     wire                         CmdValidSetup, CmdReadySetup;
     wire                         DataInValidSetup, DataInReadySetup, DataOutValidSetup, DataOutReadySetup;
     wire [FEDWidth-1:0]          DataInSetup, DataOutSetup;
                             
     Setup setup(               .Clock(                 Clock),
                                .Reset(                 Reset),
                                
                                .DataIn(        DataIn),
                                .DataOut(       DataOut),
                                .DataOutReady(  DataOutReady),
                                .DataInReady(   DataInReady),
                                .DataInValid(   DataInValid),
                                .DataOutValid(  DataOutValid),
                                .Cmd(           Cmd),
                                
                                // interface with ORAM
                                .CmdORAM(       CmdSetup), // o
                                .PAddrORAM(     PAddrSetup), // o
                                .CmdValidORAM(  CmdValidSetup), // o
                                .CmdReadyORAM(  CmdReadySetup), // i
                                
                                .DataInORAM(    DataInSetup), // o
                                .DataInValidORAM(DataInValidSetup), // i
                                .DataInReadyORAM(DataInReadySetup), //o
                                .DataOutORAM(   DataOutSetup), // o
                                .DataOutValidORAM(DataOutValidSetup), // o
                                .DataOutReadyORAM(DataOutReadySetup) // i
     );
     
     assign CmdInORAM =              CmdSetup;
     assign AddrInORAM =            PAddrSetup;
     assign CmdInValidORAM =         CmdValidSetup;
     assign CmdReadySetup =        CmdInReadyORAM;
//     assign DataInSetup =          DataInORAM;
//     assign DataInValidSetup =    DataInValidORAM;
     // assign DataInReadyORAM =       DataInReadySetup;
     assign DataInORAM =          DataInSetup;
     assign DataInValidORAM =       DataInValidSetup;
     assign DataInReadySetup =       DataInReadyORAM;
     assign DataOutSetup =          ReturnDataORAM;
     assign DataOutValidSetup =     ReturnDataValidORAM;
     assign ReturnDataReadyORAM    =     DataOutReadySetup;
endmodule
