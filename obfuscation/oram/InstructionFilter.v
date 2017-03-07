`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2015 04:02:29 PM
// Design Name: 
// Module Name: InstructionFilter
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


module InstructionFilter(Clock, Reset, InInstRespValid, InInstRespData, OutInstRespValid, OutInstRespData, isNextReqSpld, MemSize, isMemReplaceable, IFSPCmdValid, IFSPCmdReady);
   input   Clock;
   input   Reset;
   input   InInstRespValid;
   input [31:0]   InInstRespData;
   output  OutInstRespValid;
   output [31:0] OutInstRespData;
   reg 	   OutInstRespValid;
   reg [31:0] OutInstRespData;
   reg [15:0] MemSize;
   reg        isMemReplaceable;
   
   output isNextReqSpld;
   reg    isNextReqSpld;
   output [15:0] MemSize;
   output        isMemReplaceable;
   
   output        IFSPCmdValid;
   input         IFSPCmdReady;
   reg           IFSPCmdValid;
   reg [1:0]     waiting;
   // reg           yetToRouteSW;
   reg [2:0]     yetToRouteSWwait;
   
   
   

   always @(posedge Clock) begin
      OutInstRespValid = InInstRespValid;
      OutInstRespData = InInstRespData;

      if (waiting !== 0) begin
         OutInstRespData = 32'h00008093; // mv ra, ra
         waiting = waiting - 1;
         IFSPCmdValid = 0;
         
      end else if ((InInstRespValid == 1) & (InInstRespData[14:0] == 15'b011000000000011) & IFSPCmdReady) begin
         MemSize = InInstRespData[30:15];
	 OutInstRespData = 32'h00008093; // mv ra, ra
         isMemReplaceable = InInstRespData[31:31];
	 // $display("hello ist me %d", MemSize);
         isNextReqSpld = 1;
         IFSPCmdValid = 1;
         waiting = 1;
         yetToRouteSWwait = 5;
         
      // end else if (InInstRespValid & (InInstRespData[14:0] == 15'b011000000000011) & !IFSPCmdReady) begin // halt the CPU until scratch pad is ready to accept this instruction (which can be non-data instruction)
      end else if (!IFSPCmdReady & (isNextReqSpld | ((InInstRespValid == 1) & (InInstRespData[14:0] == 15'b011000000000011)))) begin
         if (yetToRouteSWwait !== 0) begin
            yetToRouteSWwait = yetToRouteSWwait - 1;
            if (((InInstRespValid == 1) & (InInstRespData[14:0] == 15'b011000000000011))) begin
               OutInstRespValid = 0;
               OutInstRespData = 32'b0;
               end

         end else begin
            OutInstRespValid = 0;
            OutInstRespData = 32'b0;
         end
         
      end else begin
         isNextReqSpld = 0; // this is not necessary, IFSPCmdValid should take care
         // IFSPCmdValid = 0;
      end // else: !if(!IFSPCmdReady)
      // $display("[%m @ %t] Filter OutInstRespValid=%d, OutInstRespData=%x", $time, OutInstRespValid, OutInstRespData);
      
   end // always @ (posedge Clock)

   initial begin
      waiting = 0;
      // yetToRouteSW;
      yetToRouteSWwait = 0;
      IFSPCmdValid = 0;
      isMemReplaceable = 0;
      
   end
   
endmodule
