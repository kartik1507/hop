`timescale 1ns / 1ps
`include "Const.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2015 12:03:16 AM
// Design Name: 
// Module Name: ORAMWrap
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

module ORAMWrap(
      	Clock, Reset,

	Cmd, PAddr,
	CmdValid, CmdReady,

	InDataStore_wrap,
	InDataValid_wrap, InDataReady_wrap,

	OutDataLoad_wrap,
	OutDataValid_wrap, OutDataReady_wrap,

	DRAMAddress, DRAMCommand, DRAMCommandValid, DRAMCommandReady,
	DRAMReadData, DRAMReadDataValid,
	DRAMWriteData, DRAMWriteDataValid, DRAMWriteDataReady,
	
        oram_ctap_res_data
    );
        `ifdef SIMULATION_VIVADO
	parameter				NetworkWidth =		64; // Princeton's network
	parameter				JTPWidth =			8;
	`else
	`include "network_define.v"
	`include "jtag.vh"
	parameter				NetworkWidth =		`DATA_WIDTH;
	parameter				JTPWidth =			`JTAG_ORAM_DATA_WIDTH;
	`endif
	
	`include "PathORAM.vh"
	
	`include "DMLocal.vh"
	`include "DDR3SDRAMLocal.vh"
	`include "BucketLocal.vh"
	`include "CommandsLocal.vh"
	`include "JTAG.vh"
	//--------------------------------------------------------------------------
	//	System I/O
	//--------------------------------------------------------------------------

   input 					Clock, Reset;

	//--------------------------------------------------------------------------
	//	User interface
	//--------------------------------------------------------------------------

   input [BECMDWidth-1:0] 			Cmd;
   input [ORAMU-1:0] 				PAddr;
   input 					CmdValid;
   output 					CmdReady;

   input [ORAMB-1:0] 				InDataStore_wrap;
   input					InDataValid_wrap;
   output 					InDataReady_wrap;
   output [ORAMB-1:0] 				OutDataLoad_wrap;
   output 					OutDataValid_wrap;
   input 					OutDataReady_wrap;				
   

	//--------------------------------------------------------------------------
	//	DRAM interface
	//--------------------------------------------------------------------------

   output [DDRAWidth-1:0] 			DRAMAddress;
   output [DDRCWidth-1:0] 			DRAMCommand;
   output					DRAMCommandValid;
   input					DRAMCommandReady;
   input [NetworkWidth-1:0] 			DRAMReadData;
   input					DRAMReadDataValid;
   output [NetworkWidth-1:0] 			DRAMWriteData;
   output					DRAMWriteDataValid;
   input					DRAMWriteDataReady;

	//--------------------------------------------------------------------------
	//	Mode interface
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	JTAG interface [to Princeton]
	//--------------------------------------------------------------------------
   output [JTPWidth-1:0] 			oram_ctap_res_data;

   wire 			DataInReady;
   wire [FEDWidth-1:0] 		funnel_out_data;
   wire 			funnel_out_valid;
   wire [FEDWidth-1:0] 		load_funnel_data;
   wire 			load_funnel_ready;
   wire 			DataOutValid;
   wire 			OramDataOutValid_KillThisVariableSoon;
/*
 FIFOShiftRound #(            .IWidth(                ORAMB),
				.OWidth(                FEDWidth))
   cpu_to_oram_funnel(.Clock(                           Clock),
		   .Reset(                              Reset),
		   .InData(                             InDataStore_wrap),
		   .InValid(                            InDataValid_wrap),
		   .InAccept(                           InDataReady_wrap),
		   .OutData(                            funnel_out_data),
		   .OutValid(                           funnel_out_valid),
		   .OutReady(                           DataInReady)
		   );

      FIFOShiftRound #(.IWidth(FEDWidth),
		    .OWidth(ORAMB))
   oram_to_cpu_funnel(.Clock(                           Clock),
		      .Reset(                           Reset),
		      .InData(                          load_funnel_data),
		      .InValid(                         DataOutValid),
		      .InAccept(                        load_funnel_ready),
		      .OutData(                         OutDataLoad_wrap),
		      .OutValid(                        OutDataValid_wrap),
		      .OutReady(                        OutDataReady_wrap));
 
   // going to a smaller address space; TODO(kartiknayak): fix this later

  TinyORAMASICWrap ORAM2(	    .Clock(		Clock),
                                .Reset(                 Reset), // TODO(kartiknayak): check
                                
                                // interface with Setup            
                                .Cmd(                   Cmd),
                                .PAddr(                 PAddr),
                                .WMask(                 {DMWidth{1'b1}}),
                                .CmdValid(              CmdValid),
                                .CmdReady(              CmdReady),
                                .DataIn(                funnel_out_data),
				.DataInValid(           funnel_out_valid),
                                .DataInReady(           DataInReady),
				.DataOut(               load_funnel_data),
				.DataOutValid(          DataOutValid),
                                .DataOutReady(          load_funnel_ready), 
                                
                                
                                
                                // interface with DRAM        
                                .DRAMAddress(           DRAMAddress),
                                .DRAMCommand(           DRAMCommand),            
                                .DRAMCommandValid(      DRAMCommandValid),
                                .DRAMCommandReady(      DRAMCommandReady),    
                                .DRAMReadData(          DRAMReadData),
                                .DRAMReadDataValid(     DRAMReadDataValid),     
                                .DRAMWriteData(         DRAMWriteData),
                                .DRAMWriteDataValid(    DRAMWriteDataValid),
                                .DRAMWriteDataReady(    DRAMWriteDataReady),
                                .Mode_TrafficGen(       1'b0),
                                .Mode_DummyGen(         1'b0),
                                .ctap_oram_req_val(     1'b0),
                                .oram_ctap_res_data(    oram_ctap_res_data));
/* -----\/----- EXCLUDED -----\/-----

   always @(posedge Clock) begin
      if (CmdValid && CmdReady) begin
         $display("[%m @ %t] SDR Command a=%x c=%x", $time, PAddr, Cmd == BECMD_Read ? DDR3CMD_Read : DDR3CMD_Write);
      end
      if (funnel_out_valid && DataInReady) begin
         $display("[%m @ %t] SDR WRITE data transfer d=%x", $time, funnel_out_data);
      end
      if (DataOutValid && load_funnel_ready) begin
         $display("[%m @ %t] SDR READ data transfer d=%x", $time, load_funnel_data);
      end
   end
 -----/\----- EXCLUDED -----/\----- */



/* -----\/----- EXCLUDED -----\/-----
   always @(posedge Clock) begin
      if (DummyCmdValid && CmdReady) begin
         $display("[%m @ %t] SDR Command a=%x c=%x", $time, DummyPAddr, DummyCommand);
      end
      if (funnel_out_valid && DataInReady) begin
         $display("[%m @ %t] SDR WRITE data transfer d=%x", $time, DummyData);
      end
      if (DataOutValid && load_funnel_ready) begin
         $display("[%m @ %t] SDR READ data transfer d=%x", $time, load_funnel_data_DRAM);
      end
   end // always @ (posedge Clock)
 -----/\----- EXCLUDED -----/\----- */


   wire                                               DummyCmdValid;
   wire [2:0]                                         DummyCommand;
   wire [ORAMU-1:0]                                   DummyPAddr;
   wire [ORAMB-1:0]                                   funnel_out_data_DRAM;
   wire [ORAMB-1:0]                                   load_funnel_data_DRAM;
   wire [ORAMB-1:0]                                DummyData;
       
   assign DummyCmdValid = CmdValid; 
   assign DummyPAddr = PAddr;      
   assign DummyCommand = Cmd == BECMD_Read ? DDR3CMD_Read : DDR3CMD_Write;
   assign DummyData = funnel_out_data_DRAM;
   

     FIFOShiftRound #(            .IWidth(                ORAMB),
				.OWidth(                ORAMB))
   cpu_to_oram_funnel(.Clock(                           Clock),
		   .Reset(                              Reset),
		   .InData(                             InDataStore_wrap),
		   .InValid(                            InDataValid_wrap),
		      .InAccept(                           InDataReady_wrap),
		   .OutData(                            funnel_out_data_DRAM),
		   .OutValid(                           funnel_out_valid),
		   .OutReady(                           DataInReady)
		   );

      FIFOShiftRound #(.IWidth(ORAMB),
		    .OWidth(ORAMB))
   oram_to_cpu_funnel(.Clock(                           Clock),
		      .Reset(                           Reset),
		      .InData(                          load_funnel_data_DRAM),
		      .InValid(                         DataOutValid),
		      .InAccept(                        load_funnel_ready),
		      .OutData(                         OutDataLoad_wrap),
		      .OutValid(                        OutDataValid_wrap),
		      .OutReady(                        OutDataReady_wrap));
   
   localparam				InBufDepth = 6,
							OutInitLat = 2,
							OutBandWidth = 100,
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
                            
                                .CommandAddress(	        DummyPAddr << 3),
                                .Command(		        DummyCommand),
                                .CommandValid(		        DummyCmdValid),
                                .CommandReady(			CmdReady),
                            
                                .DataIn(		        DummyData),
                                .DataInMask(			8'h00), // TODO: this may get mis-aligned because of the shifters, but we won't change it anyway
                                .DataInValid(			funnel_out_valid),
                                .DataInReady(			DataInReady),
                            
                                .DataOut(			load_funnel_data_DRAM),
                                .DataOutValid(			DataOutValid),
                                .DataOutReady(			load_funnel_ready));

endmodule
