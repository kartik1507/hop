`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2015 01:51:55 PM
// Design Name: 
// Module Name: shifter
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


module shifter(Clock, Reset, InData, OutData
    , InValid, OutValid
    );
    input Clock;
    input Reset;
    input [31:0] InData;
    output [31:0] OutData;
    input InValid;
    output OutValid;
    parameter DELAY = 1;
    integer i;
    
    reg [DELAY-1:0] shift_reg[31:0];
    reg [DELAY-1:0] valid_shift_reg;
    
    always @(posedge Clock) begin
        for (i = 0; i < 32; i = i+1) begin
            shift_reg[i] <= {shift_reg[i][DELAY-2:0], InData[i]};
        end
        valid_shift_reg <= {valid_shift_reg[DELAY-2:0], InValid};
    end
    
    genvar x;
    generate for (x = 0; x < 32; x = x + 1) begin: va
        assign OutData[x] = shift_reg[x][DELAY-1];
    end
    assign OutValid = valid_shift_reg[DELAY-1];
    endgenerate
endmodule
