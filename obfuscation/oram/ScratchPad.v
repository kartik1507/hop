`include "Const.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2015 10:01:35 PM
// Design Name: 
// Module Name: ScratchPad
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


module ScratchPad(
		  Clock, Reset,
		  InPAddr,
		  InCmd, InCmdValid, InCmdReady, // Cpu -> scratchpad
		  InDataStore, InDataStoreValid, InDataStoreReady,
		  OutDataLoad, OutDataLoadValid, OutDataLoadReady,
                  UnalignedType,
		  // DRAM
		  DRAMAddress, DRAMCommand, DRAMCommandValid, DRAMCommandReady,
		  DRAMReadData, DRAMReadDataValid,
		  DRAMWriteData, DRAMWriteDataValid, DRAMWriteDataReady,
                  // own stuff
                  isNextReqSpld, memForSpld, IFSPCmdValid, IFSPCmdReady, isReplaceable,
                  // output for printing purposes
                  inScratchPad
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

  `include "FSM.vh"	
  `include "PathORAM.vh"
  `include "DMLocal.vh"
  `include "DDR3SDRAMLocal.vh"
  `include "BucketLocal.vh"
  `include "CommandsLocal.vh"
  `include "JTAG.vh"

   parameter SP_SIZE = 6600;
   
   input Clock, Reset;
   // talking to CPU
   input [BECMDWidth-1:0] InCmd;
   input [ORAMU-1:0] 	  InPAddr;
   input 		  InCmdValid;
   output 		  InCmdReady;
   input [ORAMB-1:0] 	  InDataStore;
   input 		  InDataStoreValid;
   output 		  InDataStoreReady;
   output [ORAMB-1:0] 	  OutDataLoad;
   output 		  OutDataLoadValid;
   input 		  OutDataLoadReady;
   input [2:0]            UnalignedType;
   

   reg 			  InCmdReady;
   reg 			  InDataStoreReady;
   reg [ORAMB-1:0] 	  OutDataLoad;
   reg 			  OutDataLoadValid;
   reg 			  InDataLoadReady;

   // talking to ORAM
   reg [BECMDWidth-1:0]   OutCmd;
   reg [ORAMU-1:0]        OutPAddr;
   reg                    OutCmdValid;
   wire                   OutCmdReady;
   reg [ORAMB-1:0]        OutDataStore;
   reg                    OutDataStoreValid;
   wire                   OutDataStoreReady;
   wire [ORAMB-1:0]       InDataLoad;
   wire                   InDataLoadValid;

   // passing DRAM signals
   output [DDRAWidth-1:0]  DRAMAddress;
   output [DDRCWidth-1:0]  DRAMCommand;
   output 		   DRAMCommandValid;
   input 		   DRAMCommandReady;
   input [NetworkWidth-1:0] DRAMReadData;
   input 		    DRAMReadDataValid;
   output [NetworkWidth-1:0] DRAMWriteData;
   output 		     DRAMWriteDataValid;
   input 		     DRAMWriteDataReady;

   // own registers/communication with InstructionFilter
   input                     isNextReqSpld;
   input [15:0]              memForSpld;
   input                     IFSPCmdValid;
   output                    IFSPCmdReady;
   reg                       IFSPCmdReady;
   reg                       isNextReqSpldStored;
   reg [15:0]                memForSpldStored;
   input                     isReplaceable;
   

   // own reg
   reg [ORAMB-1:0]           mem[SP_SIZE - 1:0];
   reg [15:0]                spLoc; // next memLocation available in mem
   reg [ORAMU-1:0]           addrToLoad;
   reg [ORAMU-1:0]           base[9:0]; // maintains base values
   // output [ORAMU-1:0]           base[9:0]; // maintains base values
   reg [15:0]                lim[9:0]; // maintains ranges
   // output [15:0]                lim[9:0]; // maintains ranges
   reg [15:0]                baseCtr; // next base entry to use
   reg                       justStartedLoadingScratchPad;
   reg                       justStartedStoringScratchPad;
   
   // replaceable scratchpad
   reg [ORAMB-1:0]           mem2[1:0]; // replaceable scratchpad
   reg [ORAMU-1:0]           base2;
   reg                       baseCtr2;
   reg [15:0]                sp2Index;
   
   reg                       isReplaceableStored;
   
   
   
   // reg for oram access
   reg [15:0]                i;
   reg                       inScratchPad;
   output                    inScratchPad;
   
   reg [15:0]                cumSumMemLoc;
   reg                       waitForLoadData;
   reg                       waitForStoreData;
   reg                       oramLoadDataStarted;
   reg                       oramStoreDataStarted;
   reg                       shouldCheckSPORAM;
   reg [5:0]                 AddrInBlock;
   localparam                WordSize = 4;
   localparam                HalfWordSize = 2;
   localparam                ByteSize = 1;
   reg [ORAMB-1:0]           tempReg;
   reg [ORAMU-1:0]           tempAddr;
   reg [2:0]                 currentUnalignedType;
   // reg [1:0]                 AddrInWord;
   
   
   
   
   ORAMWrap ORAM(	        .Clock(					Clock),
                                .Reset(                 Reset),                                
                                // interface with Setup            
                                .Cmd(                   OutCmd),
                                .PAddr(                 OutPAddr),
                                .CmdValid(              OutCmdValid),
                                .CmdReady(              OutCmdReady),
			        .InDataReady_wrap(           OutDataStoreReady),
			        .InDataValid_wrap(           OutDataStoreValid), 
			        .InDataStore_wrap(           OutDataStore),
			        .OutDataReady_wrap(          InDataLoadReady),
			        .OutDataValid_wrap(          InDataLoadValid), 
			        .OutDataLoad_wrap(           InDataLoad),
                                
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
                                .oram_ctap_res_data(    ) // not passing anything here
);

   always @(posedge Clock) begin
      OutDataLoadValid = 0;
      OutDataStoreValid = 0;
      shouldCheckSPORAM = 1;
      
      
      if (oramLoadDataStarted | oramStoreDataStarted | inScratchPad) begin
         InCmdReady = 0;
         InDataStoreReady = 0;
         shouldCheckSPORAM = 0;
      end 

      // IFSPCmdReady should be 1 when loading happens for some reason!!
      if (oramStoreDataStarted | inScratchPad) begin
         IFSPCmdReady = 0;
      end else if (!justStartedLoadingScratchPad & !isNextReqSpldStored) begin
         IFSPCmdReady = 1;
      end
      
      
      inScratchPad = 0;
      // Out Load valid/ready handshake done, waiting for data
      if (waitForLoadData & InDataLoadValid & oramLoadDataStarted) begin
         oramLoadDataStarted = 0;
         waitForLoadData = 0;
         InDataLoadReady = 0;

         if (!oramStoreDataStarted) begin // regular load
            OutDataLoadValid = 1;
            
            if (currentUnalignedType == 3'h3)
              OutDataLoad = InDataLoad[AddrInBlock * 8 +: WordSize * 8];
            else if (currentUnalignedType == 3'h1)
              OutDataLoad = InDataLoad[AddrInBlock * 8 +: ByteSize * 8];
            else if (currentUnalignedType == 3'h2)
              OutDataLoad = InDataLoad[AddrInBlock * 8 +: HalfWordSize * 8];
            else
              $finish;
            
            IFSPCmdReady = 1;
         end else begin // store starting now
            // InDataLoad has the read data
            // OutDataStore has the data to be stored in the last 4 bytes
            tempReg = InDataLoad;
            if (currentUnalignedType == 3'h3)
              tempReg[AddrInBlock * 8 +: WordSize * 8] = OutDataStore[WordSize * 8 - 1 : 0];
            else if (currentUnalignedType == 3'h1)
              tempReg[AddrInBlock * 8 +: ByteSize * 8] = OutDataStore[ByteSize * 8 - 1 : 0];
            else  if (currentUnalignedType == 3'h2)
              tempReg[AddrInBlock * 8 +: HalfWordSize * 8] = OutDataStore[HalfWordSize * 8 - 1 : 0];
            else begin
               // exists for writing program, writes all 512 bits
               tempReg = OutDataStore;
            end
            
            
            OutDataStore = tempReg;
            OutCmd = BECMD_Update;
            OutCmdValid = 1;
         end // else: !if(!oramStoreDataStarted)
         // $display("[%m @ %t] SPORAM READ data transfer d=%x", $time, OutDataLoad);
      end 
      // Out Load valid high, waiting for ready
      else if (oramLoadDataStarted & OutCmdReady) begin
         OutCmdValid = 0;
         waitForLoadData = 1;
         InDataLoadReady = 1;
      end 
      // Out Data Store data exchange cmd ready/valid handshake has happened
      else if (oramStoreDataStarted & waitForStoreData & !oramLoadDataStarted) begin
         OutCmdValid = 0;
         if (OutDataStoreReady) begin
            // $display("[%m @ %t] SPORAM WRITE data transfer d=%x", $time, OutDataStore);
            OutDataStoreValid = 0;
            waitForStoreData = 0;
            oramStoreDataStarted = 0;
            IFSPCmdReady = 1;
         end
      end 
      // Out Data Store cmd ready/valid handshake waiting
      else if (oramStoreDataStarted & OutCmdReady & !oramLoadDataStarted) begin
         OutCmdValid = 0;
         // $display("[%m @ %t] SPORAM Command a=%x c=%x", $time, OutPAddr, OutCmd);
         OutDataStoreValid = 1;
         waitForStoreData = 1;
      end

      // Scratchpad load: Out Load valid/ready handshake done, waiting for data
      else if (waitForLoadData & InDataLoadValid & justStartedLoadingScratchPad & !justStartedStoringScratchPad) begin
         if (isReplaceableStored) begin
            mem2[sp2Index] = InDataLoad;
            sp2Index = sp2Index + 1;
         end else begin
            mem[spLoc] = InDataLoad;
            spLoc = spLoc + 1;
         end
         
         InDataLoadReady = 0;

         memForSpldStored = memForSpldStored - 1;
         
         waitForLoadData = 0;
         
         if (memForSpldStored == 0) begin
            IFSPCmdReady = 1;
            justStartedLoadingScratchPad = 0;
         end else begin
            addrToLoad = addrToLoad + 1; // adding 1 ORAM block = 512 bits = 64 bytes
            OutCmdValid = 1;
            OutCmd = BECMD_Read;
            OutPAddr = addrToLoad;
         end
      end // if (waitForLoadData & InDataLoadValid & justStartedLoadingScratchPad & !justStartedStoringScratchPad)
      // scratchpad store: cmd/ready handshake done, waiting for store
      else if (justStartedStoringScratchPad & OutDataStoreReady & waitForStoreData) begin
         OutDataStoreValid = 0;
         waitForStoreData = 0;
         memForSpldStored = memForSpldStored - 1;
         
         if (memForSpldStored == 0) begin
            justStartedStoringScratchPad = 0;
            OutCmdValid = 1;
            OutCmd = BECMD_Read;
            OutPAddr = addrToLoad;
            memForSpldStored = 2; // hard coded!!!!!!!!
            base2 = addrToLoad;
            sp2Index = 0;
            $display("Storing done");
         end else begin
            OutCmdValid = 1;
            OutCmd = BECMD_Update;
            sp2Index = sp2Index + 1;
            OutPAddr = base2 + sp2Index;
            OutDataStore = mem2[sp2Index];
         end // else: !if(memForSpldStored == 0)
      end
      // scratchpad store: out store valid high, waiting for ready
      else if (justStartedStoringScratchPad & OutCmdReady) begin
         OutCmdValid = 0;
         waitForStoreData = 1;
         OutDataStoreValid = 1;
      end
      // Scratchpad load: Out Load valid high, waiting for ready
      else if (justStartedLoadingScratchPad & OutCmdReady & !justStartedStoringScratchPad) begin
         OutCmdValid = 0;
         waitForLoadData = 1;
         InDataLoadReady = 1;
      end 
      // SPLD request
      else if (isNextReqSpld & IFSPCmdValid & IFSPCmdReady) begin
         isNextReqSpldStored = 1;
         memForSpldStored = memForSpld;
         IFSPCmdReady = 0;
         InCmdReady = 1;
         InDataStoreReady = 1;
         OutCmdValid = 0;
         isReplaceableStored = isReplaceable;
         
      end 
      // getting address for SPLD sw ra,0(reg)
      else if (isNextReqSpldStored & InCmdValid) begin // start loading scratch pad
         if (!isReplaceableStored) begin
            lim[baseCtr] = memForSpldStored;
            base[baseCtr] = InPAddr >> 6;
            baseCtr = baseCtr + 1;
         
            addrToLoad = InPAddr >> 6;
            justStartedLoadingScratchPad = 1;
            isNextReqSpldStored = 0;

            InDataStoreReady = 0;
            InCmdReady = 0;


            
            OutCmdValid = 1;
            OutCmd = BECMD_Read;
            OutPAddr = addrToLoad;
         end // if (!isReplaceableStore)
         else begin
            // tempAddr = InPAddr >> 6;
            // addrToStore = InPAddr >> 6;
            
            baseCtr2 = 1; // only one base allowed and is used now
            memForSpldStored = 2; // only two addresses to load
            
            justStartedLoadingScratchPad = 1;
            justStartedStoringScratchPad = 1;
            isNextReqSpldStored = 0;

            sp2Index = 0;
            
            InDataStoreReady = 0;
            InCmdReady = 0;
            OutCmdValid = 1;
            OutCmd = BECMD_Update;
            OutPAddr = base2;
            OutDataStore = mem2[sp2Index];
            
            addrToLoad = InPAddr >> 6;
         end // else: !if(!isReplaceableStore)
         
         $display("Address: %x, MemSize: %d, ORAM addr: %x, isReplaceable: %d", InPAddr, memForSpldStored, InPAddr >> 6, isReplaceableStored);
      end // if (isNextReqSpldStored & InCmdValid)

      // searching scratchpad
      else if (!isNextReqSpldStored & !justStartedLoadingScratchPad & shouldCheckSPORAM) begin // search for data in scratchpad (InCmdValid checked later)
         // scratchpad does not need inCmdReady as such to respond
         OutCmdValid = 0; // setting this so that old cmd valid is not active if data is in scratchpad
         // if (InCmdValid)
           // $display("Searching scratchpad %d %d %x", InCmdValid, InCmdReady, InPAddr);
         
         if (InCmdValid & ((InPAddr % 4 != 0) | (UnalignedType != 3'h3))) begin
            // $display("Unaligned access %x", InPAddr);
            // $finish;
         end
         
         cumSumMemLoc = 0;

         InCmdReady = 1; // scratchpad is always ready!
         InDataStoreReady = 1;
         tempAddr = InPAddr >> 6;
         AddrInBlock = InPAddr % (32'b1 << 6);
         currentUnalignedType = UnalignedType & 3'h3;

         // search in replaceable sp
         for (i = 0; i < 2; i = i + 1) begin
            if ((tempAddr == base2 + i) & InCmdValid) begin
               inScratchPad = 1;
               if (InCmd == BECMD_Read) begin
                  if (currentUnalignedType == 3'h3)
                    OutDataLoad = mem2[i][AddrInBlock * 8 +: WordSize * 8];
                  else if (currentUnalignedType == 3'h1)
                    OutDataLoad = mem2[i][AddrInBlock * 8 +: ByteSize * 8];
                  else if (currentUnalignedType == 3'h2)
                    OutDataLoad = mem2[i][AddrInBlock * 8 +: HalfWordSize * 8];
                  else
                    $finish;
                  
                  OutDataLoadValid = 1;
                  // $display("RSP read %x, %x", InPAddr, OutDataLoad);
               end 

               

               else if (InCmd == BECMD_Update) begin
                  if (currentUnalignedType == 3'h3)
                    mem2[i][AddrInBlock * 8 +: WordSize * 8] = InDataStore[WordSize * 8 - 1 : 0];
                  else if (currentUnalignedType == 3'h1)
                    mem2[i][AddrInBlock * 8 +: ByteSize * 8] = InDataStore[ByteSize * 8 - 1 : 0];
                  else if (currentUnalignedType == 3'h2)
                    mem2[i][AddrInBlock * 8 +: HalfWordSize * 8] = InDataStore[HalfWordSize * 8 - 1 : 0];
                  else
                    $finish;
                  
                  InDataStoreReady = 1;
                  // $display("RSP write %x, %x", InPAddr, InDataStore);
               end else $finish; // if (InCmd == BECMD_Update)
            end // if ((tempAddr == base2 + i) & InCmdValid)
         end // for (i = 0; i < baseCtr; i = i + 1)
         
         // search in nonreplaceable sp
         for (i = 0; i < baseCtr; i = i + 1) begin
            if ((tempAddr >= base[i]) & (tempAddr < (base[i] + lim[i])) & InCmdValid) begin
               inScratchPad = 1;
               if (InCmd == BECMD_Read) begin
                  if (currentUnalignedType == 3'h3)
                    OutDataLoad = mem[cumSumMemLoc + (tempAddr - base[i])][AddrInBlock * 8 +: WordSize * 8];
                  else if (currentUnalignedType == 3'h1)
                    OutDataLoad = mem[cumSumMemLoc + (tempAddr - base[i])][AddrInBlock * 8 +: ByteSize * 8];
                  else if (currentUnalignedType == 3'h2)
                    OutDataLoad = mem[cumSumMemLoc + (tempAddr - base[i])][AddrInBlock * 8 +: HalfWordSize * 8];
                  else
                    $finish;
                  
                  OutDataLoadValid = 1;
                  // $display("NSP read %x, %x", InPAddr, OutDataLoad);
                  // $display("scratchpad serving load %x, %x, %x, %x, %d", InCmdReady, OutDataLoadValid, OutDataLoad, InPAddr, cumSumMemLoc + (tempAddr - base[i]));
               end 

               

               else if (InCmd == BECMD_Update) begin
                  if (currentUnalignedType == 3'h3)
                    mem[cumSumMemLoc + (tempAddr - base[i])][AddrInBlock * 8 +: WordSize * 8] = InDataStore[WordSize * 8 - 1 : 0];
                  else if (currentUnalignedType == 3'h1)
                    mem[cumSumMemLoc + (tempAddr - base[i])][AddrInBlock * 8 +: ByteSize * 8] = InDataStore[ByteSize * 8 - 1 : 0];
                  else if (currentUnalignedType == 3'h2)
                    mem[cumSumMemLoc + (tempAddr - base[i])][AddrInBlock * 8 +: HalfWordSize * 8] = InDataStore[HalfWordSize * 8 - 1 : 0];
                  else
                    $finish;
                  
                  InDataStoreReady = 1;
                  // $display("scratchpad serving store %x, %x, %x, %x, %d", InCmdReady, InDataStoreReady, InDataStore, InPAddr, cumSumMemLoc + (tempAddr - base[i]));
                  // $display("NSP write %x, %x", InPAddr, InDataStore);
               end else $finish; // if (InCmd == BECMD_Update)
               // $display("In loop InPAddr = %x, base[%d] = %x, lim[%d] = %d, InCmd = %d", InPAddr, i, base[i], i, lim[i], InCmd);
            end
            cumSumMemLoc = cumSumMemLoc + lim[i];
         end // for (i = 0; i < baseCtr; i = i + 1)
         if (!inScratchPad & !justStartedLoadingScratchPad & !isNextReqSpldStored & shouldCheckSPORAM) begin // data not in scratchpad or no data requested
            if (InCmdValid) begin     
               if (InCmd == BECMD_Read) begin
                  InCmdReady = 1;
                  oramLoadDataStarted = 1;
                  OutCmdValid = 1;
                  OutCmd = BECMD_Read;
                  OutPAddr = InPAddr >> 6;
                  AddrInBlock = (InPAddr % (32'b1 << 6));
                  // The  & 3'h3 is to ignore the first bit which differentiates between
                  // lbu and lb. I don't know how the memory should behave differently in that case
                  // anyway
                  currentUnalignedType = UnalignedType & 3'h3;
                  
                  // AddrInWord = (InPAddr % (32'b1 << 2);
               end else if (InCmd == BECMD_Update) begin
                  if (InDataStoreValid) begin
                     oramStoreDataStarted = 1;
                     InDataStoreReady = 1;
                     InCmdReady = 1;

                     oramLoadDataStarted = 1;
                     OutCmd = BECMD_Read; // reading first
                     OutPAddr = InPAddr >> 6;
                     AddrInBlock = (InPAddr % (32'b1 << 6));
                     OutDataStore = InDataStore;
                     OutCmdValid = 1;
                     IFSPCmdReady = 0;
                     currentUnalignedType = UnalignedType & 3'h3;
                  end
               end else begin
                  $finish;
               end //
            end // if (InCmdValid)
         end // if (!inScratchPad & !justStartedLoadingScratchPad & !isNextReqSpldStored & !oramLoadDataStarted & !oramStoreDataStarted)
      end // if (!isNextReqSpldStored & !justStartedLoadingScratchPad & !oramLoadDataStarted & !oramStoreDataStarted)
   end // always @ (posedge Clock)

   initial begin
      spLoc = 0;
      for (i = 0; i < 10; i = i + 1) begin
         base[i] = 0;
         lim[i] = 0;
      end
      baseCtr = 0;

      for (i = 0; i < SP_SIZE; i = i + 1) begin
         mem[i] = 512'b1;
      end
      IFSPCmdReady = 1;
      justStartedLoadingScratchPad = 0;
      isNextReqSpldStored = 0;
      OutCmdValid = 0;
      InCmdReady = 1;
      addrToLoad = 32'h9990;
      waitForLoadData = 0;
      waitForStoreData = 0;
      
      oramLoadDataStarted = 0;
      oramStoreDataStarted = 0;
      shouldCheckSPORAM = 0;
      InDataLoadReady = 1;
      InDataStoreReady = 1;
      OutDataLoad = 0;
      OutDataLoadValid = 0;
      OutDataStoreValid = 0;
      memForSpldStored = 0;
      AddrInBlock = 0;
      tempAddr = 0;
      currentUnalignedType = 2'h3; // 3 is for word
      // AddrInWord = 0;
      for (i = 0; i < 2; i = i + 1) begin
         mem2[i] = 512'b1;
      end
      base2 = 0;
      isReplaceableStored = 0;
      baseCtr2 = 0;
      justStartedStoringScratchPad = 0;
      sp2Index = 0;
      
   end
endmodule
