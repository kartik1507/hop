`timescale 1ns / 1ps
`include "Const.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2015 10:46:02 PM
// Design Name: 
// Module Name: Setup
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


module Setup(Clock, Reset,
    DataIn, DataInValid, DataInReady,
    DataOut, DataOutValid, DataOutReady,
    Cmd,
    
    // interface with ORAM
    CmdORAM,
    PAddrORAM,
    CmdValidORAM,
    CmdReadyORAM,
    
    DataInORAM,
    DataInValidORAM,
    DataInReadyORAM,
    
    DataOutORAM,
    DataOutValidORAM,
    DataOutReadyORAM

    );
    `include "FSM.vh"
    `include "PathORAM.vh"
        
    `include "DMLocal.vh"
    `include "DDR3SDRAMLocal.vh"
    `include "BucketLocal.vh"
    `include "CommandsLocal.vh"
    `include "JTAG.vh"
    `include "PLBLocal.vh"
    `include "UORAM.vh"
    
    input                   Clock, Reset;
    input[DataWidth-1:0]    DataIn;
    input                   DataInValid;
    output                  DataInReady; // unused
    
    output[DataWidth-1:0]   DataOut;
    output                  DataOutValid;
    input                   DataOutReady; // unused
    
    output[SetupStatesWidth-1:0]                  Cmd;
    
    // outputs/inputs to/from ORAM
    output [BECMDWidth-1:0] CmdORAM;
    output [ORAMU-1:0]      PAddrORAM;
    output                  CmdValidORAM;
    input                   CmdReadyORAM;
    
    output [FEDWidth-1:0]   DataInORAM;
    output                  DataInValidORAM;
    input                   DataInReadyORAM;
    
    input [FEDWidth-1:0]    DataOutORAM;
    input                   DataOutValidORAM;
    output                  DataOutReadyORAM;                 
    
    reg [SetupStatesWidth-1:0]   CS, NS;
    reg [MaxInputWidth-1:0]      InputLength;
    reg [MaxInputWidth-1:0]      InputsRead;
    reg [MaxProgramWidth-1:0]    InstructionsRead;
    reg                         Done;
    reg [DataWidth-1:0]      Inputs [MaxInputLength-1:0]; // temporary, kill this soon
    reg [DataWidth-1:0]         DataOut;
    reg                         DataOutValid;
    wire                        DataOutReady;
    reg                         DataInReady;
    reg [SetupStatesWidth-1:0]  Cmd;
    reg [DataWidth-1:0]     Program[MaxProgramLength-1:0];
    
    // internal wires/reg for with aes_128
    wire [AESWidth-1:0]                DataOut_AES;
    reg [AESWidth-1:0]                 DataIn_AES;
    reg [AESWidth-1:0]                 Ctr;
    reg [AESWidth-1:0]                 EncData;
    
    // wires/reg for interface with ORAM
    reg   [BECMDWidth-1:0] CmdORAM;
    reg   [ORAMU-1:0]      PAddrORAM;
    reg                    CmdValidORAM;
    wire                   CmdReadyORAM;
    
    reg   [FEDWidth-1:0]   DataInORAM;
    reg                    DataInValidORAM;
    wire                   DataInReadyORAM;
    
    wire [FEDWidth-1:0]    DataOutORAM;
    wire                   DataOutValidORAM;
    reg                    DataOutReadyORAM;
    
    reg                    ResetPulsed;
    integer                i;
    reg   [BECMDWidth-1:0] CmdORAM_temp;
    reg   [ORAMU-1:0]      PAddrORAM_temp;
    reg                    StartedORAMAccesses;
    
    // internal CPU registers
    reg [DataWidth-1:0]      r[MaxRegisters:0];
    reg [MaxProgramWidth-1:0] eip;
    reg [DataWidth-1:0]      Inst;
    reg [5:0]              Opcode;
    reg [15:0]             ImmediateAddress;
    reg [FEDWidth-1:0]     DataReadFromORAM;
    
    aes_128 tiny_aes(		.clk(					Clock),
                            .state(                 DataIn_AES),
                            .key(                   128'h00010203_04050607_08090a0b_0c0d0e0f), 
                            .out(                   DataOut_AES));

    initial begin
        CS = St_Initial;
        ResetPulsed = 0;
        InputsRead = 0;
        InstructionsRead = 0;
        CmdValidORAM = 0;
        DataInValidORAM = 0;
        DataOutReadyORAM = 0;
        Done = 0;
        Ctr = 0;
        PAddrORAM = 0;
        DataInORAM = 0;
        StartedORAMAccesses = 0;
        DataInReady = 0;
        eip = 1;
        Opcode = 0;
        ImmediateAddress = 0;
    end
    
    always @(negedge Clock) begin
       if (ResetPulsed || Reset == 1) ResetPulsed = 1;
       else ResetPulsed = 0; 
    end
    
    always @(posedge Clock) begin
        if (Reset) CS <= St_Initial;
        else CS <= NS;
    end
    
    always @(*) begin
        while (ResetPulsed !== 1) #(ClockCycle);
        NS = CS;
//        $display("CS = %d, %d", CS, ResetPulsed);
        case (CS)
            St_Initial: begin
                NS = St_Header;
//                $display("Switching to St_Header %d, %d ", Done, ResetPulsed);
                Done = 0;
            end
            St_Header: begin
//                $display("St_Header %d %d ", Done, ResetPulsed);
                if (Done) begin
//                    $display("Switching to St_InputEncryption %d %d", Done, ResetPulsed);
                    NS = St_InputEncryption;
                    Done = 0;
                end
            end
            St_InputEncryption: begin
//                $display("Input Encryption %d %d:", Done, ResetPulsed);
                if (Done) begin
//                    $display("Switching to Program load %d %d ", Done, ResetPulsed);
                    NS = St_ProgramLoad;
                    Done = 0;
                    i = 0;
                end
            end
            St_ProgramLoad: begin
//                $display("Program Load %d %d:", Done, ResetPulsed);
                if (Done) begin
//                    $display("Switching to St_Execute %d %d ", Done, ResetPulsed);
                    NS = St_Execute;
                    Done = 0;
                end
            end
            St_Execute: begin
//                $display("Reached St_Execute in state machine");
            end
        endcase
    end
    
    always @(*) begin
        while (ResetPulsed !== 1) #(ClockCycle);
        DataOutValid = 0;
        if (CS == St_Header) begin
            // the communication here is a little ugly
            Cmd = CS;
            #(ClockCycle) while (DataInValid == 0) #(ClockCycle);
            InputLength = DataIn;
            
            DataOutValid = 1; // just used as a dummy signal
            #(ClockCycle); while (DataInValid == 0) #(ClockCycle);
            Program[0] = DataIn;
            Done = 1;
        end else if (CS == St_InputEncryption && !StartedORAMAccesses) begin
            Cmd = CS;
//            while ((ResetPulsed && !Reset && CmdReadyORAM) !== 1) begin
//                #(ClockCycle);
//            end

            // send command
//            CmdORAM_temp = BECMD_Append;
            PAddrORAM_temp = 0; // start at 0th location
//            Task_StartORAMAccess(CmdORAM_temp, PAddrORAM_temp, Ctr);
            
            
            PAddrORAM_temp = 0;
            while (InputsRead < InputLength) begin
                $display("-------------");
                DataOut = InputsRead;
                DataOutValid = 1;
                #(ClockCycle) while (DataInValid !== 1) #(ClockCycle); // change 1 to cycle
                $display("Input[%d] = %d", InputsRead, DataIn);
                Inputs[InputsRead] = DataIn; // this should actually be sent back to ORAM for insertion
                // encrypt data
                /*DataIn_AES = Ctr;
                $display("After %h", DataIn_AES);
                #21;
                EncData = DataOut_AES ^ DataIn; 
                $display("encrypted data = %h, %h", EncData, DataIn);*/
                while ((ResetPulsed && !Reset && CmdReadyORAM) !== 1) begin
                    #(ClockCycle);
                end
                Ctr = Ctr + 1;
                CmdORAM_temp = BECMD_Append;
                Task_StartORAMAccess(CmdORAM_temp, PAddrORAM_temp, Inputs[InputsRead]);
                InputsRead = InputsRead + 1;
                PAddrORAM_temp = PAddrORAM_temp + 1;
            end
            // an extra read to check
            /*CmdORAM_temp = BECMD_Read;
            PAddrORAM_temp = 2;
            Task_StartORAMAccess(CmdORAM_temp, PAddrORAM_temp, 0);*/
            Done = 1;
        end else if (CS == St_ProgramLoad && Cmd != St_ProgramLoad) begin
            Cmd = CS;
            $display("At St_ProgramLoad; Program[%d] = %d", InstructionsRead, Program[InstructionsRead]);
            InstructionsRead = InstructionsRead + 1;
            while (InstructionsRead < Program[0]) begin
                DataOut = InstructionsRead;
                DataOutValid = 1;
                #(ClockCycle) while (DataInValid !== 1) #(ClockCycle);
                Program[InstructionsRead] = DataIn;
                $display("At St_ProgramLoad; Program[%d] = %d", InstructionsRead, Program[InstructionsRead]);
                InstructionsRead = InstructionsRead + 1;
            end
            Done = 1;
        end else if (CS == St_Execute) begin
            $display("At St_Execute");
            Cmd = CS;
            for (i = 0; i < Program[0]; i = i + 1) begin
                $display("Program[%d] = %d", i, Program[i]);
            end
            
            while (eip !== Program[0] - 1) begin
                $display("Eip = %d", eip);
                Inst = Program[eip];
                Opcode = Inst[31:26];
                case (Opcode)
                    6'h23: begin // lw r1, 35
                            ImmediateAddress = Inst[15:0];
                            // read from memory
                            CmdORAM_temp = BECMD_Read;
                            PAddrORAM_temp = ImmediateAddress;
                            Task_StartORAMAccess(CmdORAM_temp, PAddrORAM_temp, 0);
                            r[Inst[20:16]] = DataReadFromORAM;
                            $display("lw %d, %d = %d", Inst[20:16], ImmediateAddress, DataReadFromORAM);
                            eip = eip + 1;
                    end
                    6'h2B:  begin // sw r1, 35
                            ImmediateAddress = Inst[15:0];
                            // write to memory
                            CmdORAM_temp = BECMD_Update;
                            PAddrORAM_temp = ImmediateAddress;
                            Task_StartORAMAccess(CmdORAM_temp, PAddrORAM_temp, r[Inst[20:16]]);
                            $display("sw %d, %d = %d", Inst[20:16], ImmediateAddress, r[Inst[20:16]]);
                            eip = eip + 1;
                    end
                    6'h20:  begin // add $d, $s, $t - what does shift amount and func do?
                            r[Inst[15:11]] = r[Inst[25:21]] + r[Inst[20:16]];
                            eip = eip + 1;
                            $display("add %d, %d, %d", r[Inst[15:11]], r[Inst[25:21]], r[Inst[20:16]]);
                    end
                    6'h24:  begin
                            r[Inst[15:11]] = r[Inst[25:21]] & r[Inst[20:16]];
                            eip = eip + 1;
                            $display("and %d, %d, %d", r[Inst[15:11]], r[Inst[25:21]], r[Inst[20:16]]);
                    end
                    6'h2:   begin // srl $d,$t,shamt
//                            r[Inst[15:11]] // d
//                            r[Inst[20:16]] // t
//                            Inst[10:6]// shamt
                            $display("srl %d, %d, %d", r[Inst[15:11]], r[Inst[20:16]], Inst[10:6]);
                            r[Inst[15:11]] = r[Inst[20:16]] >> Inst[10:6];
                            eip = eip + 1;
                            $display("Dest = %d", r[Inst[15:11]]);
                    end
                    default begin
                        $display("End of execution default");
                        $finish;
                    end
                endcase
            end
            $display("End of execution");
            $finish;
            // To write
        end
    end
    
    task Task_StartORAMAccess;
        input [BECMDWidth-1:0] cmd;
        input [ORAMU-1:0] addr;
        input [FEDWidth-1:0] data;
        
        begin
            StartedORAMAccesses = 1;
            CmdValidORAM = 1;
            CmdORAM = cmd;
            PAddrORAM = addr;
            #(ClockCycle) 
            CmdValidORAM = 0;
            if (CmdORAM == BECMD_Append || CmdORAM == BECMD_Update) begin
                DataInValidORAM = 1;
                        
                for (i = 0; i < FEORAMBChunks; i = i + 1) begin
                    if (i == 0) DataInORAM = data;
                    else DataInORAM = {FEDWidth{'b0}}; // wasting space
                    #(ClockCycle);
                    while (DataInReadyORAM !== 1) begin  
                        #(ClockCycle);
                    end
                end
                #(ClockCycle);
                DataInValidORAM = 0;
            end
            
            if (CmdORAM == BECMD_Read || CmdORAM == BECMD_ReadRmv) begin
               DataOutReadyORAM = 1;
               for (i = 0; i < FEORAMBChunks; i = i + 1) begin
                   while (DataOutValidORAM !== 1) begin
                       #(ClockCycle);
                   end
                   if (i == 0) begin 
                        DataReadFromORAM = DataOutORAM; // will synthesize a latch? avoid
                        $display("Data Read by CPU [%d][%d] = %d", PAddrORAM, i, DataOutORAM);
                   end
                   #(ClockCycle);
               end
               DataOutReadyORAM = 0; 
            end
        end
    endtask
endmodule
