localparam  SetupStatesWidth        =  3,
            St_Initial              =  3'd0,
            St_Header               =  3'd1,
            St_InputEncryption      =  3'd2,
            St_ProgramLoad			=  3'd3,
            St_Execute              =  3'd4;

localparam MaxInputWidth            =  3; // 8 inputs maximum at this point
localparam MaxInputLength           =  8;
localparam MaxProgramLength			=  16;
localparam MaxProgramWidth          =  4;
localparam MaxRegisters             = 32;

localparam  real 	ClockFreq = 200_000_000;
localparam  real 	ClockCycle = 1000_000_000/ClockFreq;