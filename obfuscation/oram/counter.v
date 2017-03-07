`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2015 04:14:33 PM
// Design Name: 
// Module Name: counter
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
//assertion to check not unaligned
/*
module counter(Clock, Reset, InValid, OutValid, InDataMemRespValid, InDataMemReqValid);
    input Clock;
    input Reset;
    input InValid;
    input InDataMemRespValid;
    input InDataMemReqValid;
    output OutValid;
    reg [1:0] ctr;
    reg OutValid;
    reg WasReqDataValidTurnedOn;
    reg WasReqDataValidTurnedOn_temp;
    
    initial begin
        ctr = 2'h0;
        WasReqDataValidTurnedOn = 0; // TODO(kartiknayak): verify that this is not a hack
        WasReqDataValidTurnedOn_temp = 0;
    end
    always @(posedge Clock) begin
        if (OutValid == 1'b1) begin
            WasReqDataValidTurnedOn_temp <= InDataMemReqValid;
            // not (if data request valid was turned on i.e. it is a memory instruction)
            if (WasReqDataValidTurnedOn == 0) begin
                OutValid <= 1'b0; // assuming all other instructions just take a single cycle?
                WasReqDataValidTurnedOn <= WasReqDataValidTurnedOn_temp;
            end else if (InDataMemRespValid & InDataMemReqValid) begin
                ctr <= 2'h0; // just making sure
                OutValid <= 1'b0;
                // here InDataMemReqValid is always high, but a data request is just finished,
                // hence should definitely wait for instruction fetch
                WasReqDataValidTurnedOn <= 0; 
            end
            // otherwise OutValid remains high
        end else begin
            OutValid <= 1'b0;
            if (Reset)
                ctr <= 0;
            else if (InValid == 1'b0)
                ctr <= 0;
            else if (InValid == 1'b1) begin
//                if (ctr == 0) begin
//                    WasReqDataValidTurnedOn = InDataMemReqValid;
//                    $display("hello %b", InDataMemReqValid);
//                end
                ctr <= ctr + 1;
                if (ctr == 3) begin
                    OutValid <= 1'b1;
                    ctr <= 0;
                end
            end
        end
    end
endmodule
*/

module counter(Clock, Reset, InValid, OutValid, InDataMemRespValid, InDataMemReqValid, InData, OutData);
    input Clock;
    input Reset;
    input InValid;
    input InDataMemRespValid;
    input InDataMemReqValid;
   input [31:0] InData;
   output [31:0] OutData;
   
    output OutValid;
    reg [2:0] ctr;
    reg OutValid;
   reg [31:0] OutData;
   
//    reg WasReqDataValidTurnedOn;
//    reg WasReqDataValidTurnedOn_temp;
    reg WaitForDResp;
    
    initial begin
        ctr = 3'h0;
//        WasReqDataValidTurnedOn = 0; // TODO(kartiknayak): verify that this is not a hack
//        WasReqDataValidTurnedOn_temp = 0;
        WaitForDResp = 0;
    end
    always @(posedge Clock) begin
       // $display("Counter %d, %d, %d, %d", OutValid, InDataMemReqValid, InDataMemRespValid, WaitForDResp);
       
        if (OutValid == 1'b1 & InDataMemReqValid == 1'b1 & InDataMemRespValid == 1'b0) begin
            WaitForDResp = 1;
           // $display("WaitForDResp high");
           
        end else if (WaitForDResp == 1 & InDataMemRespValid == 1'b0) begin
            OutValid = 1;
           // $display("Waiting for DResp");
           
        end else if (WaitForDResp == 1 & InDataMemRespValid == 1'b1) begin // data returned, end of instruction
            OutValid = 0;
            WaitForDResp = 0;
           // $display("Received DResp, outvalid will be 0 now");
           
        end else if (OutValid == 1'b1) begin // only instruction case, dreq = 0
            WaitForDResp = 0;
            OutValid = 0;
           // $display("Out valid 0 now");
           
        end else begin
            OutValid = 1'b0;
            if (Reset)
                ctr = 0;
            else if (InValid == 1'b0)
                ctr = 0;
            else if (InValid == 1'b1) begin
//                if (ctr == 0) begin
//                    WasReqDataValidTurnedOn = InDataMemReqValid;
//                    $display("hello %b", InDataMemReqValid);
//                end
                ctr = ctr + 1;
                if (ctr == 2) begin
                    OutValid = 1'b1;
                   OutData = InData;
                    ctr = 0;
                end
            end
        end
    end
endmodule

