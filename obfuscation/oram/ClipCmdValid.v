`timescale 1ns / 1ps
`include "Const.vh"

module ClipCmdValid(Clock, Reset, InCmdValid, InCmdReady, InCmd, OutCmdValid, io_dmem_resp_valid);
`include "FSM.vh"
`include "PathORAM.vh"
`include "DMLocal.vh"
`include "DDR3SDRAMLocal.vh"
`include "BucketLocal.vh"
`include "CommandsLocal.vh"
`include "JTAG.vh"
`include "PLBLocal.vh"
`include "UORAM.vh"

   input Clock;
   
   input  Reset;
   
   input  InCmdValid;
   
   input  InCmdReady;
   
   input [BECMDWidth-1:0]  InCmd;
   output OutCmdValid;
   input   io_dmem_resp_valid;
   

    reg OutCmdValid;
   reg 	LastOutCmdValid;
   reg 	load_started;
   
   initial begin
      LastOutCmdValid = 1'b0;
      load_started = 1'b0;
   end
   
    always @(posedge Clock) begin
       OutCmdValid = InCmdValid;
       // $display("In ClipCmdValid: %d, %d, %d", InCmdValid, InCmdReady, LastOutCmdValid);
       
        if (InCmdValid & InCmdReady & LastOutCmdValid) begin
	   OutCmdValid = 1'b0;
           // $display("all three signals high");
           
	   if (InCmd == BECMD_Read) begin
	      load_started = 1'b1;
              // $display("and I can see load started");
              
	   end
	end

       if (load_started) begin
	  OutCmdValid = 1'b0;
       end

       if (io_dmem_resp_valid) begin
	  OutCmdValid = 1'b0;
	  load_started = 1'b0;
       end
	  
       LastOutCmdValid = OutCmdValid;
    end
endmodule
