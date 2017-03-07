`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2015 11:55:25 PM
// Design Name: 
// Module Name: testSetup
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


module testSetup;
    `include "FSM.vh"
    wire                        Clock;
    reg                         Reset; // making this reg so that a value can be set if needed
    reg                         DataInValid;
    reg [DataWidth-1:0]         DataIn;
    wire [DataWidth-1:0]        DataOut;
    wire                        DataOutValid;
    wire [SetupStatesWidth-1:0] Cmd;
    reg [DataWidth-1:0]     Inputs [MaxInputLength-1:0];
    
    localparam                  InputLength = 3;
    
    Setup setup(    .Clock(         Clock),
                    .Reset(         Reset),
                    .DataIn(        DataIn),
                    .DataOut(       DataOut),
                    .DataInValid(   DataInValid),
                    .DataOutValid(  DataOutValid),
                    .Cmd(           Cmd)
    );

    initial begin
        Inputs[0] = 128'h00112233_44556677_8899aabb_ccddeeff;
        Inputs[1] = 128'h1;
        Inputs[2] = 19;
    end
    
    always @(negedge Clock) begin
        DataInValid = 0;
        if (Cmd == St_Header && DataOutValid) begin
            DataIn = InputLength;       
            DataInValid = 1;
            // $display("Sent InputLength in St_Header");          
        end else if (Cmd == St_InputEncryption && DataOutValid) begin
            DataIn = Inputs[DataOut];
            // $display("Asking for the %d th input = %d, %d", DataOut, Inputs[DataOut], DataIn);
            DataInValid = 1;
        end else if (Cmd == St_Execute) begin
            $finish;
        end
    end
    localparam  real 	Freq = 1000_000_000;
    ClockSource #(Freq) ClockGen(1'b1, Clock);
endmodule
