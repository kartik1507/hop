`timescale 1ns / 1ps
`include "Const.vh"

// parameter program = "add/opcode_add"
`ifdef CHRIS
 `define CODE_PATH_TEMP_0 "C:/kartik_oram/vivado/opcode_hello_0.out"
 `define CODE_PATH_TEMP_1 "C:/kartik_oram/vivado/opcode_hello_1.out"
`else
 `define CODE_PATH_TEMP_0 "/home/kartik/code/hop/examples/sum/opcode_sum_0.out"
 `define CODE_PATH_TEMP_1 "/home/kartik/code/hop/examples/sum/opcode_sum_1.out"
 `define CODE_PATH_LINES "/home/kartik/code/hop/examples/sum/lines.out"
 `define CODE_OUTPUT "/home/kartik/code/hop/examples/sum/output.txt"
 `define CODE_INPUT "/home/kartik/code/hop/examples/sum/input_insert.txt"

`endif

module CtlPath(
    input  io_imem_req_ready,
    output io_imem_req_valid,
    //output[31:0] io_imem_req_bits_addr
    //output[31:0] io_imem_req_bits_data
    output io_imem_req_bits_fcn,
    output[2:0] io_imem_req_bits_typ,
    input  io_imem_resp_valid,
    input [31:0] io_imem_resp_bits_data,
    input  io_dmem_req_ready,
    output io_dmem_req_valid,
    //output[31:0] io_dmem_req_bits_addr
    //output[31:0] io_dmem_req_bits_data
    output io_dmem_req_bits_fcn,
    output[2:0] io_dmem_req_bits_typ,
    input  io_dmem_resp_valid,
    input [31:0] io_dmem_resp_bits_data,
    input [31:0] io_dat_inst,
    input  io_dat_br_eq,
    input  io_dat_br_lt,
    input  io_dat_br_ltu,
    input  io_dat_csr_eret,
    input  io_dat_csr_interrupt,
    input  io_dat_csr_xcpt,
    input [31:0] io_dat_csr_interrupt_cause,
    output io_ctl_stall,
    output[2:0] io_ctl_pc_sel,
    output[1:0] io_ctl_op1_sel,
    output[1:0] io_ctl_op2_sel,
    output[3:0] io_ctl_alu_fun,
    output[2:0] io_ctl_wb_sel,
    output io_ctl_rf_wen,
    output[2:0] io_ctl_csr_cmd,
    output io_ctl_exception,
    output[31:0] io_ctl_exc_cause,
    output io_ctl_debug_dmem_val,
    output[2:0] io_ctl_debug_dmem_typ,
    input  io_resetSignal
);

  wire[2:0] cs_msk_sel;
  wire[2:0] T0;
  wire[2:0] T1;
  wire[2:0] T2;
  wire[2:0] T3;
  wire[2:0] T4;
  wire[2:0] T5;
  wire[2:0] T6;
  wire T7;
  wire[31:0] T8;
  wire T9;
  wire[31:0] T10;
  wire T11;
  wire[31:0] T12;
  wire T13;
  wire[31:0] T14;
  wire T15;
  wire[31:0] T16;
  wire T17;
  wire[31:0] T18;
  wire T19;
  wire[31:0] T20;
  wire T21;
  wire[31:0] T22;
  wire cs_mem_en;
  wire T23;
  wire T24;
  wire T25;
  wire T26;
  wire T27;
  wire T28;
  wire T29;
  wire T30;
  wire T31;
  wire T32;
  wire T33;
  wire T34;
  wire T35;
  wire T36;
  wire T37;
  wire T38;
  wire T39;
  wire T40;
  wire T41;
  wire T42;
  wire T43;
  wire T44;
  wire T45;
  wire T46;
  wire T47;
  wire T48;
  wire T49;
  wire T50;
  wire T51;
  wire T52;
  wire T53;
  wire T54;
  wire T55;
  wire T56;
  wire T57;
  wire T58;
  wire T59;
  wire T60;
  wire T61;
  wire T62;
  wire T63;
  wire T64;
  wire T65;
  wire T66;
  wire T67;
  wire T68;
  wire T69;
  wire T70;
  wire T71;
  wire[31:0] T72;
  wire T73;
  wire[31:0] T74;
  wire T75;
  wire T76;
  wire T77;
  wire T78;
  wire T79;
  wire T80;
  wire[31:0] T81;
  wire T82;
  wire[31:0] T83;
  wire T84;
  wire[31:0] T85;
  wire T86;
  wire[31:0] T87;
  wire T88;
  wire[31:0] T89;
  wire T90;
  wire[31:0] T91;
  wire T92;
  wire[31:0] T93;
  wire T94;
  wire[31:0] T95;
  wire T96;
  wire[31:0] T97;
  wire T98;
  wire[31:0] T99;
  wire T100;
  wire[31:0] T101;
  wire T102;
  wire[31:0] T103;
  wire T104;
  wire[31:0] T105;
  wire T106;
  wire[31:0] T107;
  wire T108;
  wire[31:0] T109;
  wire T110;
  wire[31:0] T111;
  wire T112;
  wire[31:0] T113;
  wire T114;
  wire[31:0] T115;
  wire T116;
  wire[31:0] T117;
  wire T118;
  wire[31:0] T119;
  wire T120;
  wire[31:0] T121;
  wire T122;
  wire[31:0] T123;
  wire T124;
  wire[31:0] T125;
  wire T126;
  wire[31:0] T127;
  wire T128;
  wire[31:0] T129;
  wire T130;
  wire[31:0] T131;
  wire T132;
  wire[31:0] T133;
  wire T134;
  wire[31:0] T135;
  wire T136;
  wire[31:0] T137;
  wire T138;
  wire[31:0] T139;
  wire T140;
  wire[31:0] T141;
  wire T142;
  wire[31:0] T143;
  wire T144;
  wire[31:0] T145;
  wire T146;
  wire[31:0] T147;
  wire T148;
  wire[31:0] T149;
  wire[31:0] T150;
  wire T151;
  wire exc_illegal;
  wire T152;
  wire cs_val_inst;
  wire T153;
  wire T154;
  wire T155;
  wire T156;
  wire T157;
  wire T158;
  wire T159;
  wire T160;
  wire T161;
  wire T162;
  wire T163;
  wire T164;
  wire T165;
  wire T166;
  wire T167;
  wire T168;
  wire T169;
  wire T170;
  wire T171;
  wire T172;
  wire T173;
  wire T174;
  wire T175;
  wire T176;
  wire T177;
  wire T178;
  wire T179;
  wire T180;
  wire T181;
  wire T182;
  wire T183;
  wire T184;
  wire T185;
  wire T186;
  wire T187;
  wire T188;
  wire T189;
  wire T190;
  wire T191;
  wire T192;
  wire T193;
  wire T194;
  wire T195;
  wire T196;
  wire T197;
  wire T198;
  wire T199;
  wire T200;
  wire[2:0] T201;
  wire[2:0] csr_cmd;
  wire[2:0] cs_csr_cmd;
  wire[2:0] T202;
  wire[2:0] T203;
  wire[2:0] T204;
  wire[2:0] T205;
  wire[2:0] T206;
  wire[2:0] T207;
  wire[2:0] T208;
  wire[2:0] T209;
  wire[2:0] T210;
  wire[2:0] T211;
  wire[2:0] T212;
  wire[2:0] T213;
  wire[2:0] T214;
  wire[2:0] T215;
  wire[2:0] T216;
  wire[2:0] T217;
  wire[2:0] T218;
  wire[2:0] T219;
  wire[2:0] T220;
  wire[2:0] T221;
  wire[2:0] T222;
  wire[2:0] T223;
  wire[2:0] T224;
  wire[2:0] T225;
  wire[2:0] T226;
  wire[2:0] T227;
  wire[2:0] T228;
  wire[2:0] T229;
  wire[2:0] T230;
  wire[2:0] T231;
  wire[2:0] T232;
  wire[2:0] T233;
  wire[2:0] T234;
  wire[2:0] T235;
  wire[2:0] T236;
  wire[2:0] T237;
  wire[2:0] T238;
  wire[2:0] T239;
  wire[2:0] T240;
  wire[2:0] T241;
  wire[2:0] T242;
  wire[2:0] T243;
  wire[2:0] T244;
  wire[2:0] T245;
  wire[2:0] T246;
  wire[2:0] T247;
  wire csr_ren;
  wire T248;
  wire[4:0] rs1_addr;
  wire T249;
  wire T250;
  wire T251;
  wire stall;
  wire T252;
  wire T253;
  wire T254;
  wire T255;
  wire T256;
  wire T257;
  wire T258;
  wire cs_rf_wen;
  wire T259;
  wire T260;
  wire T261;
  wire T262;
  wire T263;
  wire T264;
  wire T265;
  wire T266;
  wire T267;
  wire T268;
  wire T269;
  wire T270;
  wire T271;
  wire T272;
  wire T273;
  wire T274;
  wire T275;
  wire T276;
  wire T277;
  wire T278;
  wire T279;
  wire T280;
  wire T281;
  wire T282;
  wire T283;
  wire T284;
  wire T285;
  wire T286;
  wire T287;
  wire T288;
  wire T289;
  wire T290;
  wire T291;
  wire T292;
  wire T293;
  wire T294;
  wire T295;
  wire T296;
  wire T297;
  wire T298;
  wire T299;
  wire T300;
  wire[2:0] T525;
  wire[1:0] cs_wb_sel;
  wire[1:0] T301;
  wire[1:0] T302;
  wire[1:0] T303;
  wire[1:0] T304;
  wire[1:0] T305;
  wire[1:0] T306;
  wire[1:0] T307;
  wire[1:0] T308;
  wire[1:0] T309;
  wire[1:0] T310;
  wire[1:0] T311;
  wire[1:0] T312;
  wire[1:0] T313;
  wire[1:0] T314;
  wire[1:0] T315;
  wire[1:0] T316;
  wire[1:0] T317;
  wire[1:0] T318;
  wire[1:0] T319;
  wire[1:0] T320;
  wire[1:0] T321;
  wire[1:0] T322;
  wire[1:0] T323;
  wire[1:0] T324;
  wire[1:0] T325;
  wire[1:0] T326;
  wire[1:0] T327;
  wire[1:0] T328;
  wire[1:0] T329;
  wire[1:0] T330;
  wire[1:0] T331;
  wire[1:0] T332;
  wire[1:0] T333;
  wire[1:0] T334;
  wire[1:0] T335;
  wire[1:0] T336;
  wire[1:0] T337;
  wire[1:0] T338;
  wire[1:0] T339;
  wire[1:0] T340;
  wire[1:0] T341;
  wire[1:0] T342;
  wire[3:0] cs_alu_fun;
  wire[3:0] T343;
  wire[3:0] T344;
  wire[3:0] T345;
  wire[3:0] T346;
  wire[3:0] T347;
  wire[3:0] T348;
  wire[3:0] T349;
  wire[3:0] T350;
  wire[3:0] T351;
  wire[3:0] T352;
  wire[3:0] T353;
  wire[3:0] T354;
  wire[3:0] T355;
  wire[3:0] T356;
  wire[3:0] T357;
  wire[3:0] T358;
  wire[3:0] T359;
  wire[3:0] T360;
  wire[3:0] T361;
  wire[3:0] T362;
  wire[3:0] T363;
  wire[3:0] T364;
  wire[3:0] T365;
  wire[3:0] T366;
  wire[3:0] T367;
  wire[3:0] T368;
  wire[3:0] T369;
  wire[3:0] T370;
  wire[3:0] T371;
  wire[3:0] T372;
  wire[3:0] T373;
  wire[3:0] T374;
  wire[3:0] T375;
  wire[3:0] T376;
  wire[3:0] T377;
  wire[3:0] T378;
  wire[3:0] T379;
  wire[3:0] T380;
  wire[3:0] T381;
  wire[3:0] T382;
  wire[3:0] T383;
  wire[3:0] T384;
  wire[1:0] cs_op2_sel;
  wire[1:0] T385;
  wire[1:0] T386;
  wire[1:0] T387;
  wire[1:0] T388;
  wire[1:0] T389;
  wire[1:0] T390;
  wire[1:0] T391;
  wire[1:0] T392;
  wire[1:0] T393;
  wire[1:0] T394;
  wire[1:0] T395;
  wire[1:0] T396;
  wire[1:0] T397;
  wire[1:0] T398;
  wire[1:0] T399;
  wire[1:0] T400;
  wire[1:0] T401;
  wire[1:0] T402;
  wire[1:0] T403;
  wire[1:0] T404;
  wire[1:0] T405;
  wire[1:0] T406;
  wire[1:0] T407;
  wire[1:0] T408;
  wire[1:0] T409;
  wire[1:0] T410;
  wire[1:0] T411;
  wire[1:0] T412;
  wire[1:0] T413;
  wire[1:0] T414;
  wire[1:0] cs_op1_sel;
  wire[1:0] T415;
  wire[1:0] T416;
  wire[1:0] T417;
  wire[1:0] T418;
  wire[1:0] T419;
  wire[1:0] T420;
  wire[1:0] T421;
  wire[1:0] T422;
  wire[1:0] T423;
  wire[1:0] T424;
  wire[1:0] T425;
  wire[1:0] T426;
  wire[1:0] T427;
  wire[1:0] T428;
  wire[1:0] T429;
  wire[1:0] T430;
  wire[1:0] T431;
  wire[1:0] T432;
  wire[1:0] T433;
  wire[1:0] T434;
  wire[1:0] T435;
  wire[1:0] T436;
  wire[1:0] T437;
  wire[1:0] T438;
  wire[1:0] T439;
  wire[1:0] T440;
  wire[1:0] T441;
  wire[1:0] T442;
  wire[1:0] T443;
  wire[1:0] T444;
  wire[1:0] T445;
  wire[1:0] T446;
  wire[1:0] T447;
  wire[1:0] T448;
  wire[1:0] T449;
  wire[1:0] T450;
  wire[1:0] T451;
  wire[1:0] T452;
  wire[1:0] T453;
  wire[2:0] ctrl_pc_sel;
  wire[2:0] T454;
  wire[2:0] T455;
  wire[2:0] T456;
  wire[2:0] T457;
  wire[2:0] T458;
  wire[2:0] T459;
  wire[2:0] T460;
  wire[2:0] T461;
  wire[2:0] T462;
  wire T463;
  wire[3:0] cs_br_type;
  wire[3:0] T464;
  wire[3:0] T465;
  wire[3:0] T466;
  wire[3:0] T467;
  wire[3:0] T468;
  wire[3:0] T469;
  wire[3:0] T470;
  wire[3:0] T471;
  wire[3:0] T472;
  wire[3:0] T473;
  wire[3:0] T474;
  wire[3:0] T475;
  wire[3:0] T476;
  wire[3:0] T477;
  wire[3:0] T478;
  wire[3:0] T479;
  wire[3:0] T480;
  wire[3:0] T481;
  wire[3:0] T482;
  wire[3:0] T483;
  wire[3:0] T484;
  wire[3:0] T485;
  wire[3:0] T486;
  wire[3:0] T487;
  wire[3:0] T488;
  wire[3:0] T489;
  wire[3:0] T490;
  wire[3:0] T491;
  wire[3:0] T492;
  wire[3:0] T493;
  wire[3:0] T494;
  wire[3:0] T495;
  wire[3:0] T496;
  wire[3:0] T497;
  wire[3:0] T498;
  wire[3:0] T499;
  wire T500;
  wire[2:0] T501;
  wire T502;
  wire[2:0] T503;
  wire T504;
  wire[2:0] T505;
  wire T506;
  wire T507;
  wire[2:0] T508;
  wire T509;
  wire T510;
  wire[2:0] T511;
  wire T512;
  wire[2:0] T513;
  wire T514;
  wire T515;
  wire T516;
  wire T517;
  wire T518;
  wire cs_mem_fcn;
  wire T519;
  wire T520;
  wire T521;
  wire T522;
  wire T523;
  wire T524;


`ifndef SYNTHESIS
// synthesis translate_off
//  assign io_dmem_req_bits_data = {1{$random}};
//  assign io_dmem_req_bits_addr = {1{$random}};
//  assign io_imem_req_bits_data = {1{$random}};
//  assign io_imem_req_bits_addr = {1{$random}};
// synthesis translate_on
`endif
  assign io_ctl_debug_dmem_typ = cs_msk_sel;
  assign cs_msk_sel = T21 ? 3'h3 : T0;
  assign T0 = T19 ? 3'h1 : T1;
  assign T1 = T17 ? 3'h5 : T2;
  assign T2 = T15 ? 3'h2 : T3;
  assign T3 = T13 ? 3'h6 : T4;
  assign T4 = T11 ? 3'h3 : T5;
  assign T5 = T9 ? 3'h1 : T6;
  assign T6 = T7 ? 3'h2 : 3'h0;
  assign T7 = T8 == 32'h1023;
  assign T8 = io_dat_inst & 32'h707f;
  assign T9 = T10 == 32'h23;
  assign T10 = io_dat_inst & 32'h707f;
  assign T11 = T12 == 32'h2023;
  assign T12 = io_dat_inst & 32'h707f;
  assign T13 = T14 == 32'h5003;
  assign T14 = io_dat_inst & 32'h707f;
  assign T15 = T16 == 32'h1003;
  assign T16 = io_dat_inst & 32'h707f;
  assign T17 = T18 == 32'h4003;
  assign T18 = io_dat_inst & 32'h707f;
  assign T19 = T20 == 32'h3;
  assign T20 = io_dat_inst & 32'h707f;
  assign T21 = T22 == 32'h2003;
  assign T22 = io_dat_inst & 32'h707f;
  assign io_ctl_debug_dmem_val = cs_mem_en;
  assign cs_mem_en = T21 ? 1'h1 : T23;
  assign T23 = T19 ? 1'h1 : T24;
  assign T24 = T17 ? 1'h1 : T25;
  assign T25 = T15 ? 1'h1 : T26;
  assign T26 = T13 ? 1'h1 : T27;
  assign T27 = T11 ? 1'h1 : T28;
  assign T28 = T9 ? 1'h1 : T29;
  assign T29 = T7 ? 1'h1 : T30;
  assign T30 = T148 ? 1'h0 : T31;
  assign T31 = T146 ? 1'h0 : T32;
  assign T32 = T144 ? 1'h0 : T33;
  assign T33 = T142 ? 1'h0 : T34;
  assign T34 = T140 ? 1'h0 : T35;
  assign T35 = T138 ? 1'h0 : T36;
  assign T36 = T136 ? 1'h0 : T37;
  assign T37 = T134 ? 1'h0 : T38;
  assign T38 = T132 ? 1'h0 : T39;
  assign T39 = T130 ? 1'h0 : T40;
  assign T40 = T128 ? 1'h0 : T41;
  assign T41 = T126 ? 1'h0 : T42;
  assign T42 = T124 ? 1'h0 : T43;
  assign T43 = T122 ? 1'h0 : T44;
  assign T44 = T120 ? 1'h0 : T45;
  assign T45 = T118 ? 1'h0 : T46;
  assign T46 = T116 ? 1'h0 : T47;
  assign T47 = T114 ? 1'h0 : T48;
  assign T48 = T112 ? 1'h0 : T49;
  assign T49 = T110 ? 1'h0 : T50;
  assign T50 = T108 ? 1'h0 : T51;
  assign T51 = T106 ? 1'h0 : T52;
  assign T52 = T104 ? 1'h0 : T53;
  assign T53 = T102 ? 1'h0 : T54;
  assign T54 = T100 ? 1'h0 : T55;
  assign T55 = T98 ? 1'h0 : T56;
  assign T56 = T96 ? 1'h0 : T57;
  assign T57 = T94 ? 1'h0 : T58;
  assign T58 = T92 ? 1'h0 : T59;
  assign T59 = T90 ? 1'h0 : T60;
  assign T60 = T88 ? 1'h0 : T61;
  assign T61 = T86 ? 1'h0 : T62;
  assign T62 = T84 ? 1'h0 : T63;
  assign T63 = T82 ? 1'h0 : T64;
  assign T64 = T80 ? 1'h0 : T65;
  assign T65 = T79 ? 1'h0 : T66;
  assign T66 = T78 ? 1'h0 : T67;
  assign T67 = T77 ? 1'h0 : T68;
  assign T68 = T76 ? 1'h0 : T69;
  assign T69 = T75 ? 1'h0 : T70;
  assign T70 = T73 ? 1'h0 : T71;
  assign T71 = T72 == 32'hf;
  assign T72 = io_dat_inst & 32'h707f;
  assign T73 = T74 == 32'h100f;
  assign T74 = io_dat_inst & 32'h707f;
  assign T75 = io_dat_inst == 32'h10200073;
  assign T76 = io_dat_inst == 32'h100073;
  assign T77 = io_dat_inst == 32'h30500073;
  assign T78 = io_dat_inst == 32'h10000073;
  assign T79 = io_dat_inst == 32'h73;
  assign T80 = T81 == 32'h3073;
  assign T81 = io_dat_inst & 32'h707f;
  assign T82 = T83 == 32'h2073;
  assign T83 = io_dat_inst & 32'h707f;
  assign T84 = T85 == 32'h1073;
  assign T85 = io_dat_inst & 32'h707f;
  assign T86 = T87 == 32'h7073;
  assign T87 = io_dat_inst & 32'h707f;
  assign T88 = T89 == 32'h6073;
  assign T89 = io_dat_inst & 32'h707f;
  assign T90 = T91 == 32'h5073;
  assign T91 = io_dat_inst & 32'h707f;
  assign T92 = T93 == 32'h6063;
  assign T93 = io_dat_inst & 32'h707f;
  assign T94 = T95 == 32'h4063;
  assign T95 = io_dat_inst & 32'h707f;
  assign T96 = T97 == 32'h7063;
  assign T97 = io_dat_inst & 32'h707f;
  assign T98 = T99 == 32'h5063;
  assign T99 = io_dat_inst & 32'h707f;
  assign T100 = T101 == 32'h1063;
  assign T101 = io_dat_inst & 32'h707f;
  assign T102 = T103 == 32'h63;
  assign T103 = io_dat_inst & 32'h707f;
  assign T104 = T105 == 32'h67;
  assign T105 = io_dat_inst & 32'h707f;
  assign T106 = T107 == 32'h6f;
  assign T107 = io_dat_inst & 32'h7f;
  assign T108 = T109 == 32'h5033;
  assign T109 = io_dat_inst & 32'hfe00707f;
  assign T110 = T111 == 32'h40005033;
  assign T111 = io_dat_inst & 32'hfe00707f;
  assign T112 = T113 == 32'h4033;
  assign T113 = io_dat_inst & 32'hfe00707f;
  assign T114 = T115 == 32'h6033;
  assign T115 = io_dat_inst & 32'hfe00707f;
  assign T116 = T117 == 32'h7033;
  assign T117 = io_dat_inst & 32'hfe00707f;
  assign T118 = T119 == 32'h3033;
  assign T119 = io_dat_inst & 32'hfe00707f;
  assign T120 = T121 == 32'h2033;
  assign T121 = io_dat_inst & 32'hfe00707f;
  assign T122 = T123 == 32'h40000033;
  assign T123 = io_dat_inst & 32'hfe00707f;
  assign T124 = T125 == 32'h33;
  assign T125 = io_dat_inst & 32'hfe00707f;
  assign T126 = T127 == 32'h1033;
  assign T127 = io_dat_inst & 32'hfe00707f;
  assign T128 = T129 == 32'h5013;
  assign T129 = io_dat_inst & 32'hfc00707f;
  assign T130 = T131 == 32'h40005013;
  assign T131 = io_dat_inst & 32'hfc00707f;
  assign T132 = T133 == 32'h1013;
  assign T133 = io_dat_inst & 32'hfc00707f;
  assign T134 = T135 == 32'h3013;
  assign T135 = io_dat_inst & 32'h707f;
  assign T136 = T137 == 32'h2013;
  assign T137 = io_dat_inst & 32'h707f;
  assign T138 = T139 == 32'h4013;
  assign T139 = io_dat_inst & 32'h707f;
  assign T140 = T141 == 32'h6013;
  assign T141 = io_dat_inst & 32'h707f;
  assign T142 = T143 == 32'h7013;
  assign T143 = io_dat_inst & 32'h707f;
  assign T144 = T145 == 32'h13;
  assign T145 = io_dat_inst & 32'h707f;
  assign T146 = T147 == 32'h37;
  assign T147 = io_dat_inst & 32'h7f;
  assign T148 = T149 == 32'h17;
  assign T149 = io_dat_inst & 32'h7f;
  assign io_ctl_exc_cause = T150;
  assign T150 = io_dat_csr_interrupt ? io_dat_csr_interrupt_cause : 32'h2;
  assign io_ctl_exception = T151;
  assign T151 = exc_illegal | io_dat_csr_interrupt;
  assign exc_illegal = T152 & io_imem_resp_valid;
  assign T152 = cs_val_inst ^ 1'h1;
  assign cs_val_inst = T21 ? 1'h1 : T153;
  assign T153 = T19 ? 1'h1 : T154;
  assign T154 = T17 ? 1'h1 : T155;
  assign T155 = T15 ? 1'h1 : T156;
  assign T156 = T13 ? 1'h1 : T157;
  assign T157 = T11 ? 1'h1 : T158;
  assign T158 = T9 ? 1'h1 : T159;
  assign T159 = T7 ? 1'h1 : T160;
  assign T160 = T148 ? 1'h1 : T161;
  assign T161 = T146 ? 1'h1 : T162;
  assign T162 = T144 ? 1'h1 : T163;
  assign T163 = T142 ? 1'h1 : T164;
  assign T164 = T140 ? 1'h1 : T165;
  assign T165 = T138 ? 1'h1 : T166;
  assign T166 = T136 ? 1'h1 : T167;
  assign T167 = T134 ? 1'h1 : T168;
  assign T168 = T132 ? 1'h1 : T169;
  assign T169 = T130 ? 1'h1 : T170;
  assign T170 = T128 ? 1'h1 : T171;
  assign T171 = T126 ? 1'h1 : T172;
  assign T172 = T124 ? 1'h1 : T173;
  assign T173 = T122 ? 1'h1 : T174;
  assign T174 = T120 ? 1'h1 : T175;
  assign T175 = T118 ? 1'h1 : T176;
  assign T176 = T116 ? 1'h1 : T177;
  assign T177 = T114 ? 1'h1 : T178;
  assign T178 = T112 ? 1'h1 : T179;
  assign T179 = T110 ? 1'h1 : T180;
  assign T180 = T108 ? 1'h1 : T181;
  assign T181 = T106 ? 1'h1 : T182;
  assign T182 = T104 ? 1'h1 : T183;
  assign T183 = T102 ? 1'h1 : T184;
  assign T184 = T100 ? 1'h1 : T185;
  assign T185 = T98 ? 1'h1 : T186;
  assign T186 = T96 ? 1'h1 : T187;
  assign T187 = T94 ? 1'h1 : T188;
  assign T188 = T92 ? 1'h1 : T189;
  assign T189 = T90 ? 1'h1 : T190;
  assign T190 = T88 ? 1'h1 : T191;
  assign T191 = T86 ? 1'h1 : T192;
  assign T192 = T84 ? 1'h1 : T193;
  assign T193 = T82 ? 1'h1 : T194;
  assign T194 = T80 ? 1'h1 : T195;
  assign T195 = T79 ? 1'h1 : T196;
  assign T196 = T78 ? 1'h1 : T197;
  assign T197 = T77 ? 1'h1 : T198;
  assign T198 = T76 ? 1'h1 : T199;
  assign T199 = T75 ? 1'h1 : T200;
  assign T200 = T73 ? 1'h1 : T71;
  assign io_ctl_csr_cmd = T201;
  assign T201 = stall ? 3'h0 : csr_cmd;
  assign csr_cmd = csr_ren ? 3'h5 : cs_csr_cmd;
  assign cs_csr_cmd = T21 ? 3'h0 : T202;
  assign T202 = T19 ? 3'h0 : T203;
  assign T203 = T17 ? 3'h0 : T204;
  assign T204 = T15 ? 3'h0 : T205;
  assign T205 = T13 ? 3'h0 : T206;
  assign T206 = T11 ? 3'h0 : T207;
  assign T207 = T9 ? 3'h0 : T208;
  assign T208 = T7 ? 3'h0 : T209;
  assign T209 = T148 ? 3'h0 : T210;
  assign T210 = T146 ? 3'h0 : T211;
  assign T211 = T144 ? 3'h0 : T212;
  assign T212 = T142 ? 3'h0 : T213;
  assign T213 = T140 ? 3'h0 : T214;
  assign T214 = T138 ? 3'h0 : T215;
  assign T215 = T136 ? 3'h0 : T216;
  assign T216 = T134 ? 3'h0 : T217;
  assign T217 = T132 ? 3'h0 : T218;
  assign T218 = T130 ? 3'h0 : T219;
  assign T219 = T128 ? 3'h0 : T220;
  assign T220 = T126 ? 3'h0 : T221;
  assign T221 = T124 ? 3'h0 : T222;
  assign T222 = T122 ? 3'h0 : T223;
  assign T223 = T120 ? 3'h0 : T224;
  assign T224 = T118 ? 3'h0 : T225;
  assign T225 = T116 ? 3'h0 : T226;
  assign T226 = T114 ? 3'h0 : T227;
  assign T227 = T112 ? 3'h0 : T228;
  assign T228 = T110 ? 3'h0 : T229;
  assign T229 = T108 ? 3'h0 : T230;
  assign T230 = T106 ? 3'h0 : T231;
  assign T231 = T104 ? 3'h0 : T232;
  assign T232 = T102 ? 3'h0 : T233;
  assign T233 = T100 ? 3'h0 : T234;
  assign T234 = T98 ? 3'h0 : T235;
  assign T235 = T96 ? 3'h0 : T236;
  assign T236 = T94 ? 3'h0 : T237;
  assign T237 = T92 ? 3'h0 : T238;
  assign T238 = T90 ? 3'h1 : T239;
  assign T239 = T88 ? 3'h2 : T240;
  assign T240 = T86 ? 3'h3 : T241;
  assign T241 = T84 ? 3'h1 : T242;
  assign T242 = T82 ? 3'h2 : T243;
  assign T243 = T80 ? 3'h3 : T244;
  assign T244 = T79 ? 3'h4 : T245;
  assign T245 = T78 ? 3'h4 : T246;
  assign T246 = T77 ? 3'h4 : T247;
  assign T247 = T76 ? 3'h4 : 3'h0;
  assign csr_ren = T249 & T248;
  assign T248 = rs1_addr == 5'h0;
  assign rs1_addr = io_dat_inst[5'h13:4'hf];
  assign T249 = T251 | T250;
  assign T250 = cs_csr_cmd == 3'h3;
  assign T251 = cs_csr_cmd == 3'h2;
  assign stall = T252 | io_resetSignal;
  assign T252 = T257 | T253;
  assign T253 = T254 ^ 1'h1;
  assign T254 = T256 | T255;
  assign T255 = cs_mem_en ^ 1'h1;
  assign T256 = cs_mem_en & io_dmem_resp_valid;
  assign T257 = io_imem_resp_valid ^ 1'h1;
  assign io_ctl_rf_wen = T258;
  assign T258 = T300 ? 1'h0 : cs_rf_wen;
  assign cs_rf_wen = T21 ? 1'h1 : T259;
  assign T259 = T19 ? 1'h1 : T260;
  assign T260 = T17 ? 1'h1 : T261;
  assign T261 = T15 ? 1'h1 : T262;
  assign T262 = T13 ? 1'h1 : T263;
  assign T263 = T11 ? 1'h0 : T264;
  assign T264 = T9 ? 1'h0 : T265;
  assign T265 = T7 ? 1'h0 : T266;
  assign T266 = T148 ? 1'h1 : T267;
  assign T267 = T146 ? 1'h1 : T268;
  assign T268 = T144 ? 1'h1 : T269;
  assign T269 = T142 ? 1'h1 : T270;
  assign T270 = T140 ? 1'h1 : T271;
  assign T271 = T138 ? 1'h1 : T272;
  assign T272 = T136 ? 1'h1 : T273;
  assign T273 = T134 ? 1'h1 : T274;
  assign T274 = T132 ? 1'h1 : T275;
  assign T275 = T130 ? 1'h1 : T276;
  assign T276 = T128 ? 1'h1 : T277;
  assign T277 = T126 ? 1'h1 : T278;
  assign T278 = T124 ? 1'h1 : T279;
  assign T279 = T122 ? 1'h1 : T280;
  assign T280 = T120 ? 1'h1 : T281;
  assign T281 = T118 ? 1'h1 : T282;
  assign T282 = T116 ? 1'h1 : T283;
  assign T283 = T114 ? 1'h1 : T284;
  assign T284 = T112 ? 1'h1 : T285;
  assign T285 = T110 ? 1'h1 : T286;
  assign T286 = T108 ? 1'h1 : T287;
  assign T287 = T106 ? 1'h1 : T288;
  assign T288 = T104 ? 1'h1 : T289;
  assign T289 = T102 ? 1'h0 : T290;
  assign T290 = T100 ? 1'h0 : T291;
  assign T291 = T98 ? 1'h0 : T292;
  assign T292 = T96 ? 1'h0 : T293;
  assign T293 = T94 ? 1'h0 : T294;
  assign T294 = T92 ? 1'h0 : T295;
  assign T295 = T90 ? 1'h1 : T296;
  assign T296 = T88 ? 1'h1 : T297;
  assign T297 = T86 ? 1'h1 : T298;
  assign T298 = T84 ? 1'h1 : T299;
  assign T299 = T82 ? 1'h1 : T80;
  assign T300 = stall | io_ctl_exception;
  assign io_ctl_wb_sel = T525;
  assign T525 = {1'h0, cs_wb_sel};
  assign cs_wb_sel = T21 ? 2'h1 : T301;
  assign T301 = T19 ? 2'h1 : T302;
  assign T302 = T17 ? 2'h1 : T303;
  assign T303 = T15 ? 2'h1 : T304;
  assign T304 = T13 ? 2'h1 : T305;
  assign T305 = T11 ? 2'h0 : T306;
  assign T306 = T9 ? 2'h0 : T307;
  assign T307 = T7 ? 2'h0 : T308;
  assign T308 = T148 ? 2'h0 : T309;
  assign T309 = T146 ? 2'h0 : T310;
  assign T310 = T144 ? 2'h0 : T311;
  assign T311 = T142 ? 2'h0 : T312;
  assign T312 = T140 ? 2'h0 : T313;
  assign T313 = T138 ? 2'h0 : T314;
  assign T314 = T136 ? 2'h0 : T315;
  assign T315 = T134 ? 2'h0 : T316;
  assign T316 = T132 ? 2'h0 : T317;
  assign T317 = T130 ? 2'h0 : T318;
  assign T318 = T128 ? 2'h0 : T319;
  assign T319 = T126 ? 2'h0 : T320;
  assign T320 = T124 ? 2'h0 : T321;
  assign T321 = T122 ? 2'h0 : T322;
  assign T322 = T120 ? 2'h0 : T323;
  assign T323 = T118 ? 2'h0 : T324;
  assign T324 = T116 ? 2'h0 : T325;
  assign T325 = T114 ? 2'h0 : T326;
  assign T326 = T112 ? 2'h0 : T327;
  assign T327 = T110 ? 2'h0 : T328;
  assign T328 = T108 ? 2'h0 : T329;
  assign T329 = T106 ? 2'h2 : T330;
  assign T330 = T104 ? 2'h2 : T331;
  assign T331 = T102 ? 2'h0 : T332;
  assign T332 = T100 ? 2'h0 : T333;
  assign T333 = T98 ? 2'h0 : T334;
  assign T334 = T96 ? 2'h0 : T335;
  assign T335 = T94 ? 2'h0 : T336;
  assign T336 = T92 ? 2'h0 : T337;
  assign T337 = T90 ? 2'h3 : T338;
  assign T338 = T88 ? 2'h3 : T339;
  assign T339 = T86 ? 2'h3 : T340;
  assign T340 = T84 ? 2'h3 : T341;
  assign T341 = T82 ? 2'h3 : T342;
  assign T342 = T80 ? 2'h3 : 2'h0;
  assign io_ctl_alu_fun = cs_alu_fun;
  assign cs_alu_fun = T21 ? 4'h1 : T343;
  assign T343 = T19 ? 4'h1 : T344;
  assign T344 = T17 ? 4'h1 : T345;
  assign T345 = T15 ? 4'h1 : T346;
  assign T346 = T13 ? 4'h1 : T347;
  assign T347 = T11 ? 4'h1 : T348;
  assign T348 = T9 ? 4'h1 : T349;
  assign T349 = T7 ? 4'h1 : T350;
  assign T350 = T148 ? 4'h1 : T351;
  assign T351 = T146 ? 4'hb : T352;
  assign T352 = T144 ? 4'h1 : T353;
  assign T353 = T142 ? 4'h6 : T354;
  assign T354 = T140 ? 4'h7 : T355;
  assign T355 = T138 ? 4'h8 : T356;
  assign T356 = T136 ? 4'h9 : T357;
  assign T357 = T134 ? 4'ha : T358;
  assign T358 = T132 ? 4'h3 : T359;
  assign T359 = T130 ? 4'h5 : T360;
  assign T360 = T128 ? 4'h4 : T361;
  assign T361 = T126 ? 4'h3 : T362;
  assign T362 = T124 ? 4'h1 : T363;
  assign T363 = T122 ? 4'h2 : T364;
  assign T364 = T120 ? 4'h9 : T365;
  assign T365 = T118 ? 4'ha : T366;
  assign T366 = T116 ? 4'h6 : T367;
  assign T367 = T114 ? 4'h7 : T368;
  assign T368 = T112 ? 4'h8 : T369;
  assign T369 = T110 ? 4'h5 : T370;
  assign T370 = T108 ? 4'h4 : T371;
  assign T371 = T106 ? 4'h0 : T372;
  assign T372 = T104 ? 4'h0 : T373;
  assign T373 = T102 ? 4'h0 : T374;
  assign T374 = T100 ? 4'h0 : T375;
  assign T375 = T98 ? 4'h0 : T376;
  assign T376 = T96 ? 4'h0 : T377;
  assign T377 = T94 ? 4'h0 : T378;
  assign T378 = T92 ? 4'h0 : T379;
  assign T379 = T90 ? 4'hb : T380;
  assign T380 = T88 ? 4'hb : T381;
  assign T381 = T86 ? 4'hb : T382;
  assign T382 = T84 ? 4'hb : T383;
  assign T383 = T82 ? 4'hb : T384;
  assign T384 = T80 ? 4'hb : 4'h0;
  assign io_ctl_op2_sel = cs_op2_sel;
  assign cs_op2_sel = T21 ? 2'h1 : T385;
  assign T385 = T19 ? 2'h1 : T386;
  assign T386 = T17 ? 2'h1 : T387;
  assign T387 = T15 ? 2'h1 : T388;
  assign T388 = T13 ? 2'h1 : T389;
  assign T389 = T11 ? 2'h2 : T390;
  assign T390 = T9 ? 2'h2 : T391;
  assign T391 = T7 ? 2'h2 : T392;
  assign T392 = T148 ? 2'h3 : T393;
  assign T393 = T146 ? 2'h0 : T394;
  assign T394 = T144 ? 2'h1 : T395;
  assign T395 = T142 ? 2'h1 : T396;
  assign T396 = T140 ? 2'h1 : T397;
  assign T397 = T138 ? 2'h1 : T398;
  assign T398 = T136 ? 2'h1 : T399;
  assign T399 = T134 ? 2'h1 : T400;
  assign T400 = T132 ? 2'h1 : T401;
  assign T401 = T130 ? 2'h1 : T402;
  assign T402 = T128 ? 2'h1 : T403;
  assign T403 = T126 ? 2'h0 : T404;
  assign T404 = T124 ? 2'h0 : T405;
  assign T405 = T122 ? 2'h0 : T406;
  assign T406 = T120 ? 2'h0 : T407;
  assign T407 = T118 ? 2'h0 : T408;
  assign T408 = T116 ? 2'h0 : T409;
  assign T409 = T114 ? 2'h0 : T410;
  assign T410 = T112 ? 2'h0 : T411;
  assign T411 = T110 ? 2'h0 : T412;
  assign T412 = T108 ? 2'h0 : T413;
  assign T413 = T106 ? 2'h0 : T414;
  assign T414 = T104 ? 2'h1 : 2'h0;
  assign io_ctl_op1_sel = cs_op1_sel;
  assign cs_op1_sel = T21 ? 2'h0 : T415;
  assign T415 = T19 ? 2'h0 : T416;
  assign T416 = T17 ? 2'h0 : T417;
  assign T417 = T15 ? 2'h0 : T418;
  assign T418 = T13 ? 2'h0 : T419;
  assign T419 = T11 ? 2'h0 : T420;
  assign T420 = T9 ? 2'h0 : T421;
  assign T421 = T7 ? 2'h0 : T422;
  assign T422 = T148 ? 2'h1 : T423;
  assign T423 = T146 ? 2'h1 : T424;
  assign T424 = T144 ? 2'h0 : T425;
  assign T425 = T142 ? 2'h0 : T426;
  assign T426 = T140 ? 2'h0 : T427;
  assign T427 = T138 ? 2'h0 : T428;
  assign T428 = T136 ? 2'h0 : T429;
  assign T429 = T134 ? 2'h0 : T430;
  assign T430 = T132 ? 2'h0 : T431;
  assign T431 = T130 ? 2'h0 : T432;
  assign T432 = T128 ? 2'h0 : T433;
  assign T433 = T126 ? 2'h0 : T434;
  assign T434 = T124 ? 2'h0 : T435;
  assign T435 = T122 ? 2'h0 : T436;
  assign T436 = T120 ? 2'h0 : T437;
  assign T437 = T118 ? 2'h0 : T438;
  assign T438 = T116 ? 2'h0 : T439;
  assign T439 = T114 ? 2'h0 : T440;
  assign T440 = T112 ? 2'h0 : T441;
  assign T441 = T110 ? 2'h0 : T442;
  assign T442 = T108 ? 2'h0 : T443;
  assign T443 = T106 ? 2'h0 : T444;
  assign T444 = T104 ? 2'h0 : T445;
  assign T445 = T102 ? 2'h0 : T446;
  assign T446 = T100 ? 2'h0 : T447;
  assign T447 = T98 ? 2'h0 : T448;
  assign T448 = T96 ? 2'h0 : T449;
  assign T449 = T94 ? 2'h0 : T450;
  assign T450 = T92 ? 2'h0 : T451;
  assign T451 = T90 ? 2'h2 : T452;
  assign T452 = T88 ? 2'h2 : T453;
  assign T453 = T86 ? 2'h2 : 2'h0;
  assign io_ctl_pc_sel = ctrl_pc_sel;
  assign ctrl_pc_sel = T517 ? 3'h4 : T454;
  assign T454 = T516 ? 3'h0 : T455;
  assign T455 = T515 ? T513 : T456;
  assign T456 = T512 ? T511 : T457;
  assign T457 = T510 ? T508 : T458;
  assign T458 = T507 ? T505 : T459;
  assign T459 = T504 ? T503 : T460;
  assign T460 = T502 ? T501 : T461;
  assign T461 = T500 ? 3'h2 : T462;
  assign T462 = T463 ? 3'h3 : 3'h0;
  assign T463 = cs_br_type == 4'h8;
  assign cs_br_type = T21 ? 4'h0 : T464;
  assign T464 = T19 ? 4'h0 : T465;
  assign T465 = T17 ? 4'h0 : T466;
  assign T466 = T15 ? 4'h0 : T467;
  assign T467 = T13 ? 4'h0 : T468;
  assign T468 = T11 ? 4'h0 : T469;
  assign T469 = T9 ? 4'h0 : T470;
  assign T470 = T7 ? 4'h0 : T471;
  assign T471 = T148 ? 4'h0 : T472;
  assign T472 = T146 ? 4'h0 : T473;
  assign T473 = T144 ? 4'h0 : T474;
  assign T474 = T142 ? 4'h0 : T475;
  assign T475 = T140 ? 4'h0 : T476;
  assign T476 = T138 ? 4'h0 : T477;
  assign T477 = T136 ? 4'h0 : T478;
  assign T478 = T134 ? 4'h0 : T479;
  assign T479 = T132 ? 4'h0 : T480;
  assign T480 = T130 ? 4'h0 : T481;
  assign T481 = T128 ? 4'h0 : T482;
  assign T482 = T126 ? 4'h0 : T483;
  assign T483 = T124 ? 4'h0 : T484;
  assign T484 = T122 ? 4'h0 : T485;
  assign T485 = T120 ? 4'h0 : T486;
  assign T486 = T118 ? 4'h0 : T487;
  assign T487 = T116 ? 4'h0 : T488;
  assign T488 = T114 ? 4'h0 : T489;
  assign T489 = T112 ? 4'h0 : T490;
  assign T490 = T110 ? 4'h0 : T491;
  assign T491 = T108 ? 4'h0 : T492;
  assign T492 = T106 ? 4'h7 : T493;
  assign T493 = T104 ? 4'h8 : T494;
  assign T494 = T102 ? 4'h2 : T495;
  assign T495 = T100 ? 4'h1 : T496;
  assign T496 = T98 ? 4'h3 : T497;
  assign T497 = T96 ? 4'h4 : T498;
  assign T498 = T94 ? 4'h5 : T499;
  assign T499 = T92 ? 4'h6 : 4'h0;
  assign T500 = cs_br_type == 4'h7;
  assign T501 = io_dat_br_ltu ? 3'h1 : 3'h0;
  assign T502 = cs_br_type == 4'h6;
  assign T503 = io_dat_br_lt ? 3'h1 : 3'h0;
  assign T504 = cs_br_type == 4'h5;
  assign T505 = T506 ? 3'h1 : 3'h0;
  assign T506 = io_dat_br_ltu ^ 1'h1;
  assign T507 = cs_br_type == 4'h4;
  assign T508 = T509 ? 3'h1 : 3'h0;
  assign T509 = io_dat_br_lt ^ 1'h1;
  assign T510 = cs_br_type == 4'h3;
  assign T511 = io_dat_br_eq ? 3'h1 : 3'h0;
  assign T512 = cs_br_type == 4'h2;
  assign T513 = T514 ? 3'h1 : 3'h0;
  assign T514 = io_dat_br_eq ^ 1'h1;
  assign T515 = cs_br_type == 4'h1;
  assign T516 = cs_br_type == 4'h0;
  assign T517 = T518 | io_dat_csr_xcpt;
  assign T518 = io_ctl_exception | io_dat_csr_eret;
  assign io_ctl_stall = stall;
  assign io_dmem_req_bits_typ = cs_msk_sel;
  assign io_dmem_req_bits_fcn = cs_mem_fcn;
  assign cs_mem_fcn = T21 ? 1'h0 : T519;
  assign T519 = T19 ? 1'h0 : T520;
  assign T520 = T17 ? 1'h0 : T521;
  assign T521 = T15 ? 1'h0 : T522;
  assign T522 = T13 ? 1'h0 : T523;
  assign T523 = T11 ? 1'h1 : T524;
  assign T524 = T9 ? 1'h1 : T7;
  assign io_dmem_req_valid = cs_mem_en;
  assign io_imem_req_bits_typ = 3'h7;
  assign io_imem_req_bits_fcn = 1'h0;
  assign io_imem_req_valid = 1'h1;
endmodule

module CSRFile(input clk, input reset,
    input  io_host_reset,
    output io_host_debug_stats_csr,
    input  io_host_id,
    output io_host_csr_req_ready,
    input  io_host_csr_req_valid,
    input  io_host_csr_req_bits_rw,
    input [11:0] io_host_csr_req_bits_addr,
    input [63:0] io_host_csr_req_bits_data,
    input  io_host_csr_rep_ready,
    output io_host_csr_rep_valid,
    output[63:0] io_host_csr_rep_bits,
    input  io_host_ipi_req_ready,
    output io_host_ipi_req_valid,
    output io_host_ipi_req_bits,
    output io_host_ipi_rep_ready,
    input  io_host_ipi_rep_valid,
    input  io_host_ipi_rep_bits,
    //output io_host_mem_req_ready
    input  io_host_mem_req_valid,
    input  io_host_mem_req_bits_rw,
    input [63:0] io_host_mem_req_bits_addr,
    input [63:0] io_host_mem_req_bits_data,
    //output io_host_mem_rep_valid
    //output[63:0] io_host_mem_rep_bits
    input [11:0] io_rw_addr,
    input [2:0] io_rw_cmd,
    output[31:0] io_rw_rdata,
    input [31:0] io_rw_wdata,
    output io_csr_replay,
    output io_csr_stall,
    output io_csr_xcpt,
    output io_eret,
    output io_status_sd,
    output[30:0] io_status_zero2,
    output io_status_sd_rv32,
    output[8:0] io_status_zero1,
    output[4:0] io_status_vm,
    output io_status_mprv,
    output[1:0] io_status_xs,
    output[1:0] io_status_fs,
    output[1:0] io_status_prv3,
    output io_status_ie3,
    output[1:0] io_status_prv2,
    output io_status_ie2,
    output[1:0] io_status_prv1,
    output io_status_ie1,
    output[1:0] io_status_prv,
    output io_status_ie,
    //output[31:0] io_ptbr
    output[31:0] io_evec,
    input  io_exception,
    input  io_retire,
    input  io_uarch_counters_15,
    input  io_uarch_counters_14,
    input  io_uarch_counters_13,
    input  io_uarch_counters_12,
    input  io_uarch_counters_11,
    input  io_uarch_counters_10,
    input  io_uarch_counters_9,
    input  io_uarch_counters_8,
    input  io_uarch_counters_7,
    input  io_uarch_counters_6,
    input  io_uarch_counters_5,
    input  io_uarch_counters_4,
    input  io_uarch_counters_3,
    input  io_uarch_counters_2,
    input  io_uarch_counters_1,
    input  io_uarch_counters_0,
    input [31:0] io_cause,
    input [31:0] io_pc,
    output io_fatc,
    output[31:0] io_time,
    output io_interrupt,
    output[31:0] io_interrupt_cause
);

  reg[0:0] T0;
  wire T1;
  wire T2;
  wire[2:0] T3;
  wire[2:0] T4;
  wire[1:0] T5;
  wire[1:0] T6;
  wire[1:0] T623;
  wire csr_xcpt;
  wire insn_break;
  wire system_insn;
  wire T7;
  wire T8;
  wire T9;
  wire T10;
  wire T11;
  wire insn_call;
  wire T12;
  wire T13;
  wire T14;
  wire T15;
  wire T16;
  wire T17;
  wire T18;
  wire T19;
  wire priv_sufficient;
  reg [1:0] reg_mstatus_prv;
  wire[1:0] T20;
  wire[1:0] T21;
  wire[1:0] T22;
  wire[1:0] T23;
  wire T24;
  reg [1:0] reg_mstatus_prv1;
  wire[1:0] T25;
  wire[1:0] T26;
  wire[1:0] T27;
  wire[1:0] T28;
  reg [1:0] reg_mstatus_prv2;
  wire[1:0] T29;
  wire[1:0] T30;
  wire[1:0] T31;
  wire[1:0] T32;
  wire[63:0] wdata;
  wire[63:0] T33;
  wire[63:0] T34;
  reg [63:0] host_pcr_bits_data;
  wire[63:0] T35;
  wire[63:0] T36;
  wire T37;
  wire[63:0] T624;
  wire host_pcr_req_fire;
  wire T38;
  wire cpu_ren;
  wire T39;
  wire T40;
  reg  host_pcr_req_valid;
  wire T41;
  wire T42;
  wire[63:0] T625;
  wire[31:0] T43;
  wire T44;
  wire[63:0] T626;
  wire[31:0] T45;
  wire[31:0] T46;
  wire T47;
  wire[63:0] T627;
  wire T48;
  wire T49;
  wire T50;
  wire T51;
  wire T52;
  wire T53;
  wire T54;
  wire[11:0] addr;
  reg [11:0] host_pcr_bits_addr;
  wire[11:0] T55;
  wire wen;
  wire T56;
  reg  host_pcr_bits_rw;
  wire T57;
  wire T58;
  wire T59;
  wire read_only;
  wire[1:0] T60;
  wire cpu_wen;
  wire T61;
  wire T62;
  wire insn_ret;
  wire T63;
  wire T64;
  wire T65;
  wire T66;
  wire T67;
  wire T68;
  wire T69;
  wire T70;
  wire[1:0] T71;
  wire T72;
  wire T73;
  wire T74;
  wire T75;
  wire[1:0] csr_addr_priv;
  wire T76;
  wire T77;
  wire T78;
  wire T79;
  wire T80;
  wire T81;
  wire fp_csr;
  wire T82;
  wire T83;
  wire T84;
  wire T85;
  wire T86;
  wire T87;
  wire addr_valid;
  wire T88;
  wire T89;
  wire T90;
  wire T91;
  wire T92;
  wire T93;
  wire T94;
  wire T95;
  wire T96;
  wire T97;
  wire T98;
  wire T99;
  wire T100;
  wire T101;
  wire T102;
  wire T103;
  wire T104;
  wire T105;
  wire T106;
  wire T107;
  wire T108;
  wire T109;
  wire T110;
  wire T111;
  wire T112;
  wire T113;
  wire T114;
  wire T115;
  wire T116;
  wire T117;
  wire T118;
  wire T119;
  wire T120;
  wire T121;
  wire T122;
  wire T123;
  wire T124;
  wire T125;
  wire T126;
  wire T127;
  wire T128;
  wire T129;
  wire T130;
  wire T131;
  wire T132;
  wire T133;
  wire T134;
  wire T135;
  wire T136;
  wire T137;
  wire T138;
  wire T139;
  wire T140;
  wire T141;
  wire T142;
  wire T143;
  wire T144;
  wire T145;
  wire T146;
  wire T147;
  wire T148;
  wire T149;
  wire T150;
  wire T151;
  wire T152;
  wire T153;
  wire T154;
  wire T155;
  wire T156;
  wire T157;
  wire T158;
  wire T159;
  wire T160;
  wire T161;
  wire T162;
  wire T163;
  wire T164;
  wire T165;
  wire T166;
  wire T167;
  wire T168;
  wire T169;
  wire T170;
  wire T171;
  wire[2:0] T628;
  wire[1:0] T172;
  wire[1:0] T173;
  wire[1:0] T629;
  wire[31:0] T174;
  wire[31:0] T175;
  wire[31:0] T176;
  wire T177;
  wire T178;
  wire T179;
  reg  reg_mstatus_ie;
  wire T180;
  wire T181;
  wire T182;
  wire T183;
  reg  reg_mstatus_ie1;
  wire T184;
  wire T185;
  wire T186;
  wire T187;
  reg  reg_mstatus_ie2;
  wire T188;
  wire T189;
  wire T190;
  wire T191;
  wire T192;
  wire T193;
  wire T194;
  wire T195;
  reg  reg_mip_msip;
  wire T630;
  wire T196;
  wire T197;
  wire T198;
  wire T199;
  reg  reg_mie_msip;
  wire T631;
  wire T200;
  wire T201;
  wire T202;
  wire T203;
  wire T204;
  wire T205;
  wire T206;
  wire T207;
  wire T208;
  reg [31:0] reg_fromhost;
  wire[31:0] T632;
  wire[63:0] T633;
  wire[63:0] T209;
  wire[63:0] T634;
  wire T210;
  wire T211;
  wire T212;
  wire T213;
  wire T214;
  wire T215;
  wire T216;
  wire T217;
  wire T218;
  wire T219;
  wire T220;
  reg  reg_mip_mtip;
  wire T635;
  wire T221;
  wire T222;
  wire T223;
  wire[31:0] T224;
  reg [4:0] R225;
  wire[4:0] T636;
  wire[4:0] T226;
  wire[4:0] T227;
  wire[4:0] T228;
  wire[5:0] T229;
  wire[5:0] T637;
  wire[4:0] T230;
  wire T231;
  wire[4:0] T232;
  wire T233;
  reg [26:0] R234;
  wire[26:0] T638;
  wire[26:0] T235;
  wire[26:0] T236;
  wire[26:0] T237;
  wire[26:0] T238;
  wire T239;
  wire[26:0] T240;
  wire[26:0] T241;
  reg [31:0] reg_mtimecmp;
  wire[31:0] T639;
  wire[63:0] T242;
  wire[63:0] T640;
  wire T243;
  reg  reg_mie_mtip;
  wire T641;
  wire T244;
  wire T245;
  wire T246;
  wire insn_sfence_vm;
  wire T247;
  wire T248;
  wire T249;
  wire T250;
  wire T251;
  wire T252;
  wire T253;
  wire[31:0] T254;
  reg [31:0] reg_mepc;
  wire[31:0] T642;
  wire[63:0] T255;
  wire[63:0] T643;
  wire[31:0] T256;
  wire[31:0] T257;
  wire[63:0] T258;
  wire[63:0] T259;
  wire T260;
  wire[31:0] T644;
  wire[8:0] T261;
  wire[8:0] T645;
  wire[7:0] T262;
  wire T263;
  reg  reg_mstatus_ie3;
  wire T264;
  reg [1:0] reg_mstatus_prv3;
  wire[1:0] T265;
  wire[1:0] T646;
  wire T266;
  wire T267;
  reg [1:0] reg_mstatus_fs;
  wire[1:0] T268;
  wire[1:0] T647;
  wire T269;
  wire T270;
  reg [1:0] reg_mstatus_xs;
  wire[1:0] T271;
  reg  reg_mstatus_mprv;
  wire T272;
  wire T273;
  wire T274;
  wire T275;
  reg [4:0] reg_mstatus_vm;
  wire[4:0] T276;
  reg [8:0] reg_mstatus_zero1;
  wire[8:0] T277;
  reg [30:0] reg_mstatus_zero2;
  wire[30:0] T278;
  wire T279;
  wire T280;
  wire T281;
  reg  reg_wfi;
  wire T648;
  wire T282;
  wire T283;
  wire insn_wfi;
  wire T284;
  wire T285;
  wire T286;
  wire T287;
  wire T288;
  wire T289;
  wire T290;
  wire some_interrupt_pending;
  wire T291;
  wire T292;
  wire T293;
  wire T294;
  wire T295;
  wire T296;
  wire T297;
  wire T298;
  wire T299;
  wire T300;
  wire[31:0] T649;
  wire[63:0] T301;
  wire[63:0] T650;
  wire[31:0] T302;
  wire[31:0] T303;
  reg [4:0] R304;
  wire[4:0] T651;
  wire[4:0] T305;
  wire[4:0] T306;
  wire[5:0] T307;
  wire[5:0] T652;
  reg [26:0] R308;
  wire[26:0] T653;
  wire[26:0] T309;
  wire[26:0] T310;
  wire T311;
  wire T312;
  wire[63:0] T313;
  wire[63:0] T654;
  wire[31:0] T314;
  wire[31:0] T315;
  reg [4:0] R316;
  wire[4:0] T655;
  wire[4:0] T317;
  wire[4:0] T318;
  wire[5:0] T319;
  wire[5:0] T656;
  reg [26:0] R320;
  wire[26:0] T657;
  wire[26:0] T321;
  wire[26:0] T322;
  wire T323;
  wire T324;
  wire[63:0] T325;
  wire[63:0] T658;
  wire[31:0] T326;
  wire[31:0] T327;
  reg [4:0] R328;
  wire[4:0] T659;
  wire[4:0] T329;
  wire[4:0] T330;
  wire[5:0] T331;
  wire[5:0] T660;
  reg [26:0] R332;
  wire[26:0] T661;
  wire[26:0] T333;
  wire[26:0] T334;
  wire T335;
  wire T336;
  wire[63:0] T337;
  wire[63:0] T662;
  wire[31:0] T338;
  wire[31:0] T339;
  reg [4:0] R340;
  wire[4:0] T663;
  wire[4:0] T341;
  wire[4:0] T342;
  wire[5:0] T343;
  wire[5:0] T664;
  reg [26:0] R344;
  wire[26:0] T665;
  wire[26:0] T345;
  wire[26:0] T346;
  wire T347;
  wire T348;
  wire[63:0] T349;
  wire[63:0] T666;
  wire[31:0] T350;
  wire[31:0] T351;
  reg [4:0] R352;
  wire[4:0] T667;
  wire[4:0] T353;
  wire[4:0] T354;
  wire[5:0] T355;
  wire[5:0] T668;
  reg [26:0] R356;
  wire[26:0] T669;
  wire[26:0] T357;
  wire[26:0] T358;
  wire T359;
  wire T360;
  wire[63:0] T361;
  wire[63:0] T670;
  wire[31:0] T362;
  wire[31:0] T363;
  reg [4:0] R364;
  wire[4:0] T671;
  wire[4:0] T365;
  wire[4:0] T366;
  wire[5:0] T367;
  wire[5:0] T672;
  reg [26:0] R368;
  wire[26:0] T673;
  wire[26:0] T369;
  wire[26:0] T370;
  wire T371;
  wire T372;
  wire[63:0] T373;
  wire[63:0] T674;
  wire[31:0] T374;
  wire[31:0] T375;
  reg [4:0] R376;
  wire[4:0] T675;
  wire[4:0] T377;
  wire[4:0] T378;
  wire[5:0] T379;
  wire[5:0] T676;
  reg [26:0] R380;
  wire[26:0] T677;
  wire[26:0] T381;
  wire[26:0] T382;
  wire T383;
  wire T384;
  wire[63:0] T385;
  wire[63:0] T678;
  wire[31:0] T386;
  wire[31:0] T387;
  reg [4:0] R388;
  wire[4:0] T679;
  wire[4:0] T389;
  wire[4:0] T390;
  wire[5:0] T391;
  wire[5:0] T680;
  reg [26:0] R392;
  wire[26:0] T681;
  wire[26:0] T393;
  wire[26:0] T394;
  wire T395;
  wire T396;
  wire[63:0] T397;
  wire[63:0] T682;
  wire[31:0] T398;
  wire[31:0] T399;
  reg [4:0] R400;
  wire[4:0] T683;
  wire[4:0] T401;
  wire[4:0] T402;
  wire[5:0] T403;
  wire[5:0] T684;
  reg [26:0] R404;
  wire[26:0] T685;
  wire[26:0] T405;
  wire[26:0] T406;
  wire T407;
  wire T408;
  wire[63:0] T409;
  wire[63:0] T686;
  wire[31:0] T410;
  wire[31:0] T411;
  reg [4:0] R412;
  wire[4:0] T687;
  wire[4:0] T413;
  wire[4:0] T414;
  wire[5:0] T415;
  wire[5:0] T688;
  reg [26:0] R416;
  wire[26:0] T689;
  wire[26:0] T417;
  wire[26:0] T418;
  wire T419;
  wire T420;
  wire[63:0] T421;
  wire[63:0] T690;
  wire[31:0] T422;
  wire[31:0] T423;
  reg [4:0] R424;
  wire[4:0] T691;
  wire[4:0] T425;
  wire[4:0] T426;
  wire[5:0] T427;
  wire[5:0] T692;
  reg [26:0] R428;
  wire[26:0] T693;
  wire[26:0] T429;
  wire[26:0] T430;
  wire T431;
  wire T432;
  wire[63:0] T433;
  wire[63:0] T694;
  wire[31:0] T434;
  wire[31:0] T435;
  reg [4:0] R436;
  wire[4:0] T695;
  wire[4:0] T437;
  wire[4:0] T438;
  wire[5:0] T439;
  wire[5:0] T696;
  reg [26:0] R440;
  wire[26:0] T697;
  wire[26:0] T441;
  wire[26:0] T442;
  wire T443;
  wire T444;
  wire[63:0] T445;
  wire[63:0] T698;
  wire[31:0] T446;
  wire[31:0] T447;
  reg [4:0] R448;
  wire[4:0] T699;
  wire[4:0] T449;
  wire[4:0] T450;
  wire[5:0] T451;
  wire[5:0] T700;
  reg [26:0] R452;
  wire[26:0] T701;
  wire[26:0] T453;
  wire[26:0] T454;
  wire T455;
  wire T456;
  wire[63:0] T457;
  wire[63:0] T702;
  wire[31:0] T458;
  wire[31:0] T459;
  reg [4:0] R460;
  wire[4:0] T703;
  wire[4:0] T461;
  wire[4:0] T462;
  wire[5:0] T463;
  wire[5:0] T704;
  reg [26:0] R464;
  wire[26:0] T705;
  wire[26:0] T465;
  wire[26:0] T466;
  wire T467;
  wire T468;
  wire[63:0] T469;
  wire[63:0] T706;
  wire[31:0] T470;
  wire[31:0] T471;
  reg [4:0] R472;
  wire[4:0] T707;
  wire[4:0] T473;
  wire[4:0] T474;
  wire[5:0] T475;
  wire[5:0] T708;
  reg [26:0] R476;
  wire[26:0] T709;
  wire[26:0] T477;
  wire[26:0] T478;
  wire T479;
  wire T480;
  wire[63:0] T481;
  wire[63:0] T710;
  wire[31:0] T482;
  wire[31:0] T483;
  reg [4:0] R484;
  wire[4:0] T711;
  wire[4:0] T485;
  wire[4:0] T486;
  wire[5:0] T487;
  wire[5:0] T712;
  reg [26:0] R488;
  wire[26:0] T713;
  wire[26:0] T489;
  wire[26:0] T490;
  wire T491;
  wire T492;
  wire[63:0] T493;
  wire[63:0] T714;
  wire[31:0] T494;
  wire[63:0] T495;
  wire[63:0] T715;
  wire[31:0] T496;
  reg [31:0] reg_tohost;
  wire[31:0] T716;
  wire[63:0] T717;
  wire[63:0] T497;
  wire[63:0] T718;
  wire[31:0] T498;
  wire T499;
  wire T500;
  wire T501;
  wire T502;
  wire T503;
  wire T504;
  wire T505;
  wire[63:0] T506;
  wire[63:0] T719;
  wire T507;
  reg  reg_stats;
  wire T720;
  wire T508;
  wire T509;
  wire T510;
  wire[63:0] T511;
  wire[63:0] T721;
  wire T512;
  wire[63:0] T513;
  wire[63:0] T722;
  wire T514;
  wire[63:0] T515;
  wire[63:0] T723;
  wire[31:0] T516;
  wire[63:0] T517;
  wire[63:0] T724;
  wire[31:0] T518;
  reg [31:0] reg_mcause;
  wire[31:0] T725;
  wire[63:0] T519;
  wire[63:0] T726;
  wire[31:0] T520;
  wire[31:0] T521;
  wire[31:0] T522;
  wire[31:0] T523;
  wire T524;
  wire T525;
  wire[31:0] T727;
  wire[3:0] T526;
  wire[3:0] T728;
  wire T527;
  wire[63:0] T528;
  wire T529;
  wire[63:0] T530;
  wire[63:0] T729;
  wire[31:0] T531;
  reg [31:0] reg_mbadaddr;
  wire[31:0] T730;
  wire[63:0] T532;
  wire[63:0] T731;
  wire[31:0] T533;
  wire T534;
  wire[63:0] T535;
  wire[63:0] T732;
  wire[31:0] T536;
  wire[63:0] T537;
  wire[63:0] T733;
  wire[31:0] T538;
  reg [31:0] reg_mscratch;
  wire[31:0] T734;
  wire[63:0] T539;
  wire[63:0] T735;
  wire T540;
  wire[63:0] T541;
  wire[63:0] T736;
  wire[7:0] T542;
  wire[7:0] T543;
  wire[7:0] T544;
  wire[3:0] T545;
  wire[1:0] T546;
  reg  reg_mie_usip;
  wire T737;
  reg  reg_mie_ssip;
  wire T738;
  wire[1:0] T547;
  reg  reg_mie_hsip;
  wire T739;
  wire[3:0] T548;
  wire[1:0] T549;
  reg  reg_mie_utip;
  wire T740;
  reg  reg_mie_stip;
  wire T741;
  wire[1:0] T550;
  reg  reg_mie_htip;
  wire T742;
  wire[63:0] T551;
  wire[63:0] T743;
  wire[7:0] T552;
  wire[7:0] T553;
  wire[7:0] T554;
  wire[3:0] T555;
  wire[1:0] T556;
  reg  reg_mip_usip;
  wire T744;
  reg  reg_mip_ssip;
  wire T745;
  wire[1:0] T557;
  reg  reg_mip_hsip;
  wire T746;
  wire[3:0] T558;
  wire[1:0] T559;
  reg  reg_mip_utip;
  wire T747;
  reg  reg_mip_stip;
  wire T748;
  wire[1:0] T560;
  reg  reg_mip_htip;
  wire T749;
  wire[63:0] T561;
  wire[63:0] T750;
  wire[8:0] T562;
  wire[63:0] T563;
  wire[63:0] T564;
  wire[63:0] T565;
  wire[63:0] read_mstatus;
  wire[63:0] T566;
  wire[11:0] T567;
  wire[5:0] T568;
  wire[2:0] T569;
  wire[2:0] T570;
  wire[5:0] T571;
  wire[2:0] T572;
  wire[2:0] T573;
  wire[51:0] T574;
  wire[9:0] T575;
  wire[3:0] T576;
  wire[5:0] T577;
  wire[41:0] T578;
  wire[9:0] T579;
  wire[31:0] T580;
  wire[63:0] T751;
  wire[31:0] T581;
  wire[31:0] T752;
  wire[15:0] T582;
  wire[31:0] T583;
  wire[31:0] T753;
  wire[8:0] T584;
  wire[31:0] T585;
  wire[31:0] T586;
  wire[31:0] T587;
  wire[31:0] T588;
  wire[31:0] T589;
  wire[31:0] T590;
  wire[31:0] T591;
  wire[31:0] T592;
  wire[31:0] T593;
  wire[31:0] T594;
  wire[31:0] T595;
  reg [4:0] R596;
  wire[4:0] T754;
  wire[4:0] T597;
  wire[4:0] T598;
  wire[4:0] T599;
  wire[5:0] T600;
  wire[5:0] T755;
  wire[4:0] T601;
  wire T602;
  reg [26:0] R603;
  wire[26:0] T756;
  wire[26:0] T604;
  wire[26:0] T605;
  wire[26:0] T606;
  wire T607;
  wire T608;
  wire[26:0] T609;
  wire[31:0] T610;
  wire[31:0] T611;
  wire[31:0] T612;
  wire[31:0] T613;
  wire[31:0] T614;
  wire[31:0] T615;
  wire T757;
  wire T616;
  reg  host_pcr_rep_valid;
  wire T617;
  wire T618;
  wire T619;
  wire T620;
  wire T621;
  wire T622;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    // #0.002;
    T0 = 1'b0;
    reg_mstatus_prv = {1{$random}};
    reg_mstatus_prv1 = {1{$random}};
    reg_mstatus_prv2 = {1{$random}};
    host_pcr_bits_data = {2{$random}};
    host_pcr_req_valid = {1{$random}};
    host_pcr_bits_addr = {1{$random}};
    host_pcr_bits_rw = {1{$random}};
    reg_mstatus_ie = {1{$random}};
    reg_mstatus_ie1 = {1{$random}};
    reg_mstatus_ie2 = {1{$random}};
    reg_mip_msip = {1{$random}};
    reg_mie_msip = {1{$random}};
    reg_fromhost = {1{$random}};
    reg_mip_mtip = {1{$random}};
    R225 = {1{$random}};
    R234 = {1{$random}};
    reg_mtimecmp = {1{$random}};
    reg_mie_mtip = {1{$random}};
    reg_mepc = {1{$random}};
    reg_mstatus_ie3 = {1{$random}};
    reg_mstatus_prv3 = {1{$random}};
    reg_mstatus_fs = {1{$random}};
    reg_mstatus_xs = {1{$random}};
    reg_mstatus_mprv = {1{$random}};
    reg_mstatus_vm = {1{$random}};
    reg_mstatus_zero1 = {1{$random}};
    reg_mstatus_zero2 = {1{$random}};
    reg_wfi = {1{$random}};
    R304 = {1{$random}};
    R308 = {1{$random}};
    R316 = {1{$random}};
    R320 = {1{$random}};
    R328 = {1{$random}};
    R332 = {1{$random}};
    R340 = {1{$random}};
    R344 = {1{$random}};
    R352 = {1{$random}};
    R356 = {1{$random}};
    R364 = {1{$random}};
    R368 = {1{$random}};
    R376 = {1{$random}};
    R380 = {1{$random}};
    R388 = {1{$random}};
    R392 = {1{$random}};
    R400 = {1{$random}};
    R404 = {1{$random}};
    R412 = {1{$random}};
    R416 = {1{$random}};
    R424 = {1{$random}};
    R428 = {1{$random}};
    R436 = {1{$random}};
    R440 = {1{$random}};
    R448 = {1{$random}};
    R452 = {1{$random}};
    R460 = {1{$random}};
    R464 = {1{$random}};
    R472 = {1{$random}};
    R476 = {1{$random}};
    R484 = {1{$random}};
    R488 = {1{$random}};
    reg_tohost = {1{$random}};
    reg_stats = {1{$random}};
    reg_mcause = {1{$random}};
    reg_mbadaddr = {1{$random}};
    reg_mscratch = {1{$random}};
    reg_mie_usip = {1{$random}};
    reg_mie_ssip = {1{$random}};
    reg_mie_hsip = {1{$random}};
    reg_mie_utip = {1{$random}};
    reg_mie_stip = {1{$random}};
    reg_mie_htip = {1{$random}};
    reg_mip_usip = {1{$random}};
    reg_mip_ssip = {1{$random}};
    reg_mip_hsip = {1{$random}};
    reg_mip_utip = {1{$random}};
    reg_mip_stip = {1{$random}};
    reg_mip_htip = {1{$random}};
    R596 = {1{$random}};
    R603 = {1{$random}};
    host_pcr_rep_valid = {1{$random}};
  end
// synthesis translate_on
`endif

`ifndef SYNTHESIS
// synthesis translate_off
//  assign io_ptbr = {1{$random}};
//  assign io_host_mem_rep_bits = {2{$random}};
//  assign io_host_mem_rep_valid = {1{$random}};
//  assign io_host_mem_req_ready = {1{$random}};
// synthesis translate_on
`endif
  assign T1 = T2 | reset;
  assign T2 = T3 <= 3'h1;
  assign T3 = T628 + T4;
  assign T4 = {1'h0, T5};
  assign T5 = T623 + T6;
  assign T6 = {1'h0, io_csr_replay};
  assign T623 = {1'h0, csr_xcpt};
  assign csr_xcpt = T11 | insn_break;
  assign insn_break = T7 & system_insn;
  assign system_insn = io_rw_cmd == 3'h4;
  assign T7 = T9 & T8;
  assign T8 = io_rw_addr[1'h0:1'h0];
  assign T9 = T10 ^ 1'h1;
  assign T10 = io_rw_addr[4'h8:4'h8];
  assign T11 = T17 | insn_call;
  assign insn_call = T12 & system_insn;
  assign T12 = T15 & T13;
  assign T13 = T14 ^ 1'h1;
  assign T14 = io_rw_addr[1'h0:1'h0];
  assign T15 = T16 ^ 1'h1;
  assign T16 = io_rw_addr[4'h8:4'h8];
  assign T17 = T76 | T18;
  assign T18 = system_insn & T19;
  assign T19 = priv_sufficient ^ 1'h1;
  assign priv_sufficient = csr_addr_priv <= reg_mstatus_prv;
  assign T20 = reset ? 2'h3 : T21;
  assign T21 = T72 ? T71 : T22;
  assign T22 = insn_ret ? reg_mstatus_prv1 : T23;
  assign T23 = T24 ? 2'h3 : reg_mstatus_prv;
  assign T24 = io_exception | csr_xcpt;
  assign T25 = reset ? 2'h3 : T26;
  assign T26 = T49 ? T32 : T27;
  assign T27 = insn_ret ? reg_mstatus_prv2 : T28;
  assign T28 = T24 ? reg_mstatus_prv : reg_mstatus_prv1;
  assign T29 = reset ? 2'h0 : T30;
  assign T30 = insn_ret ? 2'h0 : T31;
  assign T31 = T24 ? reg_mstatus_prv1 : reg_mstatus_prv2;
  assign T32 = wdata[3'h5:3'h4];
  assign wdata = T48 ? T627 : T33;
  assign T33 = T47 ? T626 : T34;
  assign T34 = T44 ? T625 : host_pcr_bits_data;
  assign T35 = host_pcr_req_fire ? T624 : T36;
  assign T36 = T37 ? io_host_csr_req_bits_data : host_pcr_bits_data;
  assign T37 = io_host_csr_req_ready & io_host_csr_req_valid;
  assign T624 = {32'h0, io_rw_rdata};
  assign host_pcr_req_fire = host_pcr_req_valid & T38;
  assign T38 = cpu_ren ^ 1'h1;
  assign cpu_ren = T40 & T39;
  assign T39 = system_insn ^ 1'h1;
  assign T40 = io_rw_cmd != 3'h0;
  assign T41 = host_pcr_req_fire ? 1'h0 : T42;
  assign T42 = T37 ? 1'h1 : host_pcr_req_valid;
  assign T625 = {32'h0, T43};
  assign T43 = io_rw_rdata | io_rw_wdata;
  assign T44 = io_rw_cmd == 3'h2;
  assign T626 = {32'h0, T45};
  assign T45 = io_rw_rdata & T46;
  assign T46 = ~ io_rw_wdata;
  assign T47 = io_rw_cmd == 3'h3;
  assign T627 = {32'h0, io_rw_wdata};
  assign T48 = io_rw_cmd == 3'h1;
  assign T49 = T53 & T50;
  assign T50 = T52 | T51;
  assign T51 = 2'h0 == T32;
  assign T52 = 2'h3 == T32;
  assign T53 = wen & T54;
  assign T54 = addr == 12'h300;
  assign addr = cpu_ren ? io_rw_addr : host_pcr_bits_addr;
  assign T55 = T37 ? io_host_csr_req_bits_addr : host_pcr_bits_addr;
  assign wen = T58 | T56;
  assign T56 = host_pcr_req_fire & host_pcr_bits_rw;
  assign T57 = T37 ? io_host_csr_req_bits_rw : host_pcr_bits_rw;
  assign T58 = cpu_wen & T59;
  assign T59 = read_only ^ 1'h1;
  assign read_only = T60 == 2'h3;
  assign T60 = io_rw_addr[4'hb:4'ha];
  assign cpu_wen = T61 & priv_sufficient;
  assign T61 = cpu_ren & T62;
  assign T62 = io_rw_cmd != 3'h5;
  assign insn_ret = T63 & priv_sufficient;
  assign T63 = T64 & system_insn;
  assign T64 = T67 & T65;
  assign T65 = T66 ^ 1'h1;
  assign T66 = io_rw_addr[1'h0:1'h0];
  assign T67 = T70 & T68;
  assign T68 = T69 ^ 1'h1;
  assign T69 = io_rw_addr[1'h1:1'h1];
  assign T70 = io_rw_addr[4'h8:4'h8];
  assign T71 = wdata[2'h2:1'h1];
  assign T72 = T53 & T73;
  assign T73 = T75 | T74;
  assign T74 = 2'h0 == T71;
  assign T75 = 2'h3 == T71;
  assign csr_addr_priv = io_rw_addr[4'h9:4'h8];
  assign T76 = T171 | T77;
  assign T77 = cpu_ren & T78;
  assign T78 = T86 | T79;
  assign T79 = fp_csr & T80;
  assign T80 = T81 ^ 1'h1;
  assign T81 = io_status_fs != 2'h0;
  assign fp_csr = T83 | T82;
  assign T82 = addr == 12'h3;
  assign T83 = T85 | T84;
  assign T84 = addr == 12'h2;
  assign T85 = addr == 12'h1;
  assign T86 = T170 | T87;
  assign T87 = addr_valid ^ 1'h1;
  assign addr_valid = T89 | T88;
  assign T88 = addr == 12'hccf;
  assign T89 = T91 | T90;
  assign T90 = addr == 12'hcce;
  assign T91 = T93 | T92;
  assign T92 = addr == 12'hccd;
  assign T93 = T95 | T94;
  assign T94 = addr == 12'hccc;
  assign T95 = T97 | T96;
  assign T96 = addr == 12'hccb;
  assign T97 = T99 | T98;
  assign T98 = addr == 12'hcca;
  assign T99 = T101 | T100;
  assign T100 = addr == 12'hcc9;
  assign T101 = T103 | T102;
  assign T102 = addr == 12'hcc8;
  assign T103 = T105 | T104;
  assign T104 = addr == 12'hcc7;
  assign T105 = T107 | T106;
  assign T106 = addr == 12'hcc6;
  assign T107 = T109 | T108;
  assign T108 = addr == 12'hcc5;
  assign T109 = T111 | T110;
  assign T110 = addr == 12'hcc4;
  assign T111 = T113 | T112;
  assign T112 = addr == 12'hcc3;
  assign T113 = T115 | T114;
  assign T114 = addr == 12'hcc2;
  assign T115 = T117 | T116;
  assign T116 = addr == 12'hcc1;
  assign T117 = T119 | T118;
  assign T118 = addr == 12'hcc0;
  assign T119 = T121 | T120;
  assign T120 = addr == 12'h781;
  assign T121 = T123 | T122;
  assign T122 = addr == 12'h780;
  assign T123 = T125 | T124;
  assign T124 = addr == 12'hc0;
  assign T125 = T127 | T126;
  assign T126 = addr == 12'h783;
  assign T127 = T129 | T128;
  assign T128 = addr == 12'hf10;
  assign T129 = T131 | T130;
  assign T130 = addr == 12'h321;
  assign T131 = T133 | T132;
  assign T132 = addr == 12'h342;
  assign T133 = T135 | T134;
  assign T134 = addr == 12'h343;
  assign T135 = T137 | T136;
  assign T136 = addr == 12'h341;
  assign T137 = T139 | T138;
  assign T138 = addr == 12'h340;
  assign T139 = T141 | T140;
  assign T140 = addr == 12'h304;
  assign T141 = T143 | T142;
  assign T142 = addr == 12'h344;
  assign T143 = T145 | T144;
  assign T144 = addr == 12'h301;
  assign T145 = T147 | T146;
  assign T146 = addr == 12'h302;
  assign T147 = T148 | T54;
  assign T148 = T150 | T149;
  assign T149 = addr == 12'hf01;
  assign T150 = T152 | T151;
  assign T151 = addr == 12'hf00;
  assign T152 = T154 | T153;
  assign T153 = addr == 12'ha01;
  assign T154 = T156 | T155;
  assign T155 = addr == 12'hd01;
  assign T156 = T158 | T157;
  assign T157 = addr == 12'h901;
  assign T158 = T160 | T159;
  assign T159 = addr == 12'hc01;
  assign T160 = T162 | T161;
  assign T161 = addr == 12'h902;
  assign T162 = T164 | T163;
  assign T163 = addr == 12'hc02;
  assign T164 = T166 | T165;
  assign T165 = addr == 12'h900;
  assign T166 = T168 | T167;
  assign T167 = addr == 12'hc00;
  assign T168 = T169 | T82;
  assign T169 = T85 | T84;
  assign T170 = priv_sufficient ^ 1'h1;
  assign T171 = cpu_wen & read_only;
  assign T628 = {1'h0, T172};
  assign T172 = T629 + T173;
  assign T173 = {1'h0, io_exception};
  assign T629 = {1'h0, insn_ret};
  assign io_interrupt_cause = T174;
  assign T174 = T215 ? 32'h80000001 : T175;
  assign T175 = T203 ? 32'h80000002 : T176;
  assign T176 = T177 ? 32'h80000000 : 32'h0;
  assign T177 = T195 & T178;
  assign T178 = T194 | T179;
  assign T179 = T193 & reg_mstatus_ie;
  assign T180 = reset ? 1'h0 : T181;
  assign T181 = T53 ? T192 : T182;
  assign T182 = insn_ret ? reg_mstatus_ie1 : T183;
  assign T183 = T24 ? 1'h0 : reg_mstatus_ie;
  assign T184 = reset ? 1'h0 : T185;
  assign T185 = T53 ? T191 : T186;
  assign T186 = insn_ret ? reg_mstatus_ie2 : T187;
  assign T187 = T24 ? reg_mstatus_ie : reg_mstatus_ie1;
  assign T188 = reset ? 1'h0 : T189;
  assign T189 = insn_ret ? 1'h1 : T190;
  assign T190 = T24 ? reg_mstatus_ie1 : reg_mstatus_ie2;
  assign T191 = wdata[2'h3:2'h3];
  assign T192 = wdata[1'h0:1'h0];
  assign T193 = reg_mstatus_prv == 2'h3;
  assign T194 = reg_mstatus_prv < 2'h3;
  assign T195 = reg_mie_msip & reg_mip_msip;
  assign T630 = reset ? 1'h0 : T196;
  assign T196 = io_host_ipi_rep_valid ? 1'h1 : T197;
  assign T197 = T199 ? T198 : reg_mip_msip;
  assign T198 = wdata[2'h3:2'h3];
  assign T199 = wen & T142;
  assign T631 = reset ? 1'h0 : T200;
  assign T200 = T202 ? T201 : reg_mie_msip;
  assign T201 = wdata[2'h3:2'h3];
  assign T202 = wen & T140;
  assign T203 = T208 & T204;
  assign T204 = T207 | T205;
  assign T205 = T206 & reg_mstatus_ie;
  assign T206 = reg_mstatus_prv == 2'h3;
  assign T207 = reg_mstatus_prv < 2'h3;
  assign T208 = reg_fromhost != 32'h0;
  assign T632 = T633[5'h1f:1'h0];
  assign T633 = reset ? 64'h0 : T209;
  assign T209 = T210 ? wdata : T634;
  assign T634 = {32'h0, reg_fromhost};
  assign T210 = T214 & T211;
  assign T211 = T213 | T212;
  assign T212 = host_pcr_req_fire ^ 1'h1;
  assign T213 = reg_fromhost == 32'h0;
  assign T214 = wen & T120;
  assign T215 = T220 & T216;
  assign T216 = T219 | T217;
  assign T217 = T218 & reg_mstatus_ie;
  assign T218 = reg_mstatus_prv == 2'h3;
  assign T219 = reg_mstatus_prv < 2'h3;
  assign T220 = reg_mie_mtip & reg_mip_mtip;
  assign T635 = reset ? 1'h0 : T221;
  assign T221 = T243 ? 1'h0 : T222;
  assign T222 = T223 ? 1'h1 : reg_mip_mtip;
  assign T223 = reg_mtimecmp <= T224;
  assign T224 = {R234, R225};
  assign T636 = reset ? 5'h0 : T226;
  assign T226 = T233 ? T232 : T227;
  assign T227 = T231 ? T230 : T228;
  assign T228 = T229[3'h4:1'h0];
  assign T229 = T637 + 6'h1;
  assign T637 = {1'h0, R225};
  assign T230 = wdata[3'h4:1'h0];
  assign T231 = wen & T165;
  assign T232 = wdata[3'h4:1'h0];
  assign T233 = wen & T157;
  assign T638 = reset ? 27'h0 : T235;
  assign T235 = T233 ? T241 : T236;
  assign T236 = T231 ? T240 : T237;
  assign T237 = T239 ? T238 : R234;
  assign T238 = R234 + 27'h1;
  assign T239 = T229[3'h5:3'h5];
  assign T240 = wdata[5'h1f:3'h5];
  assign T241 = wdata[5'h1f:3'h5];
  assign T639 = T242[5'h1f:1'h0];
  assign T242 = T243 ? wdata : T640;
  assign T640 = {32'h0, reg_mtimecmp};
  assign T243 = wen & T130;
  assign T641 = reset ? 1'h0 : T244;
  assign T244 = T202 ? T245 : reg_mie_mtip;
  assign T245 = wdata[3'h7:3'h7];
  assign io_interrupt = T246;
  assign T246 = io_interrupt_cause[5'h1f:5'h1f];
  assign io_time = T224;
  assign io_fatc = insn_sfence_vm;
  assign insn_sfence_vm = T247 & priv_sufficient;
  assign T247 = T248 & system_insn;
  assign T248 = T250 & T249;
  assign T249 = io_rw_addr[1'h0:1'h0];
  assign T250 = T253 & T251;
  assign T251 = T252 ^ 1'h1;
  assign T252 = io_rw_addr[1'h1:1'h1];
  assign T253 = io_rw_addr[4'h8:4'h8];
  assign io_evec = T254;
  assign T254 = T263 ? T644 : reg_mepc;
  assign T642 = T255[5'h1f:1'h0];
  assign T255 = T260 ? T258 : T643;
  assign T643 = {32'h0, T256};
  assign T256 = T24 ? T257 : reg_mepc;
  assign T257 = io_pc & 32'hfffffffc;
  assign T258 = T259 & 64'hfffffffffffffffc;
  assign T259 = wdata;
  assign T260 = wen & T136;
  assign T644 = {23'h0, T261};
  assign T261 = T645 + 9'h100;
  assign T645 = {1'h0, T262};
  assign T262 = reg_mstatus_prv << 3'h6;
  assign T263 = io_exception | csr_xcpt;
  assign io_status_ie = reg_mstatus_ie;
  assign io_status_prv = reg_mstatus_prv;
  assign io_status_ie1 = reg_mstatus_ie1;
  assign io_status_prv1 = reg_mstatus_prv1;
  assign io_status_ie2 = reg_mstatus_ie2;
  assign io_status_prv2 = reg_mstatus_prv2;
  assign io_status_ie3 = reg_mstatus_ie3;
  assign T264 = reset ? 1'h0 : reg_mstatus_ie3;
  assign io_status_prv3 = reg_mstatus_prv3;
  assign T265 = reset ? 2'h0 : reg_mstatus_prv3;
  assign io_status_fs = T646;
  assign T646 = T266 ? 2'h3 : 2'h0;
  assign T266 = T267;
  assign T267 = reg_mstatus_fs != 2'h0;
  assign T268 = reset ? 2'h0 : reg_mstatus_fs;
  assign io_status_xs = T647;
  assign T647 = T269 ? 2'h3 : 2'h0;
  assign T269 = T270;
  assign T270 = reg_mstatus_xs != 2'h0;
  assign T271 = reset ? 2'h0 : reg_mstatus_xs;
  assign io_status_mprv = reg_mstatus_mprv;
  assign T272 = reset ? 1'h0 : T273;
  assign T273 = T53 ? T275 : T274;
  assign T274 = T24 ? 1'h0 : reg_mstatus_mprv;
  assign T275 = wdata[5'h10:5'h10];
  assign io_status_vm = reg_mstatus_vm;
  assign T276 = reset ? 5'h0 : reg_mstatus_vm;
  assign io_status_zero1 = reg_mstatus_zero1;
  assign T277 = reset ? 9'h0 : reg_mstatus_zero1;
  assign io_status_sd_rv32 = io_status_sd;
  assign io_status_zero2 = reg_mstatus_zero2;
  assign T278 = reset ? 31'h0 : reg_mstatus_zero2;
  assign io_status_sd = T279;
  assign T279 = T281 | T280;
  assign T280 = reg_mstatus_fs != 2'h0;
  assign T281 = reg_mstatus_xs != 2'h0;
  assign io_eret = insn_ret;
  assign io_csr_xcpt = csr_xcpt;
  assign io_csr_stall = reg_wfi;
  assign T648 = reset ? 1'h0 : T282;
  assign T282 = some_interrupt_pending ? 1'h0 : T283;
  assign T283 = insn_wfi ? 1'h1 : reg_wfi;
  assign insn_wfi = T284 & priv_sufficient;
  assign T284 = T285 & system_insn;
  assign T285 = T288 & T286;
  assign T286 = T287 ^ 1'h1;
  assign T287 = io_rw_addr[1'h0:1'h0];
  assign T288 = T290 & T289;
  assign T289 = io_rw_addr[1'h1:1'h1];
  assign T290 = io_rw_addr[4'h8:4'h8];
  assign some_interrupt_pending = T291;
  assign T291 = T297 ? 1'h1 : T292;
  assign T292 = T295 ? 1'h1 : T293;
  assign T293 = T195 & T294;
  assign T294 = reg_mstatus_prv <= 2'h3;
  assign T295 = T208 & T296;
  assign T296 = reg_mstatus_prv <= 2'h3;
  assign T297 = T220 & T298;
  assign T298 = reg_mstatus_prv <= 2'h3;
  assign io_csr_replay = T299;
  assign T299 = io_host_ipi_req_valid & T300;
  assign T300 = io_host_ipi_req_ready ^ 1'h1;
  assign io_rw_rdata = T649;
  assign T649 = T301[5'h1f:1'h0];
  assign T301 = T313 | T650;
  assign T650 = {32'h0, T302};
  assign T302 = T88 ? T303 : 32'h0;
  assign T303 = {R308, R304};
  assign T651 = reset ? 5'h0 : T305;
  assign T305 = io_uarch_counters_15 ? T306 : R304;
  assign T306 = T307[3'h4:1'h0];
  assign T307 = T652 + 6'h1;
  assign T652 = {1'h0, R304};
  assign T653 = reset ? 27'h0 : T309;
  assign T309 = T311 ? T310 : R308;
  assign T310 = R308 + 27'h1;
  assign T311 = io_uarch_counters_15 & T312;
  assign T312 = T307[3'h5:3'h5];
  assign T313 = T325 | T654;
  assign T654 = {32'h0, T314};
  assign T314 = T90 ? T315 : 32'h0;
  assign T315 = {R320, R316};
  assign T655 = reset ? 5'h0 : T317;
  assign T317 = io_uarch_counters_14 ? T318 : R316;
  assign T318 = T319[3'h4:1'h0];
  assign T319 = T656 + 6'h1;
  assign T656 = {1'h0, R316};
  assign T657 = reset ? 27'h0 : T321;
  assign T321 = T323 ? T322 : R320;
  assign T322 = R320 + 27'h1;
  assign T323 = io_uarch_counters_14 & T324;
  assign T324 = T319[3'h5:3'h5];
  assign T325 = T337 | T658;
  assign T658 = {32'h0, T326};
  assign T326 = T92 ? T327 : 32'h0;
  assign T327 = {R332, R328};
  assign T659 = reset ? 5'h0 : T329;
  assign T329 = io_uarch_counters_13 ? T330 : R328;
  assign T330 = T331[3'h4:1'h0];
  assign T331 = T660 + 6'h1;
  assign T660 = {1'h0, R328};
  assign T661 = reset ? 27'h0 : T333;
  assign T333 = T335 ? T334 : R332;
  assign T334 = R332 + 27'h1;
  assign T335 = io_uarch_counters_13 & T336;
  assign T336 = T331[3'h5:3'h5];
  assign T337 = T349 | T662;
  assign T662 = {32'h0, T338};
  assign T338 = T94 ? T339 : 32'h0;
  assign T339 = {R344, R340};
  assign T663 = reset ? 5'h0 : T341;
  assign T341 = io_uarch_counters_12 ? T342 : R340;
  assign T342 = T343[3'h4:1'h0];
  assign T343 = T664 + 6'h1;
  assign T664 = {1'h0, R340};
  assign T665 = reset ? 27'h0 : T345;
  assign T345 = T347 ? T346 : R344;
  assign T346 = R344 + 27'h1;
  assign T347 = io_uarch_counters_12 & T348;
  assign T348 = T343[3'h5:3'h5];
  assign T349 = T361 | T666;
  assign T666 = {32'h0, T350};
  assign T350 = T96 ? T351 : 32'h0;
  assign T351 = {R356, R352};
  assign T667 = reset ? 5'h0 : T353;
  assign T353 = io_uarch_counters_11 ? T354 : R352;
  assign T354 = T355[3'h4:1'h0];
  assign T355 = T668 + 6'h1;
  assign T668 = {1'h0, R352};
  assign T669 = reset ? 27'h0 : T357;
  assign T357 = T359 ? T358 : R356;
  assign T358 = R356 + 27'h1;
  assign T359 = io_uarch_counters_11 & T360;
  assign T360 = T355[3'h5:3'h5];
  assign T361 = T373 | T670;
  assign T670 = {32'h0, T362};
  assign T362 = T98 ? T363 : 32'h0;
  assign T363 = {R368, R364};
  assign T671 = reset ? 5'h0 : T365;
  assign T365 = io_uarch_counters_10 ? T366 : R364;
  assign T366 = T367[3'h4:1'h0];
  assign T367 = T672 + 6'h1;
  assign T672 = {1'h0, R364};
  assign T673 = reset ? 27'h0 : T369;
  assign T369 = T371 ? T370 : R368;
  assign T370 = R368 + 27'h1;
  assign T371 = io_uarch_counters_10 & T372;
  assign T372 = T367[3'h5:3'h5];
  assign T373 = T385 | T674;
  assign T674 = {32'h0, T374};
  assign T374 = T100 ? T375 : 32'h0;
  assign T375 = {R380, R376};
  assign T675 = reset ? 5'h0 : T377;
  assign T377 = io_uarch_counters_9 ? T378 : R376;
  assign T378 = T379[3'h4:1'h0];
  assign T379 = T676 + 6'h1;
  assign T676 = {1'h0, R376};
  assign T677 = reset ? 27'h0 : T381;
  assign T381 = T383 ? T382 : R380;
  assign T382 = R380 + 27'h1;
  assign T383 = io_uarch_counters_9 & T384;
  assign T384 = T379[3'h5:3'h5];
  assign T385 = T397 | T678;
  assign T678 = {32'h0, T386};
  assign T386 = T102 ? T387 : 32'h0;
  assign T387 = {R392, R388};
  assign T679 = reset ? 5'h0 : T389;
  assign T389 = io_uarch_counters_8 ? T390 : R388;
  assign T390 = T391[3'h4:1'h0];
  assign T391 = T680 + 6'h1;
  assign T680 = {1'h0, R388};
  assign T681 = reset ? 27'h0 : T393;
  assign T393 = T395 ? T394 : R392;
  assign T394 = R392 + 27'h1;
  assign T395 = io_uarch_counters_8 & T396;
  assign T396 = T391[3'h5:3'h5];
  assign T397 = T409 | T682;
  assign T682 = {32'h0, T398};
  assign T398 = T104 ? T399 : 32'h0;
  assign T399 = {R404, R400};
  assign T683 = reset ? 5'h0 : T401;
  assign T401 = io_uarch_counters_7 ? T402 : R400;
  assign T402 = T403[3'h4:1'h0];
  assign T403 = T684 + 6'h1;
  assign T684 = {1'h0, R400};
  assign T685 = reset ? 27'h0 : T405;
  assign T405 = T407 ? T406 : R404;
  assign T406 = R404 + 27'h1;
  assign T407 = io_uarch_counters_7 & T408;
  assign T408 = T403[3'h5:3'h5];
  assign T409 = T421 | T686;
  assign T686 = {32'h0, T410};
  assign T410 = T106 ? T411 : 32'h0;
  assign T411 = {R416, R412};
  assign T687 = reset ? 5'h0 : T413;
  assign T413 = io_uarch_counters_6 ? T414 : R412;
  assign T414 = T415[3'h4:1'h0];
  assign T415 = T688 + 6'h1;
  assign T688 = {1'h0, R412};
  assign T689 = reset ? 27'h0 : T417;
  assign T417 = T419 ? T418 : R416;
  assign T418 = R416 + 27'h1;
  assign T419 = io_uarch_counters_6 & T420;
  assign T420 = T415[3'h5:3'h5];
  assign T421 = T433 | T690;
  assign T690 = {32'h0, T422};
  assign T422 = T108 ? T423 : 32'h0;
  assign T423 = {R428, R424};
  assign T691 = reset ? 5'h0 : T425;
  assign T425 = io_uarch_counters_5 ? T426 : R424;
  assign T426 = T427[3'h4:1'h0];
  assign T427 = T692 + 6'h1;
  assign T692 = {1'h0, R424};
  assign T693 = reset ? 27'h0 : T429;
  assign T429 = T431 ? T430 : R428;
  assign T430 = R428 + 27'h1;
  assign T431 = io_uarch_counters_5 & T432;
  assign T432 = T427[3'h5:3'h5];
  assign T433 = T445 | T694;
  assign T694 = {32'h0, T434};
  assign T434 = T110 ? T435 : 32'h0;
  assign T435 = {R440, R436};
  assign T695 = reset ? 5'h0 : T437;
  assign T437 = io_uarch_counters_4 ? T438 : R436;
  assign T438 = T439[3'h4:1'h0];
  assign T439 = T696 + 6'h1;
  assign T696 = {1'h0, R436};
  assign T697 = reset ? 27'h0 : T441;
  assign T441 = T443 ? T442 : R440;
  assign T442 = R440 + 27'h1;
  assign T443 = io_uarch_counters_4 & T444;
  assign T444 = T439[3'h5:3'h5];
  assign T445 = T457 | T698;
  assign T698 = {32'h0, T446};
  assign T446 = T112 ? T447 : 32'h0;
  assign T447 = {R452, R448};
  assign T699 = reset ? 5'h0 : T449;
  assign T449 = io_uarch_counters_3 ? T450 : R448;
  assign T450 = T451[3'h4:1'h0];
  assign T451 = T700 + 6'h1;
  assign T700 = {1'h0, R448};
  assign T701 = reset ? 27'h0 : T453;
  assign T453 = T455 ? T454 : R452;
  assign T454 = R452 + 27'h1;
  assign T455 = io_uarch_counters_3 & T456;
  assign T456 = T451[3'h5:3'h5];
  assign T457 = T469 | T702;
  assign T702 = {32'h0, T458};
  assign T458 = T114 ? T459 : 32'h0;
  assign T459 = {R464, R460};
  assign T703 = reset ? 5'h0 : T461;
  assign T461 = io_uarch_counters_2 ? T462 : R460;
  assign T462 = T463[3'h4:1'h0];
  assign T463 = T704 + 6'h1;
  assign T704 = {1'h0, R460};
  assign T705 = reset ? 27'h0 : T465;
  assign T465 = T467 ? T466 : R464;
  assign T466 = R464 + 27'h1;
  assign T467 = io_uarch_counters_2 & T468;
  assign T468 = T463[3'h5:3'h5];
  assign T469 = T481 | T706;
  assign T706 = {32'h0, T470};
  assign T470 = T116 ? T471 : 32'h0;
  assign T471 = {R476, R472};
  assign T707 = reset ? 5'h0 : T473;
  assign T473 = io_uarch_counters_1 ? T474 : R472;
  assign T474 = T475[3'h4:1'h0];
  assign T475 = T708 + 6'h1;
  assign T708 = {1'h0, R472};
  assign T709 = reset ? 27'h0 : T477;
  assign T477 = T479 ? T478 : R476;
  assign T478 = R476 + 27'h1;
  assign T479 = io_uarch_counters_1 & T480;
  assign T480 = T475[3'h5:3'h5];
  assign T481 = T493 | T710;
  assign T710 = {32'h0, T482};
  assign T482 = T118 ? T483 : 32'h0;
  assign T483 = {R488, R484};
  assign T711 = reset ? 5'h0 : T485;
  assign T485 = io_uarch_counters_0 ? T486 : R484;
  assign T486 = T487[3'h4:1'h0];
  assign T487 = T712 + 6'h1;
  assign T712 = {1'h0, R484};
  assign T713 = reset ? 27'h0 : T489;
  assign T489 = T491 ? T490 : R488;
  assign T490 = R488 + 27'h1;
  assign T491 = io_uarch_counters_0 & T492;
  assign T492 = T487[3'h5:3'h5];
  assign T493 = T495 | T714;
  assign T714 = {32'h0, T494};
  assign T494 = T120 ? reg_fromhost : 32'h0;
  assign T495 = T506 | T715;
  assign T715 = {32'h0, T496};
  assign T496 = T122 ? reg_tohost : 32'h0;
  assign T716 = T717[5'h1f:1'h0];
  assign T717 = reset ? 64'h0 : T497;
  assign T497 = T502 ? wdata : T718;
  assign T718 = {32'h0, T498};
  assign T498 = T499 ? 32'h0 : reg_tohost;
  assign T499 = T500 & T122;
  assign T500 = host_pcr_req_fire & T501;
  assign T501 = host_pcr_bits_rw ^ 1'h1;
  assign T502 = T505 & T503;
  assign T503 = T504 | host_pcr_req_fire;
  assign T504 = reg_tohost == 32'h0;
  assign T505 = wen & T122;
  assign T506 = T511 | T719;
  assign T719 = {63'h0, T507};
  assign T507 = T124 ? reg_stats : 1'h0;
  assign T720 = reset ? 1'h0 : T508;
  assign T508 = T510 ? T509 : reg_stats;
  assign T509 = wdata[1'h0:1'h0];
  assign T510 = wen & T124;
  assign T511 = T513 | T721;
  assign T721 = {63'h0, T512};
  assign T512 = T126 ? io_host_id : 1'h0;
  assign T513 = T515 | T722;
  assign T722 = {63'h0, T514};
  assign T514 = T128 ? io_host_id : 1'h0;
  assign T515 = T517 | T723;
  assign T723 = {32'h0, T516};
  assign T516 = T130 ? reg_mtimecmp : 32'h0;
  assign T517 = T530 | T724;
  assign T724 = {32'h0, T518};
  assign T518 = T132 ? reg_mcause : 32'h0;
  assign T725 = T519[5'h1f:1'h0];
  assign T519 = T529 ? T528 : T726;
  assign T726 = {32'h0, T520};
  assign T520 = T527 ? T727 : T521;
  assign T521 = T525 ? 32'h3 : T522;
  assign T522 = T524 ? 32'h2 : T523;
  assign T523 = T24 ? io_cause : reg_mcause;
  assign T524 = T24 & csr_xcpt;
  assign T525 = T524 & insn_break;
  assign T727 = {28'h0, T526};
  assign T526 = T728 + 4'h8;
  assign T728 = {2'h0, reg_mstatus_prv};
  assign T527 = T524 & insn_call;
  assign T528 = wdata & 64'h8000001f;
  assign T529 = wen & T132;
  assign T530 = T535 | T729;
  assign T729 = {32'h0, T531};
  assign T531 = T134 ? reg_mbadaddr : 32'h0;
  assign T730 = T532[5'h1f:1'h0];
  assign T532 = T534 ? wdata : T731;
  assign T731 = {32'h0, T533};
  assign T533 = T24 ? io_pc : reg_mbadaddr;
  assign T534 = wen & T134;
  assign T535 = T537 | T732;
  assign T732 = {32'h0, T536};
  assign T536 = T136 ? reg_mepc : 32'h0;
  assign T537 = T541 | T733;
  assign T733 = {32'h0, T538};
  assign T538 = T138 ? reg_mscratch : 32'h0;
  assign T734 = T539[5'h1f:1'h0];
  assign T539 = T540 ? wdata : T735;
  assign T735 = {32'h0, reg_mscratch};
  assign T540 = wen & T138;
  assign T541 = T551 | T736;
  assign T736 = {56'h0, T542};
  assign T542 = T140 ? T543 : 8'h0;
  assign T543 = T544;
  assign T544 = {T548, T545};
  assign T545 = {T547, T546};
  assign T546 = {reg_mie_ssip, reg_mie_usip};
  assign T737 = reset ? 1'h0 : reg_mie_usip;
  assign T738 = reset ? 1'h0 : reg_mie_ssip;
  assign T547 = {reg_mie_msip, reg_mie_hsip};
  assign T739 = reset ? 1'h0 : reg_mie_hsip;
  assign T548 = {T550, T549};
  assign T549 = {reg_mie_stip, reg_mie_utip};
  assign T740 = reset ? 1'h0 : reg_mie_utip;
  assign T741 = reset ? 1'h0 : reg_mie_stip;
  assign T550 = {reg_mie_mtip, reg_mie_htip};
  assign T742 = reset ? 1'h0 : reg_mie_htip;
  assign T551 = T561 | T743;
  assign T743 = {56'h0, T552};
  assign T552 = T142 ? T553 : 8'h0;
  assign T553 = T554;
  assign T554 = {T558, T555};
  assign T555 = {T557, T556};
  assign T556 = {reg_mip_ssip, reg_mip_usip};
  assign T744 = reset ? 1'h0 : reg_mip_usip;
  assign T745 = reset ? 1'h0 : reg_mip_ssip;
  assign T557 = {reg_mip_msip, reg_mip_hsip};
  assign T746 = reset ? 1'h0 : reg_mip_hsip;
  assign T558 = {T560, T559};
  assign T559 = {reg_mip_stip, reg_mip_utip};
  assign T747 = reset ? 1'h0 : reg_mip_utip;
  assign T748 = reset ? 1'h0 : reg_mip_stip;
  assign T560 = {reg_mip_mtip, reg_mip_htip};
  assign T749 = reset ? 1'h0 : reg_mip_htip;
  assign T561 = T563 | T750;
  assign T750 = {55'h0, T562};
  assign T562 = T144 ? 9'h100 : 9'h0;
  assign T563 = T564 | 64'h0;
  assign T564 = T751 | T565;
  assign T565 = T54 ? read_mstatus : 64'h0;
  assign read_mstatus = T566;
  assign T566 = {T574, T567};
  assign T567 = {T571, T568};
  assign T568 = {T570, T569};
  assign T569 = {io_status_prv, io_status_ie};
  assign T570 = {io_status_prv1, io_status_ie1};
  assign T571 = {T573, T572};
  assign T572 = {io_status_prv2, io_status_ie2};
  assign T573 = {io_status_prv3, io_status_ie3};
  assign T574 = {T578, T575};
  assign T575 = {T577, T576};
  assign T576 = {io_status_xs, io_status_fs};
  assign T577 = {io_status_vm, io_status_mprv};
  assign T578 = {T580, T579};
  assign T579 = {io_status_sd_rv32, io_status_zero1};
  assign T580 = {io_status_sd, io_status_zero2};
  assign T751 = {32'h0, T581};
  assign T581 = T583 | T752;
  assign T752 = {16'h0, T582};
  assign T582 = T149 ? 16'h8000 : 16'h0;
  assign T583 = T585 | T753;
  assign T753 = {23'h0, T584};
  assign T584 = T151 ? 9'h100 : 9'h0;
  assign T585 = T587 | T586;
  assign T586 = T153 ? T224 : 32'h0;
  assign T587 = T589 | T588;
  assign T588 = T155 ? T224 : 32'h0;
  assign T589 = T591 | T590;
  assign T590 = T157 ? T224 : 32'h0;
  assign T591 = T593 | T592;
  assign T592 = T159 ? T224 : 32'h0;
  assign T593 = T610 | T594;
  assign T594 = T161 ? T595 : 32'h0;
  assign T595 = {R603, R596};
  assign T754 = reset ? 5'h0 : T597;
  assign T597 = T602 ? T601 : T598;
  assign T598 = io_retire ? T599 : R596;
  assign T599 = T600[3'h4:1'h0];
  assign T600 = T755 + 6'h1;
  assign T755 = {1'h0, R596};
  assign T601 = wdata[3'h4:1'h0];
  assign T602 = wen & T161;
  assign T756 = reset ? 27'h0 : T604;
  assign T604 = T602 ? T609 : T605;
  assign T605 = T607 ? T606 : R603;
  assign T606 = R603 + 27'h1;
  assign T607 = io_retire & T608;
  assign T608 = T600[3'h5:3'h5];
  assign T609 = wdata[5'h1f:3'h5];
  assign T610 = T612 | T611;
  assign T611 = T163 ? T595 : 32'h0;
  assign T612 = T614 | T613;
  assign T613 = T165 ? T224 : 32'h0;
  assign T614 = 32'h0 | T615;
  assign T615 = T167 ? T224 : 32'h0;
  assign io_host_ipi_rep_ready = 1'h1;
  assign io_host_ipi_req_bits = T757;
  assign T757 = io_rw_wdata[1'h0:1'h0];
  assign io_host_ipi_req_valid = T616;
  assign T616 = cpu_wen & T126;
  assign io_host_csr_rep_bits = host_pcr_bits_data;
  assign io_host_csr_rep_valid = host_pcr_rep_valid;
  assign T617 = T619 ? 1'h0 : T618;
  assign T618 = host_pcr_req_fire ? 1'h1 : host_pcr_rep_valid;
  assign T619 = io_host_csr_rep_ready & io_host_csr_rep_valid;
  assign io_host_csr_req_ready = T620;
  assign T620 = T622 & T621;
  assign T621 = host_pcr_rep_valid ^ 1'h1;
  assign T622 = host_pcr_req_valid ^ 1'h1;
  assign io_host_debug_stats_csr = reg_stats;

  always @(posedge clk) begin
`ifndef SYNTHESIS
// synthesis translate_off
  if(reset) T0 <= 1'b1;
  if(!T1 && T0 && !reset) begin
    $fwrite(32'h80000002, "ASSERTION FAILED: %s\n", "these conditions must be mutually exclusive");
    $finish;
  end
// synthesis translate_on
`endif
    if(reset) begin
      reg_mstatus_prv <= 2'h3;
    end else if(T72) begin
      reg_mstatus_prv <= T71;
    end else if(insn_ret) begin
      reg_mstatus_prv <= reg_mstatus_prv1;
    end else if(T24) begin
      reg_mstatus_prv <= 2'h3;
    end
    if(reset) begin
      reg_mstatus_prv1 <= 2'h3;
    end else if(T49) begin
      reg_mstatus_prv1 <= T32;
    end else if(insn_ret) begin
      reg_mstatus_prv1 <= reg_mstatus_prv2;
    end else if(T24) begin
      reg_mstatus_prv1 <= reg_mstatus_prv;
    end
    if(reset) begin
      reg_mstatus_prv2 <= 2'h0;
    end else if(insn_ret) begin
      reg_mstatus_prv2 <= 2'h0;
    end else if(T24) begin
      reg_mstatus_prv2 <= reg_mstatus_prv1;
    end
    if(host_pcr_req_fire) begin
      host_pcr_bits_data <= T624;
    end else if(T37) begin
      host_pcr_bits_data <= io_host_csr_req_bits_data;
    end
    if(host_pcr_req_fire) begin
      host_pcr_req_valid <= 1'h0;
    end else if(T37) begin
      host_pcr_req_valid <= 1'h1;
    end
    if(T37) begin
      host_pcr_bits_addr <= io_host_csr_req_bits_addr;
    end
    if(T37) begin
      host_pcr_bits_rw <= io_host_csr_req_bits_rw;
    end
    if(reset) begin
      reg_mstatus_ie <= 1'h0;
    end else if(T53) begin
      reg_mstatus_ie <= T192;
    end else if(insn_ret) begin
      reg_mstatus_ie <= reg_mstatus_ie1;
    end else if(T24) begin
      reg_mstatus_ie <= 1'h0;
    end
    if(reset) begin
      reg_mstatus_ie1 <= 1'h0;
    end else if(T53) begin
      reg_mstatus_ie1 <= T191;
    end else if(insn_ret) begin
      reg_mstatus_ie1 <= reg_mstatus_ie2;
    end else if(T24) begin
      reg_mstatus_ie1 <= reg_mstatus_ie;
    end
    if(reset) begin
      reg_mstatus_ie2 <= 1'h0;
    end else if(insn_ret) begin
      reg_mstatus_ie2 <= 1'h1;
    end else if(T24) begin
      reg_mstatus_ie2 <= reg_mstatus_ie1;
    end
    if(reset) begin
      reg_mip_msip <= 1'h0;
    end else if(io_host_ipi_rep_valid) begin
      reg_mip_msip <= 1'h1;
    end else if(T199) begin
      reg_mip_msip <= T198;
    end
    if(reset) begin
      reg_mie_msip <= 1'h0;
    end else if(T202) begin
      reg_mie_msip <= T201;
    end
    reg_fromhost <= T632;
    if(reset) begin
      reg_mip_mtip <= 1'h0;
    end else if(T243) begin
      reg_mip_mtip <= 1'h0;
    end else if(T223) begin
      reg_mip_mtip <= 1'h1;
    end
    if(reset) begin
      R225 <= 5'h0;
    end else if(T233) begin
      R225 <= T232;
    end else if(T231) begin
      R225 <= T230;
    end else begin
      R225 <= T228;
    end
    if(reset) begin
      R234 <= 27'h0;
    end else if(T233) begin
      R234 <= T241;
    end else if(T231) begin
      R234 <= T240;
    end else if(T239) begin
      R234 <= T238;
    end
    reg_mtimecmp <= T639;
    if(reset) begin
      reg_mie_mtip <= 1'h0;
    end else if(T202) begin
      reg_mie_mtip <= T245;
    end
    reg_mepc <= T642;
    if(reset) begin
      reg_mstatus_ie3 <= 1'h0;
    end
    if(reset) begin
      reg_mstatus_prv3 <= 2'h0;
    end
    if(reset) begin
      reg_mstatus_fs <= 2'h0;
    end
    if(reset) begin
      reg_mstatus_xs <= 2'h0;
    end
    if(reset) begin
      reg_mstatus_mprv <= 1'h0;
    end else if(T53) begin
      reg_mstatus_mprv <= T275;
    end else if(T24) begin
      reg_mstatus_mprv <= 1'h0;
    end
    if(reset) begin
      reg_mstatus_vm <= 5'h0;
    end
    if(reset) begin
      reg_mstatus_zero1 <= 9'h0;
    end
    if(reset) begin
      reg_mstatus_zero2 <= 31'h0;
    end
    if(reset) begin
      reg_wfi <= 1'h0;
    end else if(some_interrupt_pending) begin
      reg_wfi <= 1'h0;
    end else if(insn_wfi) begin
      reg_wfi <= 1'h1;
    end
    if(reset) begin
      R304 <= 5'h0;
    end else if(io_uarch_counters_15) begin
      R304 <= T306;
    end
    if(reset) begin
      R308 <= 27'h0;
    end else if(T311) begin
      R308 <= T310;
    end
    if(reset) begin
      R316 <= 5'h0;
    end else if(io_uarch_counters_14) begin
      R316 <= T318;
    end
    if(reset) begin
      R320 <= 27'h0;
    end else if(T323) begin
      R320 <= T322;
    end
    if(reset) begin
      R328 <= 5'h0;
    end else if(io_uarch_counters_13) begin
      R328 <= T330;
    end
    if(reset) begin
      R332 <= 27'h0;
    end else if(T335) begin
      R332 <= T334;
    end
    if(reset) begin
      R340 <= 5'h0;
    end else if(io_uarch_counters_12) begin
      R340 <= T342;
    end
    if(reset) begin
      R344 <= 27'h0;
    end else if(T347) begin
      R344 <= T346;
    end
    if(reset) begin
      R352 <= 5'h0;
    end else if(io_uarch_counters_11) begin
      R352 <= T354;
    end
    if(reset) begin
      R356 <= 27'h0;
    end else if(T359) begin
      R356 <= T358;
    end
    if(reset) begin
      R364 <= 5'h0;
    end else if(io_uarch_counters_10) begin
      R364 <= T366;
    end
    if(reset) begin
      R368 <= 27'h0;
    end else if(T371) begin
      R368 <= T370;
    end
    if(reset) begin
      R376 <= 5'h0;
    end else if(io_uarch_counters_9) begin
      R376 <= T378;
    end
    if(reset) begin
      R380 <= 27'h0;
    end else if(T383) begin
      R380 <= T382;
    end
    if(reset) begin
      R388 <= 5'h0;
    end else if(io_uarch_counters_8) begin
      R388 <= T390;
    end
    if(reset) begin
      R392 <= 27'h0;
    end else if(T395) begin
      R392 <= T394;
    end
    if(reset) begin
      R400 <= 5'h0;
    end else if(io_uarch_counters_7) begin
      R400 <= T402;
    end
    if(reset) begin
      R404 <= 27'h0;
    end else if(T407) begin
      R404 <= T406;
    end
    if(reset) begin
      R412 <= 5'h0;
    end else if(io_uarch_counters_6) begin
      R412 <= T414;
    end
    if(reset) begin
      R416 <= 27'h0;
    end else if(T419) begin
      R416 <= T418;
    end
    if(reset) begin
      R424 <= 5'h0;
    end else if(io_uarch_counters_5) begin
      R424 <= T426;
    end
    if(reset) begin
      R428 <= 27'h0;
    end else if(T431) begin
      R428 <= T430;
    end
    if(reset) begin
      R436 <= 5'h0;
    end else if(io_uarch_counters_4) begin
      R436 <= T438;
    end
    if(reset) begin
      R440 <= 27'h0;
    end else if(T443) begin
      R440 <= T442;
    end
    if(reset) begin
      R448 <= 5'h0;
    end else if(io_uarch_counters_3) begin
      R448 <= T450;
    end
    if(reset) begin
      R452 <= 27'h0;
    end else if(T455) begin
      R452 <= T454;
    end
    if(reset) begin
      R460 <= 5'h0;
    end else if(io_uarch_counters_2) begin
      R460 <= T462;
    end
    if(reset) begin
      R464 <= 27'h0;
    end else if(T467) begin
      R464 <= T466;
    end
    if(reset) begin
      R472 <= 5'h0;
    end else if(io_uarch_counters_1) begin
      R472 <= T474;
    end
    if(reset) begin
      R476 <= 27'h0;
    end else if(T479) begin
      R476 <= T478;
    end
    if(reset) begin
      R484 <= 5'h0;
    end else if(io_uarch_counters_0) begin
      R484 <= T486;
    end
    if(reset) begin
      R488 <= 27'h0;
    end else if(T491) begin
      R488 <= T490;
    end
    reg_tohost <= T716;
    if(reset) begin
      reg_stats <= 1'h0;
    end else if(T510) begin
      reg_stats <= T509;
    end
    reg_mcause <= T725;
    reg_mbadaddr <= T730;
    reg_mscratch <= T734;
    if(reset) begin
      reg_mie_usip <= 1'h0;
    end
    if(reset) begin
      reg_mie_ssip <= 1'h0;
    end
    if(reset) begin
      reg_mie_hsip <= 1'h0;
    end
    if(reset) begin
      reg_mie_utip <= 1'h0;
    end
    if(reset) begin
      reg_mie_stip <= 1'h0;
    end
    if(reset) begin
      reg_mie_htip <= 1'h0;
    end
    if(reset) begin
      reg_mip_usip <= 1'h0;
    end
    if(reset) begin
      reg_mip_ssip <= 1'h0;
    end
    if(reset) begin
      reg_mip_hsip <= 1'h0;
    end
    if(reset) begin
      reg_mip_utip <= 1'h0;
    end
    if(reset) begin
      reg_mip_stip <= 1'h0;
    end
    if(reset) begin
      reg_mip_htip <= 1'h0;
    end
    if(reset) begin
      R596 <= 5'h0;
    end else if(T602) begin
      R596 <= T601;
    end else if(io_retire) begin
      R596 <= T599;
    end
    if(reset) begin
      R603 <= 27'h0;
    end else if(T602) begin
      R603 <= T609;
    end else if(T607) begin
      R603 <= T606;
    end
    if(T619) begin
      host_pcr_rep_valid <= 1'h0;
    end else if(host_pcr_req_fire) begin
      host_pcr_rep_valid <= 1'h1;
    end
  end
endmodule

module DatPath(input clk, input reset,
    input        io_host_reset,
    output       io_host_debug_stats_csr,
    input        io_host_id,
    output       io_host_csr_req_ready,
    input        io_host_csr_req_valid,
    input        io_host_csr_req_bits_rw,
    input [11:0] io_host_csr_req_bits_addr,
    input [63:0] io_host_csr_req_bits_data,
    input        io_host_csr_rep_ready,
    output       io_host_csr_rep_valid,
    output [63:0] io_host_csr_rep_bits,
    input        io_host_ipi_req_ready,
    output       io_host_ipi_req_valid,
    output       io_host_ipi_req_bits,
    output       io_host_ipi_rep_ready,
    input        io_host_ipi_rep_valid,
    input        io_host_ipi_rep_bits,
    //output io_host_mem_req_ready
    input        io_host_mem_req_valid,
    input        io_host_mem_req_bits_rw,
    input [63:0] io_host_mem_req_bits_addr,
    input [63:0] io_host_mem_req_bits_data,
    //output io_host_mem_rep_valid
    //output[63:0] io_host_mem_rep_bits
    input        io_imem_req_ready,
    //output io_imem_req_valid
    output [31:0] io_imem_req_bits_addr,
    //output[31:0] io_imem_req_bits_data
    //output io_imem_req_bits_fcn
    //output[2:0] io_imem_req_bits_typ
    input        io_imem_resp_valid,
    input [31:0] io_imem_resp_bits_data,
    input        io_dmem_req_ready,
    //output io_dmem_req_valid
    output [31:0] io_dmem_req_bits_addr,
    output [31:0] io_dmem_req_bits_data,
    //output io_dmem_req_bits_fcn
    //output[2:0] io_dmem_req_bits_typ
    input        io_dmem_resp_valid,
    input [31:0] io_dmem_resp_bits_data,
    input        io_ctl_stall,
    input [2:0]  io_ctl_pc_sel,
    input [1:0]  io_ctl_op1_sel,
    input [1:0]  io_ctl_op2_sel,
    input [3:0]  io_ctl_alu_fun,
    input [2:0]  io_ctl_wb_sel,
    input        io_ctl_rf_wen,
    input [2:0]  io_ctl_csr_cmd,
    input        io_ctl_exception,
    input [31:0] io_ctl_exc_cause,
    input        io_ctl_debug_dmem_val,
    input [2:0]  io_ctl_debug_dmem_typ,
    output [31:0] io_dat_inst,
    output       io_dat_br_eq,
    output       io_dat_br_lt,
    output       io_dat_br_ltu,
    output       io_dat_csr_eret,
    output       io_dat_csr_interrupt,
    output       io_dat_csr_xcpt,
    output [31:0] io_dat_csr_interrupt_cause,
    output [31:0] T150
);

  wire T0;
  wire[31:0] T1;
  wire[31:0] inst;
  wire[15:0] T2;
  wire[15:0] T3;
  wire[15:0] T4;
  wire[15:0] T5;
  wire[15:0] T6;
  wire[15:0] T7;
  wire T8;
  wire T9;
  wire T10;
  wire T11;
  wire T12;
  wire[39:0] T13;
  wire[39:0] T14;
  wire[31:0] T15;
  reg [31:0] pc_reg;
  wire[31:0] T162;
  wire[31:0] T16;
  wire[31:0] pc_next;
  wire[31:0] T17;
  wire[31:0] T18;
  wire[31:0] T19;
  wire[31:0] T20;
  wire[31:0] T21;
  wire[31:0] exception_target;
  wire T22;
  wire[31:0] jump_reg_target;
  wire[31:0] T23;
  wire[31:0] T24;
  wire[31:0] imm_i_sext;
  wire[11:0] imm_i;
  wire[19:0] T25;
  wire T26;
  wire[31:0] T27;
  wire[31:0] rs1_data;
  wire[31:0] T28;
  reg [31:0] regfile [31:0];
  wire[31:0] T29;
  wire[31:0] wb_data;
  wire[31:0] T30;
  wire[31:0] T31;
  wire[31:0] T32;
  wire[31:0] T33;
  wire[31:0] T34;
  wire T35;
  wire T36;
  wire T37;
  wire[31:0] alu_out;
  wire[31:0] T38;
  wire[31:0] T39;
  wire[31:0] T40;
  wire[31:0] T41;
  wire[31:0] T42;
  wire[31:0] T43;
  wire[31:0] T44;
  wire[31:0] T45;
  wire[31:0] T46;
  wire[31:0] T47;
  wire[31:0] T48;
  wire[31:0] alu_op1;
  wire[31:0] T49;
  wire[31:0] T50;   
  wire[31:0] T51;
  wire[31:0] imm_z;
  wire[4:0] T52;
  wire T53;
  wire[31:0] imm_u_sext;
  wire[19:0] imm_u;
  wire T54;
  wire T55;
  wire T56;
  wire[31:0] T57;
  wire[31:0] T58;
  wire[4:0] alu_shamt;
  wire[4:0] T59;
  wire[31:0] alu_op2;
  wire[31:0] T60;
  wire[31:0] T61;
  wire[31:0] T62;
  wire[31:0] T63;
  wire[31:0] imm_s_sext;
  wire[11:0] imm_s;
  wire[4:0] T64;
  wire[6:0] T65;
  wire[19:0] T66;
  wire T67;
  wire T68;
  wire T69;
  wire T70;
  wire[31:0] rs2_data;
  wire[31:0] T71;
  wire[4:0] rs2_addr;
  wire T72;
  wire T73;
  wire T74;
  wire[31:0] T75;
  wire[31:0] T76;
  wire[31:0] T77;
  wire T78;
  wire[31:0] T79;
  wire[31:0] T80;
  wire[62:0] T81;
  wire T82;
  wire[31:0] T163;
  wire T83;
  wire T84;
  wire T85;
  wire[31:0] T164;
  wire T86;
  wire T87;
  wire[31:0] T88;
  wire[31:0] T89;
  wire T90;
  wire[31:0] T91;
  wire[31:0] T92;
  wire T93;
  wire[31:0] T94;
  wire[31:0] T95;
  wire T96;
  wire[31:0] T97;
  wire[31:0] T98;
  wire T99;
  wire[31:0] T100;
  wire[31:0] T101;
  wire T102;
  wire[31:0] T103;
  wire[31:0] T104;
  wire T105;
  wire T106;
  wire T107;
  wire T108;
  wire T109;
  wire T110;
  wire[4:0] wb_addr;
  wire[4:0] rs1_addr;
  wire T111;
  wire T112;
  wire[31:0] jmp_target;
  wire[31:0] T113;
  wire[31:0] imm_j_sext;
  wire[20:0] T114;
  wire[19:0] imm_j;
  wire[10:0] T115;
  wire[9:0] T116;
  wire T117;
  wire[8:0] T118;
  wire[7:0] T119;
  wire T120;
  wire[10:0] T121;
  wire T122;
  wire T123;
  wire[31:0] br_target;
  wire[31:0] T124;
  wire[31:0] imm_b_sext;
  wire[12:0] T125;
  wire[11:0] imm_b;
  wire[9:0] T126;
  wire[3:0] T127;
  wire[5:0] T128;
  wire[1:0] T129;
  wire T130;
  wire T131;
  wire[18:0] T132;
  wire T133;
  wire T134;
  wire[31:0] pc_plus4;
  wire[31:0] T135;
  wire T136;
  wire T137;
  wire[31:0] T138;
  wire[2:0] T139;
  wire[7:0] T140;
  wire[7:0] T141;
  wire[23:0] T142;
  wire[23:0] T143;
  wire[31:0] T144;
  wire[4:0] T145;
  wire[7:0] T146;
  wire[7:0] T147;
  wire[31:0] T148;
  wire[31:0] T149;
  wire[31:0] T150;
  wire[1063:0] T151;
  wire T152;
  wire[11:0] T153;
  wire T154;
  wire[31:0] T155;
  wire[31:0] T156;
  wire T157;
  wire[31:0] T158;
  wire[31:0] T159;
  wire T160;
  wire[31:0] T161;
  wire csr_io_host_debug_stats_csr;
  wire csr_io_host_csr_req_ready;
  wire csr_io_host_csr_rep_valid;
  wire[63:0] csr_io_host_csr_rep_bits;
  wire csr_io_host_ipi_req_valid;
  wire csr_io_host_ipi_req_bits;
  wire csr_io_host_ipi_rep_ready;
  wire[31:0] csr_io_rw_rdata;
  wire csr_io_csr_xcpt;
  wire csr_io_eret;
  wire[31:0] csr_io_evec;
  wire[31:0] csr_io_time;
  wire csr_io_interrupt;
  wire[31:0] csr_io_interrupt_cause;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    // #0.002;
    pc_reg = {1{$random}};
    for (initvar = 0; initvar < 32; initvar = initvar+1)
      regfile[initvar] = {1{$random}};
     regfile[2] = 32'h400000 - 32; // this is close to top of memory with size 2^23? upto 2^25 allowed currently
     
    // regfile[2] = 32'h99c; // TODO(kartiknayak): fix this hardcoded sp
//    regfile[2] = 32'h1000; // TODO(kartiknayak): fix this hardcoded sp
  end
// synthesis translate_on
`endif

`ifndef SYNTHESIS
// synthesis translate_off
//  assign io_dmem_req_bits_typ = {1{$random}};
//  assign io_dmem_req_bits_fcn = {1{$random}};
//  assign io_dmem_req_valid = {1{$random}};
//  assign io_imem_req_bits_typ = {1{$random}};
//  assign io_imem_req_bits_fcn = {1{$random}};
//  assign io_imem_req_bits_data = {1{$random}};
//  assign io_imem_req_valid = {1{$random}};
//  assign io_host_mem_rep_bits = {2{$random}};
//  assign io_host_mem_rep_valid = {1{$random}};
//  assign io_host_mem_req_ready = {1{$random}};
// synthesis translate_on
`endif
  assign T0 = reset ^ 1'h1;
  assign T1 = inst;
  assign inst = io_imem_resp_valid ? io_imem_resp_bits_data : 32'h4033;
  assign T2 = T3;
  assign T3 = T12 ? 16'h4252 : T4;
  assign T4 = T11 ? 16'h4a20 : T5;
  assign T5 = T10 ? 16'h4a52 : T6;
  assign T6 = T9 ? 16'h4558 : T7;
  assign T7 = T8 ? 16'h2020 : 16'h3f3f;
  assign T8 = io_ctl_pc_sel == 3'h0;
  assign T9 = io_ctl_pc_sel == 3'h4;
  assign T10 = io_ctl_pc_sel == 3'h3;
  assign T11 = io_ctl_pc_sel == 3'h2;
  assign T12 = io_ctl_pc_sel == 3'h1;
  assign T13 = T14;
  assign T14 = io_ctl_stall ? 40'h7374616c6c : 40'h2020202020;
  assign T15 = pc_reg;
  assign T162 = reset ? 32'h200 : T16;
  assign T16 = T137 ? pc_next : pc_reg;
  assign pc_next = T17;
  assign T17 = T136 ? pc_plus4 : T18;
  assign T18 = T134 ? br_target : T19;
  assign T19 = T123 ? jmp_target : T20;
  assign T20 = T112 ? jump_reg_target : T21;
  assign T21 = T22 ? exception_target : pc_plus4;
  assign exception_target = csr_io_evec;
  assign T22 = io_ctl_pc_sel == 3'h4;
  assign jump_reg_target = T23;
  assign T23 = T27 + T24;
  assign T24 = imm_i_sext;
  assign imm_i_sext = {T25, imm_i};
  assign imm_i = inst[5'h1f:5'h14];
  assign T25 = T26 ? 20'hfffff : 20'h0;
  assign T26 = imm_i[4'hb:4'hb];
  assign T27 = rs1_data;
  assign rs1_data = T111 ? T28 : 32'h0;
  assign T28 = regfile[rs1_addr];
  assign wb_data = T30;
  assign T30 = T31;
  assign T31 = T106 ? alu_out : T32;
  assign T32 = T37 ? io_dmem_resp_bits_data : T33;
  assign T33 = T36 ? pc_plus4 : T34;
  assign T34 = T35 ? csr_io_rw_rdata : alu_out;
  assign T35 = io_ctl_wb_sel == 3'h3;
  assign T36 = io_ctl_wb_sel == 3'h2;
  assign T37 = io_ctl_wb_sel == 3'h1;
  assign alu_out = T38;
  assign T38 = T105 ? T103 : T39;
  assign T39 = T102 ? T100 : T40;
  assign T40 = T99 ? T97 : T41;
  assign T41 = T96 ? T94 : T42;
  assign T42 = T93 ? T91 : T43;
  assign T43 = T90 ? T164 : T44;
  assign T44 = T85 ? T163 : T45;
  assign T45 = T82 ? T79 : T46;
  assign T46 = T78 ? T75 : T47;
  assign T47 = T74 ? T57 : T48;
  assign T48 = T56 ? alu_op1 : 32'h0;
  assign alu_op1 = T49;
  assign T49 = T55 ? rs1_data : T50;
  assign T50 = T54 ? imm_u_sext : T51;
  assign T51 = T53 ? imm_z : 32'h0;
  assign imm_z = {27'h0, T52};
  assign T52 = inst[5'h13:4'hf];
  assign T53 = io_ctl_op1_sel == 2'h2;
  assign imm_u_sext = {imm_u, 12'h0};
  assign imm_u = inst[5'h1f:4'hc];
  assign T54 = io_ctl_op1_sel == 2'h1;
  assign T55 = io_ctl_op1_sel == 2'h0;
  assign T56 = io_ctl_alu_fun == 4'hb;
  assign T57 = T58;
  assign T58 = alu_op1 >> alu_shamt;
  assign alu_shamt = T59;
  assign T59 = alu_op2[3'h4:1'h0];
  assign alu_op2 = T60;
  assign T60 = T73 ? rs2_data : T61;
  assign T61 = T70 ? pc_reg : T62;
  assign T62 = T69 ? imm_i_sext : T63;
  assign T63 = T68 ? imm_s_sext : 32'h0;
  assign imm_s_sext = {T66, imm_s};
  assign imm_s = {T65, T64};
  assign T64 = inst[4'hb:3'h7];
  assign T65 = inst[5'h1f:5'h19];
  assign T66 = T67 ? 20'hfffff : 20'h0;
  assign T67 = imm_s[4'hb:4'hb];
  assign T68 = io_ctl_op2_sel == 2'h2;
  assign T69 = io_ctl_op2_sel == 2'h1;
  assign T70 = io_ctl_op2_sel == 2'h3;
  assign rs2_data = T72 ? T71 : 32'h0;
  assign T71 = regfile[rs2_addr];
  assign rs2_addr = inst[5'h18:5'h14];
  assign T72 = rs2_addr != 5'h0;
  assign T73 = io_ctl_op2_sel == 2'h0;
  assign T74 = io_ctl_alu_fun == 4'h4;
  assign T75 = T76;
  assign T76 = $signed(T77) >>> alu_shamt;
  assign T77 = alu_op1;
  assign T78 = io_ctl_alu_fun == 4'h5;
  assign T79 = T80;
  assign T80 = T81[5'h1f:1'h0];
  assign T81 = alu_op1 << alu_shamt;
  assign T82 = io_ctl_alu_fun == 4'h3;
  assign T163 = {31'h0, T83};
  assign T83 = T84;
  assign T84 = alu_op1 < alu_op2;
  assign T85 = io_ctl_alu_fun == 4'ha;
  assign T164 = {31'h0, T86};
  assign T86 = T87;
  assign T87 = $signed(T89) < $signed(T88);
  assign T88 = alu_op2;
  assign T89 = alu_op1;
  assign T90 = io_ctl_alu_fun == 4'h9;
  assign T91 = T92;
  assign T92 = alu_op1 ^ alu_op2;
  assign T93 = io_ctl_alu_fun == 4'h8;
  assign T94 = T95;
  assign T95 = alu_op1 | alu_op2;
  assign T96 = io_ctl_alu_fun == 4'h7;
  assign T97 = T98;
  assign T98 = alu_op1 & alu_op2;
  assign T99 = io_ctl_alu_fun == 4'h6;
  assign T100 = T101;
  assign T101 = alu_op1 - alu_op2;
  assign T102 = io_ctl_alu_fun == 4'h2;
  assign T103 = T104;
  assign T104 = alu_op1 + alu_op2;
  assign T105 = io_ctl_alu_fun == 4'h1;
  assign T106 = io_ctl_wb_sel == 3'h0;
  assign T107 = T109 & T108;
  assign T108 = io_dat_csr_xcpt ^ 1'h1;
  assign T109 = io_ctl_rf_wen & T110;
  assign T110 = wb_addr != 5'h0;
  assign wb_addr = inst[4'hb:3'h7];
  assign rs1_addr = inst[5'h13:4'hf];
  assign T111 = rs1_addr != 5'h0;
  assign T112 = io_ctl_pc_sel == 3'h3;
  assign jmp_target = T113;
  assign T113 = pc_reg + imm_j_sext;
  assign imm_j_sext = {T121, T114};
  assign T114 = {imm_j, 1'h0};
  assign imm_j = {T118, T115};
  assign T115 = {T117, T116};
  assign T116 = inst[5'h1e:5'h15];
  assign T117 = inst[5'h14:5'h14];
  assign T118 = {T120, T119};
  assign T119 = inst[5'h13:4'hc];
  assign T120 = inst[5'h1f:5'h1f];
  assign T121 = T122 ? 11'h7ff : 11'h0;
  assign T122 = imm_j[5'h13:5'h13];
  assign T123 = io_ctl_pc_sel == 3'h2;
  assign br_target = T124;
  assign T124 = pc_reg + imm_b_sext;
  assign imm_b_sext = {T132, T125};
  assign T125 = {imm_b, 1'h0};
  assign imm_b = {T129, T126};
  assign T126 = {T128, T127};
  assign T127 = inst[4'hb:4'h8];
  assign T128 = inst[5'h1e:5'h19];
  assign T129 = {T131, T130};
  assign T130 = inst[3'h7:3'h7];
  assign T131 = inst[5'h1f:5'h1f];
  assign T132 = T133 ? 19'h7ffff : 19'h0;
  assign T133 = imm_b[4'hb:4'hb];
  assign T134 = io_ctl_pc_sel == 3'h1;
  assign pc_plus4 = T135;
  assign T135 = pc_reg + 32'h4;
  assign T136 = io_ctl_pc_sel == 3'h0;
  assign T137 = io_ctl_stall ^ 1'h1;
  assign T138 = io_dmem_resp_bits_data;
  assign T139 = io_ctl_debug_dmem_typ;
  assign T140 = T141;
  assign T141 = io_ctl_debug_dmem_val ? 8'h56 : 8'h5f;
  assign T142 = T143;
  assign T143 = io_ctl_exception ? 24'h455843 : 24'h202020;
  assign T144 = wb_data;
  assign T145 = wb_addr;
  assign T146 = T147;
  assign T147 = io_ctl_rf_wen ? 8'h57 : 8'h5f;
  assign T148 = alu_op2;
  assign T149 = alu_op1;
  assign T150 = csr_io_time;
  assign T152 = io_ctl_stall ^ 1'h1;
  assign T153 = inst[5'h1f:5'h14];
  assign io_dat_csr_interrupt_cause = csr_io_interrupt_cause;
  assign io_dat_csr_xcpt = csr_io_csr_xcpt;
  assign io_dat_csr_interrupt = csr_io_interrupt;
  assign io_dat_csr_eret = csr_io_eret;
  assign io_dat_br_ltu = T154;
  assign T154 = T156 < T155;
  assign T155 = rs2_data;
  assign T156 = rs1_data;
  assign io_dat_br_lt = T157;
  assign T157 = $signed(T159) < $signed(T158);
  assign T158 = rs2_data;
  assign T159 = rs1_data;
  assign io_dat_br_eq = T160;
  assign T160 = rs1_data == rs2_data;
  assign io_dat_inst = inst;
  assign io_dmem_req_bits_data = T161;
  assign T161 = rs2_data;
  assign io_dmem_req_bits_addr = alu_out;
  assign io_imem_req_bits_addr = pc_reg;
  assign io_host_ipi_rep_ready = csr_io_host_ipi_rep_ready;
  assign io_host_ipi_req_bits = csr_io_host_ipi_req_bits;
  assign io_host_ipi_req_valid = csr_io_host_ipi_req_valid;
  assign io_host_csr_rep_bits = csr_io_host_csr_rep_bits;
  assign io_host_csr_rep_valid = csr_io_host_csr_rep_valid;
  assign io_host_csr_req_ready = csr_io_host_csr_req_ready;
  assign io_host_debug_stats_csr = csr_io_host_debug_stats_csr;
  CSRFile csr(.clk(clk), .reset(reset),
       .io_host_reset( io_host_reset ),
       .io_host_debug_stats_csr( csr_io_host_debug_stats_csr ),
       .io_host_id( io_host_id ),
       .io_host_csr_req_ready( csr_io_host_csr_req_ready ),
       .io_host_csr_req_valid( io_host_csr_req_valid ),
       .io_host_csr_req_bits_rw( io_host_csr_req_bits_rw ),
       .io_host_csr_req_bits_addr( io_host_csr_req_bits_addr ),
       .io_host_csr_req_bits_data( io_host_csr_req_bits_data ),
       .io_host_csr_rep_ready( io_host_csr_rep_ready ),
       .io_host_csr_rep_valid( csr_io_host_csr_rep_valid ),
       .io_host_csr_rep_bits( csr_io_host_csr_rep_bits ),
       .io_host_ipi_req_ready( io_host_ipi_req_ready ),
       .io_host_ipi_req_valid( csr_io_host_ipi_req_valid ),
       .io_host_ipi_req_bits( csr_io_host_ipi_req_bits ),
       .io_host_ipi_rep_ready( csr_io_host_ipi_rep_ready ),
       .io_host_ipi_rep_valid( io_host_ipi_rep_valid ),
       .io_host_ipi_rep_bits( io_host_ipi_rep_bits ),
       //.io_host_mem_req_ready(  )
       .io_host_mem_req_valid( io_host_mem_req_valid ),
       .io_host_mem_req_bits_rw( io_host_mem_req_bits_rw ),
       .io_host_mem_req_bits_addr( io_host_mem_req_bits_addr ),
       .io_host_mem_req_bits_data( io_host_mem_req_bits_data ),
       //.io_host_mem_rep_valid(  )
       //.io_host_mem_rep_bits(  )
       .io_rw_addr( T153 ),
       .io_rw_cmd( io_ctl_csr_cmd ),
       .io_rw_rdata( csr_io_rw_rdata ),
       .io_rw_wdata( alu_out ),
       //.io_csr_replay(  )
       //.io_csr_stall(  )
       .io_csr_xcpt( csr_io_csr_xcpt ),
       .io_eret( csr_io_eret ),
       //.io_status_sd(  )
       //.io_status_zero2(  )
       //.io_status_sd_rv32(  )
       //.io_status_zero1(  )
       //.io_status_vm(  )
       //.io_status_mprv(  )
       //.io_status_xs(  )
       //.io_status_fs(  )
       //.io_status_prv3(  )
       //.io_status_ie3(  )
       //.io_status_prv2(  )
       //.io_status_ie2(  )
       //.io_status_prv1(  )
       //.io_status_ie1(  )
       //.io_status_prv(  )
       //.io_status_ie(  )
       //.io_ptbr(  )
       .io_evec( csr_io_evec ),
       .io_exception( io_ctl_exception ),
       .io_retire( T152 ),
       .io_uarch_counters_15( 1'h0 ),
       .io_uarch_counters_14( 1'h0 ),
       .io_uarch_counters_13( 1'h0 ),
       .io_uarch_counters_12( 1'h0 ),
       .io_uarch_counters_11( 1'h0 ),
       .io_uarch_counters_10( 1'h0 ),
       .io_uarch_counters_9( 1'h0 ),
       .io_uarch_counters_8( 1'h0 ),
       .io_uarch_counters_7( 1'h0 ),
       .io_uarch_counters_6( 1'h0 ),
       .io_uarch_counters_5( 1'h0 ),
       .io_uarch_counters_4( 1'h0 ),
       .io_uarch_counters_3( 1'h0 ),
       .io_uarch_counters_2( 1'h0 ),
       .io_uarch_counters_1( 1'h0 ),
       .io_uarch_counters_0( 1'h0 ),
       .io_cause( io_ctl_exc_cause ),
       .io_pc( pc_reg ),
       //.io_fatc(  )
       .io_time( csr_io_time ),
       .io_interrupt( csr_io_interrupt ),
       .io_interrupt_cause( csr_io_interrupt_cause )
  );

  always @(posedge clk) begin
    if(reset) begin
//      pc_reg <= 32'h10000;
//      pc_reg <= 32'h1008;
      pc_reg <= 32'h1000;
    end else if(T137) begin
      pc_reg <= pc_next;
    end
    if (T107)
      regfile[wb_addr] <= wb_data;
`ifndef SYNTHESIS
// synthesis translate_off
`ifdef PRINTF_COND
    if (`PRINTF_COND)
`endif
      // if (T0)
        // $fwrite(32'h80000002, "Cyc= %d Op1=[0x%h] Op2=[0x%h] W[%s,%d= 0x%h] %s Mem[%s %d: 0x%h] PC= 0x%h %s%s DASM(%h)\n", T150, T149, T148, T146, T145, T144, T142, T140, T139, T138, T15, T13, T2, T1);
      if (T15 == 32'h1f78) begin
         $stop;
      end
        // if (T138 == )
        // T138 contains Mem[%h]
// synthesis translate_on
`endif
  end
endmodule

module Core(input clk, input reset,
    input         io_host_reset,
    output        io_host_debug_stats_csr,
    input         io_host_id,
    output        io_host_csr_req_ready,
    input         io_host_csr_req_valid,
    input         io_host_csr_req_bits_rw,
    input [11:0]  io_host_csr_req_bits_addr,
    input [63:0]  io_host_csr_req_bits_data,
    input         io_host_csr_rep_ready,
    output        io_host_csr_rep_valid,
    output [63:0] io_host_csr_rep_bits,
    input         io_host_ipi_req_ready,
    output        io_host_ipi_req_valid,
    output        io_host_ipi_req_bits,
    output        io_host_ipi_rep_ready,
    input         io_host_ipi_rep_valid,
    input         io_host_ipi_rep_bits,
    //output io_host_mem_req_ready
    input         io_host_mem_req_valid,
    input         io_host_mem_req_bits_rw,
    input [63:0]  io_host_mem_req_bits_addr,
    input [63:0]  io_host_mem_req_bits_data,
    //output io_host_mem_rep_valid
    //output[63:0] io_host_mem_rep_bits
    input         io_imem_req_ready,
    output        io_imem_req_valid,
    output [31:0] io_imem_req_bits_addr,
    //output[31:0] io_imem_req_bits_data
    output        io_imem_req_bits_fcn,
    output [2:0]  io_imem_req_bits_typ,
    input         io_imem_resp_valid,
    input [31:0]  io_imem_resp_bits_data,
    input         io_dmem_req_ready,
    output        io_dmem_req_valid,
    output [31:0] io_dmem_req_bits_addr,
    output [31:0] io_dmem_req_bits_data,
    output        io_dmem_req_bits_fcn,
    output [2:0]  io_dmem_req_bits_typ,
    input         io_dmem_resp_valid,
    input [31:0]  io_dmem_resp_bits_data,
    output [31:0] datpath_T150
);

  wire c_io_imem_req_valid;
  wire c_io_imem_req_bits_fcn;
  wire[2:0] c_io_imem_req_bits_typ;
  wire c_io_dmem_req_valid;
  wire c_io_dmem_req_bits_fcn;
  wire[2:0] c_io_dmem_req_bits_typ;
  wire c_io_ctl_stall;
  wire[2:0] c_io_ctl_pc_sel;
  wire[1:0] c_io_ctl_op1_sel;
  wire[1:0] c_io_ctl_op2_sel;
  wire[3:0] c_io_ctl_alu_fun;
  wire[2:0] c_io_ctl_wb_sel;
  wire c_io_ctl_rf_wen;
  wire[2:0] c_io_ctl_csr_cmd;
  wire c_io_ctl_exception;
  wire[31:0] c_io_ctl_exc_cause;
  wire c_io_ctl_debug_dmem_val;
  wire[2:0] c_io_ctl_debug_dmem_typ;
  wire d_io_host_debug_stats_csr;
  wire d_io_host_csr_req_ready;
  wire d_io_host_csr_rep_valid;
  wire[63:0] d_io_host_csr_rep_bits;
  wire d_io_host_ipi_req_valid;
  wire d_io_host_ipi_req_bits;
  wire d_io_host_ipi_rep_ready;
  wire[31:0] d_io_imem_req_bits_addr;
  wire[31:0] d_io_dmem_req_bits_addr;
  wire[31:0] d_io_dmem_req_bits_data;
  wire[31:0] d_io_dat_inst;
  wire d_io_dat_br_eq;
  wire d_io_dat_br_lt;
  wire d_io_dat_br_ltu;
  wire d_io_dat_csr_eret;
  wire d_io_dat_csr_interrupt;
  wire d_io_dat_csr_xcpt;
  wire[31:0] d_io_dat_csr_interrupt_cause;
   


`ifndef SYNTHESIS
// synthesis translate_off
//  assign io_imem_req_bits_data = {1{$random}};
//  assign io_host_mem_rep_bits = {2{$random}};
//  assign io_host_mem_rep_valid = {1{$random}};
//  assign io_host_mem_req_ready = {1{$random}};
// synthesis translate_on
`endif
  assign io_dmem_req_bits_typ = c_io_dmem_req_bits_typ;
  assign io_dmem_req_bits_fcn = c_io_dmem_req_bits_fcn;
  assign io_dmem_req_bits_data = d_io_dmem_req_bits_data;
  assign io_dmem_req_bits_addr = d_io_dmem_req_bits_addr;
  assign io_dmem_req_valid = c_io_dmem_req_valid;
  assign io_imem_req_bits_typ = c_io_imem_req_bits_typ;
  assign io_imem_req_bits_fcn = c_io_imem_req_bits_fcn;
  assign io_imem_req_bits_addr = d_io_imem_req_bits_addr;
  assign io_imem_req_valid = c_io_imem_req_valid;
  assign io_host_ipi_rep_ready = d_io_host_ipi_rep_ready;
  assign io_host_ipi_req_bits = d_io_host_ipi_req_bits;
  assign io_host_ipi_req_valid = d_io_host_ipi_req_valid;
  assign io_host_csr_rep_bits = d_io_host_csr_rep_bits;
  assign io_host_csr_rep_valid = d_io_host_csr_rep_valid;
  assign io_host_csr_req_ready = d_io_host_csr_req_ready;
  assign io_host_debug_stats_csr = d_io_host_debug_stats_csr;
  CtlPath c(
       .io_imem_req_ready( io_imem_req_ready ),
       .io_imem_req_valid( c_io_imem_req_valid ),
       //.io_imem_req_bits_addr(  )
       //.io_imem_req_bits_data(  )
       .io_imem_req_bits_fcn( c_io_imem_req_bits_fcn ),
       .io_imem_req_bits_typ( c_io_imem_req_bits_typ ),
       .io_imem_resp_valid( io_imem_resp_valid ),
       .io_imem_resp_bits_data( io_imem_resp_bits_data ),
       .io_dmem_req_ready( io_dmem_req_ready ),
       .io_dmem_req_valid( c_io_dmem_req_valid ),
       //.io_dmem_req_bits_addr(  )
       //.io_dmem_req_bits_data(  )
       .io_dmem_req_bits_fcn( c_io_dmem_req_bits_fcn ),
       .io_dmem_req_bits_typ( c_io_dmem_req_bits_typ ),
       .io_dmem_resp_valid( io_dmem_resp_valid ),
       .io_dmem_resp_bits_data( io_dmem_resp_bits_data ),
       .io_dat_inst( d_io_dat_inst ),
       .io_dat_br_eq( d_io_dat_br_eq ),
       .io_dat_br_lt( d_io_dat_br_lt ),
       .io_dat_br_ltu( d_io_dat_br_ltu ),
       .io_dat_csr_eret( d_io_dat_csr_eret ),
       .io_dat_csr_interrupt( d_io_dat_csr_interrupt ),
       .io_dat_csr_xcpt( d_io_dat_csr_xcpt ),
       .io_dat_csr_interrupt_cause( d_io_dat_csr_interrupt_cause ),
       .io_ctl_stall( c_io_ctl_stall ),
       .io_ctl_pc_sel( c_io_ctl_pc_sel ),
       .io_ctl_op1_sel( c_io_ctl_op1_sel ),
       .io_ctl_op2_sel( c_io_ctl_op2_sel ),
       .io_ctl_alu_fun( c_io_ctl_alu_fun ),
       .io_ctl_wb_sel( c_io_ctl_wb_sel ),
       .io_ctl_rf_wen( c_io_ctl_rf_wen ),
       .io_ctl_csr_cmd( c_io_ctl_csr_cmd ),
       .io_ctl_exception( c_io_ctl_exception ),
       .io_ctl_exc_cause( c_io_ctl_exc_cause ),
       .io_ctl_debug_dmem_val( c_io_ctl_debug_dmem_val ),
       .io_ctl_debug_dmem_typ( c_io_ctl_debug_dmem_typ ),
       // .io_resetSignal( reset_signal )
       .io_resetSignal( reset ) // we changed this and assumed this is a correct change
  );
  DatPath d(.clk(clk), .reset(reset),
       .io_host_reset( io_host_reset ),
       .io_host_debug_stats_csr( d_io_host_debug_stats_csr ),
       .io_host_id( io_host_id ),
       .io_host_csr_req_ready( d_io_host_csr_req_ready ),
       .io_host_csr_req_valid( io_host_csr_req_valid ),
       .io_host_csr_req_bits_rw( io_host_csr_req_bits_rw ),
       .io_host_csr_req_bits_addr( io_host_csr_req_bits_addr ),
       .io_host_csr_req_bits_data( io_host_csr_req_bits_data ),
       .io_host_csr_rep_ready( io_host_csr_rep_ready ),
       .io_host_csr_rep_valid( d_io_host_csr_rep_valid ),
       .io_host_csr_rep_bits( d_io_host_csr_rep_bits ),
       .io_host_ipi_req_ready( io_host_ipi_req_ready ),
       .io_host_ipi_req_valid( d_io_host_ipi_req_valid ),
       .io_host_ipi_req_bits( d_io_host_ipi_req_bits ),
       .io_host_ipi_rep_ready( d_io_host_ipi_rep_ready ),
       .io_host_ipi_rep_valid( io_host_ipi_rep_valid ),
       .io_host_ipi_rep_bits( io_host_ipi_rep_bits ),
       //.io_host_mem_req_ready(  )
       .io_host_mem_req_valid( io_host_mem_req_valid ),
       .io_host_mem_req_bits_rw( io_host_mem_req_bits_rw ),
       .io_host_mem_req_bits_addr( io_host_mem_req_bits_addr ),
       .io_host_mem_req_bits_data( io_host_mem_req_bits_data ),
       //.io_host_mem_rep_valid(  )
       //.io_host_mem_rep_bits(  )
       .io_imem_req_ready( io_imem_req_ready ),
       //.io_imem_req_valid(  )
       .io_imem_req_bits_addr( d_io_imem_req_bits_addr ),
       //.io_imem_req_bits_data(  )
       //.io_imem_req_bits_fcn(  )
       //.io_imem_req_bits_typ(  )
       .io_imem_resp_valid( io_imem_resp_valid ),
       .io_imem_resp_bits_data( io_imem_resp_bits_data ),
       .io_dmem_req_ready( io_dmem_req_ready ),
       //.io_dmem_req_valid(  )
       .io_dmem_req_bits_addr( d_io_dmem_req_bits_addr ),
       .io_dmem_req_bits_data( d_io_dmem_req_bits_data ),
       //.io_dmem_req_bits_fcn(  )
       //.io_dmem_req_bits_typ(  )
       .io_dmem_resp_valid( io_dmem_resp_valid ),
       .io_dmem_resp_bits_data( io_dmem_resp_bits_data ),
       .io_ctl_stall( c_io_ctl_stall ),
       .io_ctl_pc_sel( c_io_ctl_pc_sel ),
       .io_ctl_op1_sel( c_io_ctl_op1_sel ),
       .io_ctl_op2_sel( c_io_ctl_op2_sel ),
       .io_ctl_alu_fun( c_io_ctl_alu_fun ),
       .io_ctl_wb_sel( c_io_ctl_wb_sel ),
       .io_ctl_rf_wen( c_io_ctl_rf_wen ),
       .io_ctl_csr_cmd( c_io_ctl_csr_cmd ),
       .io_ctl_exception( c_io_ctl_exception ),
       .io_ctl_exc_cause( c_io_ctl_exc_cause ),
       .io_ctl_debug_dmem_val( c_io_ctl_debug_dmem_val ),
       .io_ctl_debug_dmem_typ( c_io_ctl_debug_dmem_typ ),
       .io_dat_inst( d_io_dat_inst ),
       .io_dat_br_eq( d_io_dat_br_eq ),
       .io_dat_br_lt( d_io_dat_br_lt ),
       .io_dat_br_ltu( d_io_dat_br_ltu ),
       .io_dat_csr_eret( d_io_dat_csr_eret ),
       .io_dat_csr_interrupt( d_io_dat_csr_interrupt ),
       .io_dat_csr_xcpt( d_io_dat_csr_xcpt ),
       .io_dat_csr_interrupt_cause( d_io_dat_csr_interrupt_cause ),
            .T150(datpath_T150)
  );
endmodule

module ScratchPadMemory(input clk,
    output io_core_ports_1_req_ready,
    input  io_core_ports_1_req_valid,
    input [31:0] io_core_ports_1_req_bits_addr,
    input [31:0] io_core_ports_1_req_bits_data,
    input  io_core_ports_1_req_bits_fcn,
    input [2:0] io_core_ports_1_req_bits_typ,
    output io_core_ports_1_resp_valid,
    output[31:0] io_core_ports_1_resp_bits_data,
    output io_core_ports_0_req_ready,
    input  io_core_ports_0_req_valid,
    input [31:0] io_core_ports_0_req_bits_addr,
    input [31:0] io_core_ports_0_req_bits_data,
    input  io_core_ports_0_req_bits_fcn,
    input [2:0] io_core_ports_0_req_bits_typ,
    output io_core_ports_0_resp_valid,
    output[31:0] io_core_ports_0_resp_bits_data,
    output io_htif_port_req_ready,
    input  io_htif_port_req_valid,
    input [31:0] io_htif_port_req_bits_addr,
    input [63:0] io_htif_port_req_bits_data,
    input  io_htif_port_req_bits_fcn,
    //input [2:0] io_htif_port_req_bits_typ
    output io_htif_port_resp_valid,
    output[63:0] io_htif_port_resp_bits_data
);
`include "FSM.vh"
  wire[63:0] T0;
  wire[31:0] T1;
  reg [31:0] data_bank0 [262143:0];
  wire[31:0] T2;
  wire[31:0] T3;
  wire T4;
  wire T5;
  wire[17:0] T151;
  reg [28:0] htif_idx;
  wire[28:0] T80;
  wire[31:0] T6;
  wire[31:0] T7;
  wire[31:0] T8;
  wire[31:0] T9;
  wire[31:0] T10;
  wire[62:0] T11;
  wire[4:0] T12;
  wire[1:0] T13;
  wire[31:0] T14;
  wire[31:0] T15;
  wire T16;
  wire T17;
  wire T18;
  wire T19;
  wire T20;
  wire T21;
  wire[31:0] T22;
  wire[17:0] T152;
  wire[28:0] T42;
  wire[31:0] T23;
  wire[31:0] T24;
  wire[31:0] T25;
  wire[31:0] T26;
  wire[15:0] T27;
  wire T28;
  wire T29;
  wire T30;
  wire[31:0] T31;
  wire[15:0] T32;
  wire[7:0] T33;
  wire T34;
  wire T35;
  wire T36;
  wire T37;
  wire T38;
  wire T39;
  wire T40;
  wire T41;
  wire[17:0] T153;
  wire[31:0] T43;
  wire[31:0] T44;
  wire[31:0] T45;
  wire[31:0] T46;
  wire[31:0] T47;
  wire[62:0] T48;
  wire[4:0] T49;
  wire[1:0] T50;
  wire[31:0] T51;
  wire[31:0] T52;
  wire T53;
  wire T54;
  wire T55;
  wire T56;
  wire T57;
  wire T58;
  wire[31:0] T59;
  wire[17:0] T154;
  wire[28:0] T79;
  wire[31:0] T60;
  wire[31:0] T61;
  wire[31:0] T62;
  wire[31:0] T63;
  wire[15:0] T64;
  wire T65;
  wire T66;
  wire T67;
  wire[31:0] T68;
  wire[15:0] T69;
  wire[7:0] T70;
  wire T71;
  wire T72;
  wire T73;
  wire T74;
  wire T75;
  wire T76;
  wire T77;
  wire T78;
  wire[17:0] T155;
  wire[17:0] T156;
  wire[31:0] T81;
  reg [31:0] data_bank1 [262143:0];
  wire[31:0] T82;
  wire[31:0] T83;
  wire[17:0] T157;
  wire[31:0] T84;
  wire[31:0] T85;
  wire[31:0] T86;
  wire[31:0] T87;
  wire[31:0] T88;
  wire[17:0] T158;
  wire[31:0] T89;
  wire T90;
  wire[17:0] T159;
  wire[31:0] T91;
  wire[31:0] T92;
  wire[31:0] T93;
  wire[31:0] T94;
  wire[31:0] T95;
  wire[17:0] T160;
  wire[31:0] T96;
  wire T97;
  wire[17:0] T161;
  wire[17:0] T162;
  reg  R98;
  wire T99;
  wire T100;
  wire[31:0] T101;
  wire[31:0] T102;
  wire[31:0] T103;
  wire[31:0] T104;
  wire[31:0] T105;
  wire[31:0] T106;
  wire[31:0] T107;
  wire[31:0] T108;
  wire[31:0] T109;
  wire[31:0] T110;
  wire[7:0] T111;
  wire T112;
  wire[31:0] T113;
  wire[7:0] T114;
  wire[23:0] T115;
  wire[23:0] T163;
  wire T116;
  wire T117;
  wire[31:0] T118;
  wire[15:0] T119;
  wire T120;
  wire[31:0] T121;
  wire[15:0] T122;
  wire[15:0] T123;
  wire[15:0] T164;
  wire T124;
  wire T125;
  wire[31:0] T126;
  wire[31:0] T127;
  wire[31:0] T128;
  wire[31:0] T129;
  wire[31:0] T130;
  wire[31:0] T131;
  wire[31:0] T132;
  wire[31:0] T133;
  wire[31:0] T134;
  wire[31:0] T135;
  wire[7:0] T136;
  wire T137;
  wire[31:0] T138;
  wire[7:0] T139;
  wire[23:0] T140;
  wire[23:0] T165;
  wire T141;
  wire T142;
  wire[31:0] T143;
  wire[15:0] T144;
  wire T145;
  wire[31:0] T146;
  wire[15:0] T147;
  wire[15:0] T148;
  wire[15:0] T166;
  wire T149;
  wire T150;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    // #0.002;
    for (initvar = 0; initvar < 262144; initvar = initvar+1)
      data_bank0[initvar] = {1{$random}};
    htif_idx = {1{$random}};
    for (initvar = 0; initvar < 262144; initvar = initvar+1)
      data_bank1[initvar] = {1{$random}};
    R98 = {1{$random}};
    
    #(ClockCycle * 10);
    // TODO(kartiknayak): Eventually this should go off
     $readmemh(`CODE_PATH_TEMP_0, data_bank0, 32'h200);
     $readmemh(`CODE_PATH_TEMP_1, data_bank1, 32'h200);
     // $readmemh("/home/kartik/code/obfus/code3/all_riscv/add/opcode_add_0.out", data_bank0, 32'h200);
     // $readmemh("/home/kartik/code/obfus/code3/all_riscv/add/opcode_add_1.out", data_bank1, 32'h200);
     // $readmemh("/home/kartik/code/obfus/code3/all_riscv/bzip_riscv/opcode_micro_bunzip_0.out", data_bank0, 32'h200);
     // $readmemh("/home/kartik/code/obfus/code3/all_riscv/bzip_riscv/opcode_micro_bunzip_1.out", data_bank1, 32'h200);
//      $readmemh("/home/kartik/code/obfus/code3/all_riscv/simpler/opcode_simpler_0.out", data_bank0, 32'h200);
//      $readmemh("/home/kartik/code/obfus/code3/all_riscv/simpler/opcode_simpler_1.out", data_bank1, 32'h200);
//    $readmemh("/home/kartik/code/obfus/code3/all_riscv/selection_sort/opcode0_sort.out.copy", data_bank0, 32'h201);
//    $readmemh("/home/kartik/code/obfus/code3/all_riscv/selection_sort/opcode1_sort.out.copy", data_bank1, 32'h201);
//    $readmemh("/home/kartik/code/obfus/code3/obfuscation/oram/opcode0_sort.out.copy", data_bank0, 32'h201);
//    $readmemh("/home/kartik/code/obfus/code3/obfuscation/oram/opcode1_sort.out.copy", data_bank1, 32'h201);
//    $readmemh("/home/kartik/code/obfus/code3/obfuscation/oram/opcode0_delll.out", data_bank0, 32'h2000);
//    $readmemh("/home/kartik/code/obfus/code3/obfuscation/oram/opcode1_delll.out", data_bank1, 32'h2000);
//    $readmemh("/home/kartik/code/obfus/code3/obfuscation/oram/opcode0.out.small", data_bank0, 32'h201);
//    $readmemh("/home/kartik/code/obfus/code3/obfuscation/oram/opcode1.out.small", data_bank1, 32'h201);
    //data_bank1[18'h2154] = 32'hcccc0000;
  end
// synthesis translate_on
`endif

  assign io_htif_port_resp_bits_data = T0;
  assign T0 = {T81, T1};
  assign T1 = data_bank0[T156];
  assign T3 = io_htif_port_req_bits_data[5'h1f:1'h0];
  assign T4 = io_htif_port_req_valid & T5;
  assign T5 = io_htif_port_req_bits_fcn == 1'h1;
  assign T151 = htif_idx[5'h11:1'h0];
  assign T80 = io_htif_port_req_bits_addr >> 2'h3;
  assign T7 = T23 | T8;
  assign T8 = T22 & T9;
  assign T9 = ~ T10;
  assign T10 = T11[5'h1f:1'h0];
  assign T11 = T14 << T12;
  assign T12 = {T13, 3'h0};
  assign T13 = io_core_ports_1_req_bits_addr[1'h1:1'h0];
  assign T14 = T19 ? 32'hffff : T15;
  assign T15 = T16 ? 32'hff : 32'hffffffff;
  assign T16 = T18 | T17;
  assign T17 = io_core_ports_1_req_bits_typ == 3'h5;
  assign T18 = io_core_ports_1_req_bits_typ == 3'h1;
  assign T19 = T21 | T20;
  assign T20 = io_core_ports_1_req_bits_typ == 3'h6;
  assign T21 = io_core_ports_1_req_bits_typ == 3'h2;
  assign T22 = data_bank0[T152];
  assign T152 = T42[5'h11:1'h0];
  assign T42 = io_core_ports_1_req_bits_addr >> 2'h3;
  assign T23 = T24 & T10;
  assign T24 = T34 ? T31 : T25;
  assign T25 = T28 ? T26 : io_core_ports_1_req_bits_data;
  assign T26 = {T27, T27};
  assign T27 = io_core_ports_1_req_bits_data[4'hf:1'h0];
  assign T28 = T30 | T29;
  assign T29 = io_core_ports_1_req_bits_typ == 3'h6;
  assign T30 = io_core_ports_1_req_bits_typ == 3'h2;
  assign T31 = {T32, T32};
  assign T32 = {T33, T33};
  assign T33 = io_core_ports_1_req_bits_data[3'h7:1'h0];
  assign T34 = T36 | T35;
  assign T35 = io_core_ports_1_req_bits_typ == 3'h5;
  assign T36 = io_core_ports_1_req_bits_typ == 3'h1;
  assign T37 = T40 & T38;
  assign T38 = T39 ^ 1'h1;
  assign T39 = io_core_ports_1_req_bits_addr[2'h2:2'h2];
  assign T40 = io_core_ports_1_req_valid & T41;
  assign T41 = io_core_ports_1_req_bits_fcn == 1'h1;
  assign T153 = T42[5'h11:1'h0];
  assign T44 = T60 | T45;
  assign T45 = T59 & T46;
  assign T46 = ~ T47;
  assign T47 = T48[5'h1f:1'h0];
  assign T48 = T51 << T49;
  assign T49 = {T50, 3'h0};
  assign T50 = io_core_ports_0_req_bits_addr[1'h1:1'h0];
  assign T51 = T56 ? 32'hffff : T52;
  assign T52 = T53 ? 32'hff : 32'hffffffff;
  assign T53 = T55 | T54;
  assign T54 = io_core_ports_0_req_bits_typ == 3'h5;
  assign T55 = io_core_ports_0_req_bits_typ == 3'h1;
  assign T56 = T58 | T57;
  assign T57 = io_core_ports_0_req_bits_typ == 3'h6;
  assign T58 = io_core_ports_0_req_bits_typ == 3'h2;
  assign T59 = data_bank0[T154];
  assign T154 = T79[5'h11:1'h0];
  assign T79 = io_core_ports_0_req_bits_addr >> 2'h3;
  assign T60 = T61 & T47;
  assign T61 = T71 ? T68 : T62;
  assign T62 = T65 ? T63 : io_core_ports_0_req_bits_data;
  assign T63 = {T64, T64};
  assign T64 = io_core_ports_0_req_bits_data[4'hf:1'h0];
  assign T65 = T67 | T66;
  assign T66 = io_core_ports_0_req_bits_typ == 3'h6;
  assign T67 = io_core_ports_0_req_bits_typ == 3'h2;
  assign T68 = {T69, T69};
  assign T69 = {T70, T70};
  assign T70 = io_core_ports_0_req_bits_data[3'h7:1'h0];
  assign T71 = T73 | T72;
  assign T72 = io_core_ports_0_req_bits_typ == 3'h5;
  assign T73 = io_core_ports_0_req_bits_typ == 3'h1;
  assign T74 = T77 & T75;
  assign T75 = T76 ^ 1'h1;
  assign T76 = io_core_ports_0_req_bits_addr[2'h2:2'h2];
  assign T77 = io_core_ports_0_req_valid & T78;
  assign T78 = io_core_ports_0_req_bits_fcn == 1'h1;
  assign T155 = T79[5'h11:1'h0];
  assign T156 = htif_idx[5'h11:1'h0];
  assign T81 = data_bank1[T162];
  assign T83 = io_htif_port_req_bits_data[6'h3f:6'h20];
  assign T157 = htif_idx[5'h11:1'h0];
  assign T85 = T89 | T86;
  assign T86 = T88 & T87;
  assign T87 = ~ T10;
  assign T88 = data_bank1[T158];
  assign T158 = T42[5'h11:1'h0];
  assign T89 = T24 & T10;
  assign T90 = T40 & T39;
  assign T159 = T42[5'h11:1'h0];
  assign T92 = T96 | T93;
  assign T93 = T95 & T94;
  assign T94 = ~ T47;
  assign T95 = data_bank1[T160];
  assign T160 = T79[5'h11:1'h0];
  assign T96 = T61 & T47;
  assign T97 = T77 & T76;
  assign T161 = T79[5'h11:1'h0];
  assign T162 = htif_idx[5'h11:1'h0];
  assign io_htif_port_resp_valid = R98;
  assign T99 = io_htif_port_req_valid & T100;
  assign T100 = io_htif_port_req_bits_fcn == 1'h0;
  assign io_htif_port_req_ready = 1'h1;
  assign io_core_ports_0_resp_bits_data = T101;
  assign T101 = T102;
  assign T102 = T125 ? T121 : T103;
  assign T103 = T120 ? T118 : T104;
  assign T104 = T117 ? T113 : T105;
  assign T105 = T112 ? T110 : T106;
  assign T106 = T107[5'h1f:1'h0];
  assign T107 = T108 >> T49;
  assign T108 = T109;
  assign T109 = T76 ? T95 : T59;
  assign T110 = {24'h0, T111};
  assign T111 = T107[3'h7:1'h0];
  assign T112 = io_core_ports_0_req_bits_typ == 3'h5;
  assign T113 = {T115, T114};
  assign T114 = T107[3'h7:1'h0];
  assign T115 = 24'h0 - T163;
  assign T163 = {23'h0, T116};
  assign T116 = T107[3'h7:3'h7];
  assign T117 = io_core_ports_0_req_bits_typ == 3'h1;
  assign T118 = {16'h0, T119};
  assign T119 = T107[4'hf:1'h0];
  assign T120 = io_core_ports_0_req_bits_typ == 3'h6;
  assign T121 = {T123, T122};
  assign T122 = T107[4'hf:1'h0];
  assign T123 = 16'h0 - T164;
  assign T164 = {15'h0, T124};
  assign T124 = T107[4'hf:4'hf];
  assign T125 = io_core_ports_0_req_bits_typ == 3'h2;
  assign io_core_ports_0_resp_valid = io_core_ports_0_req_valid;
  assign io_core_ports_0_req_ready = 1'h1;
  assign io_core_ports_1_resp_bits_data = T126;
  assign T126 = T127;
  assign T127 = T150 ? T146 : T128;
  assign T128 = T145 ? T143 : T129;
  assign T129 = T142 ? T138 : T130;
  assign T130 = T137 ? T135 : T131;
  assign T131 = T132[5'h1f:1'h0];
  assign T132 = T133 >> T12;
  assign T133 = T134;
  assign T134 = T39 ? T88 : T22;
  assign T135 = {24'h0, T136};
  assign T136 = T132[3'h7:1'h0];
  assign T137 = io_core_ports_1_req_bits_typ == 3'h5;
  assign T138 = {T140, T139};
  assign T139 = T132[3'h7:1'h0];
  assign T140 = 24'h0 - T165;
  assign T165 = {23'h0, T141};
  assign T141 = T132[3'h7:3'h7];
  assign T142 = io_core_ports_1_req_bits_typ == 3'h1;
  assign T143 = {16'h0, T144};
  assign T144 = T132[4'hf:1'h0];
  assign T145 = io_core_ports_1_req_bits_typ == 3'h6;
  assign T146 = {T148, T147};
  assign T147 = T132[4'hf:1'h0];
  assign T148 = 16'h0 - T166;
  assign T166 = {15'h0, T149};
  assign T149 = T132[4'hf:4'hf];
  assign T150 = io_core_ports_1_req_bits_typ == 3'h2;
  assign io_core_ports_1_resp_valid = io_core_ports_1_req_valid;
  //assign io_core_ports_1_resp_valid = io_core_ports_1_req_valid & (io_core_ports_1_req_bits_fcn == 1'h0);
  assign io_core_ports_1_req_ready = 1'h1;

  always @(posedge clk) begin
    if (T4)
      data_bank0[T151] <= T3;
    htif_idx <= T80;
    if (T37)
      data_bank0[T153] <= T7;
    if (T74)
      data_bank0[T155] <= T44;
    if (T4)
      data_bank1[T157] <= T83;
    if (T90)
      data_bank1[T159] <= T85;
    if (T97)
      data_bank1[T161] <= T92;
    R98 <= T99;
    // $display("mem[10aa8] = 0x%h or 0x%h 0x%h 0x%h", data_bank0[18'h2155], data_bank1[18'h2155], data_bank0[18'h2154], data_bank1[18'h2154]);
  end
endmodule

module SodorTile(input clk,
    input                     io_host_reset,
    output                    io_host_debug_stats_csr,
    input                     io_host_id,
    output                    io_host_csr_req_ready,
    input                     io_host_csr_req_valid,
    input                     io_host_csr_req_bits_rw,
    input [11:0]              io_host_csr_req_bits_addr,
    input [63:0]              io_host_csr_req_bits_data,
    input                     io_host_csr_rep_ready,
    output                    io_host_csr_rep_valid,
    output [63:0]             io_host_csr_rep_bits,
    input                     io_host_ipi_req_ready,
    output                    io_host_ipi_req_valid,
    output                    io_host_ipi_req_bits,
    output                    io_host_ipi_rep_ready,
    input                     io_host_ipi_rep_valid,
    input                     io_host_ipi_rep_bits,
    output                    io_host_mem_req_ready,
    input                     io_host_mem_req_valid,
    input                     io_host_mem_req_bits_rw,
    input [63:0]              io_host_mem_req_bits_addr,
    input [63:0]              io_host_mem_req_bits_data,
    output                    io_host_mem_rep_valid,
    output [63:0]             io_host_mem_rep_bits,
    output [DDRAWidth-1:0]    DDR3SDRAM_Address,
    output [DDRCWidth-1:0]    DDR3SDRAM_Command,
    output                    DDR3SDRAM_CommandValid,
    input                     DDR3SDRAM_CommandReady,

    input [NetworkWidth-1:0]  DDR3SDRAM_ReadData,
    input                     DDR3SDRAM_ReadValid,

    output [NetworkWidth-1:0] DDR3SDRAM_WriteData,
    output                    DDR3SDRAM_WriteValid,
    input                     DDR3SDRAM_WriteReady,
    output                    initialization_done,
    output [31:0]             datpath_T150
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

    parameter				NetworkWidth =		64;
    parameter				JTPWidth =			8;
  wire[31:0] T1;
  wire[63:0] T0;
  wire memory_io_core_ports_1_req_ready;
  wire memory_io_core_ports_1_resp_valid;
  wire[31:0] memory_io_core_ports_1_resp_bits_data;
  wire memory_io_core_ports_0_req_ready;
  wire memory_io_core_ports_0_resp_valid;
  wire[31:0] memory_io_core_ports_0_resp_bits_data;
  wire memory_io_htif_port_req_ready;
  wire memory_io_htif_port_resp_valid;
  wire[63:0] memory_io_htif_port_resp_bits_data;
  wire core_io_host_debug_stats_csr;
  wire core_io_host_csr_req_ready;
  wire core_io_host_csr_rep_valid;
  wire[63:0] core_io_host_csr_rep_bits;
  wire core_io_host_ipi_req_valid;
  wire core_io_host_ipi_req_bits;
  wire core_io_host_ipi_rep_ready;
  wire core_io_imem_req_valid;
  wire[31:0] core_io_imem_req_bits_addr;
  wire core_io_imem_req_bits_fcn;
  wire[2:0] core_io_imem_req_bits_typ;
  wire core_io_dmem_req_valid;
  wire[31:0] core_io_dmem_req_bits_addr;
  wire[31:0] core_io_dmem_req_bits_data;
  wire core_io_dmem_req_bits_fcn;
  wire[2:0] core_io_dmem_req_bits_typ;
   


//  wire memory_io_core_ports_1_resp_valid_OUT;
//  wire[31:0] memory_io_core_ports_1_resp_bits_data_OUT;
  wire memory_io_core_ports_0_resp_valid_OUT;
  wire[31:0] memory_io_core_ports_0_resp_bits_data_OUT;
  wire 		memory_io_core_ports_0_resp_valid_filtered;
  wire [31:0]         memory_io_core_ports_0_resp_bits_data_filtered;
  // wire	[JTPWidth-1:0]	oram_ctap_res_data;
  
  assign T1 = T0[5'h1f:1'h0];
  assign T0 = io_host_mem_req_bits_addr;
  assign io_host_mem_rep_bits = memory_io_htif_port_resp_bits_data;
  assign io_host_mem_rep_valid = memory_io_htif_port_resp_valid;
  assign io_host_mem_req_ready = memory_io_htif_port_req_ready;
  assign io_host_ipi_rep_ready = core_io_host_ipi_rep_ready;
  assign io_host_ipi_req_bits = core_io_host_ipi_req_bits;
  assign io_host_ipi_req_valid = core_io_host_ipi_req_valid;
  assign io_host_csr_rep_bits = core_io_host_csr_rep_bits;
  assign io_host_csr_rep_valid = core_io_host_csr_rep_valid;
  assign io_host_csr_req_ready = core_io_host_csr_req_ready;
  assign io_host_debug_stats_csr = core_io_host_debug_stats_csr;
  Core core(.clk(clk), .reset(io_host_reset),
       .io_host_reset( io_host_reset ),
       .io_host_debug_stats_csr( core_io_host_debug_stats_csr ),
       .io_host_id( io_host_id ),
       .io_host_csr_req_ready( core_io_host_csr_req_ready ),
       .io_host_csr_req_valid( io_host_csr_req_valid ),
       .io_host_csr_req_bits_rw( io_host_csr_req_bits_rw ),
       .io_host_csr_req_bits_addr( io_host_csr_req_bits_addr ),
       .io_host_csr_req_bits_data( io_host_csr_req_bits_data ),
       .io_host_csr_rep_ready( io_host_csr_rep_ready ),
       .io_host_csr_rep_valid( core_io_host_csr_rep_valid ),
       .io_host_csr_rep_bits( core_io_host_csr_rep_bits ),
       .io_host_ipi_req_ready( io_host_ipi_req_ready ),
       .io_host_ipi_req_valid( core_io_host_ipi_req_valid ),
       .io_host_ipi_req_bits( core_io_host_ipi_req_bits ),
       .io_host_ipi_rep_ready( core_io_host_ipi_rep_ready ),
       .io_host_ipi_rep_valid( io_host_ipi_rep_valid ),
       .io_host_ipi_rep_bits( io_host_ipi_rep_bits ),
       //.io_host_mem_req_ready(  )
       .io_host_mem_req_valid( io_host_mem_req_valid ),
       .io_host_mem_req_bits_rw( io_host_mem_req_bits_rw ),
       .io_host_mem_req_bits_addr( io_host_mem_req_bits_addr ),
       .io_host_mem_req_bits_data( io_host_mem_req_bits_data ),
       //.io_host_mem_rep_valid(  )
       //.io_host_mem_rep_bits(  )
       .io_imem_req_ready( memory_io_core_ports_0_req_ready ),
       .io_imem_req_valid( core_io_imem_req_valid ),
       .io_imem_req_bits_addr( core_io_imem_req_bits_addr ),
       //.io_imem_req_bits_data(  )
       .io_imem_req_bits_fcn( core_io_imem_req_bits_fcn ),
       .io_imem_req_bits_typ( core_io_imem_req_bits_typ ),
//       .io_imem_resp_valid( memory_io_core_ports_0_resp_valid_filtered_OUT ),
//       .io_imem_resp_bits_data( memory_io_core_ports_0_resp_bits_data_filtered_OUT ),
       .io_imem_resp_valid( memory_io_core_ports_0_resp_valid_OUT ),
       .io_imem_resp_bits_data( memory_io_core_ports_0_resp_bits_data_OUT ),
       .io_dmem_req_ready( memory_io_core_ports_1_req_ready ),
       .io_dmem_req_valid( core_io_dmem_req_valid ),
       .io_dmem_req_bits_addr( core_io_dmem_req_bits_addr ),
       .io_dmem_req_bits_data( core_io_dmem_req_bits_data ),
       .io_dmem_req_bits_fcn( core_io_dmem_req_bits_fcn ),
       .io_dmem_req_bits_typ( core_io_dmem_req_bits_typ ),
       .io_dmem_resp_valid( memory_io_core_ports_1_resp_valid ),
       .io_dmem_resp_bits_data( memory_io_core_ports_1_resp_bits_data ),
            .datpath_T150(datpath_T150)
  );
  
  /*counter     ctr_data (.Clock(                           clk),
                  .Reset(                           io_host_reset), // check
                  .InValid(                         memory_io_core_ports_1_resp_valid),
                  .OutValid(                        memory_io_core_ports_1_resp_valid_OUT)
  );*/
  /* // do not need this anymore; shifting of data is done by ORAM
  shifter     shft_data (    .Clock(                    clk),
                                .Reset(                    0), // update
                                .InData(                memory_io_core_ports_1_resp_bits_data),
                                .OutData(                memory_io_core_ports_1_resp_bits_data_OUT),
                                .InValid(               memory_io_core_ports_1_resp_valid),
                                .OutValid(              memory_io_core_ports_1_resp_valid_OUT)
                                );
                                */

  counter     ctr_prog (.Clock(                           clk),
                        .Reset(                           io_host_reset), // TODO(kartiknayak): check
                        .InValid(                         memory_io_core_ports_0_resp_valid_filtered),
                        .InDataMemRespValid(              memory_io_core_ports_1_resp_valid),
                        .InDataMemReqValid(               core_io_dmem_req_valid),
                        .OutValid(                        memory_io_core_ports_0_resp_valid_OUT),
                        .InData(                          memory_io_core_ports_0_resp_bits_data_filtered),
                        .OutData(                         memory_io_core_ports_0_resp_bits_data_OUT)
  );

   /*shifter      //#(.DELAY(            4))
                shft_prog(       
                                .Clock(                    clk),
                                .Reset(                    0), // update TODO(kartiknayak)
                                .InData(                memory_io_core_ports_0_resp_bits_data_filtered),
                                .OutData(                memory_io_core_ports_0_resp_bits_data_OUT)
                                );*/

   reg                prog_started;
   reg [31:0]         lastT150;
   reg                isMem;
   integer            f, f2, f3;
   reg                isSPLD;
   wire               inScratchPad;
   reg                input_insert;
   
   
   
   
   always @(posedge clk) begin
      if ((memory_io_core_ports_0_resp_bits_data_OUT == 32'h00020213) & memory_io_core_ports_0_resp_valid_OUT) begin // mv tp, tp or   mv x4, x4
         if (input_insert) begin
            $display("started twice?");
            $finish;
         end
         input_insert = 1;
      end
      
      if ((memory_io_core_ports_0_resp_bits_data_OUT == 32'h00018193) & memory_io_core_ports_0_resp_valid_OUT) begin // mv	gp,gp      or    mv x3, x3
        if (prog_started) begin
           $display("started twice?");
           $display(f, "%x %x\n", core_io_imem_req_bits_addr, memory_io_core_ports_0_resp_bits_data_OUT);
           $finish;
        end
         
        prog_started = 1;
         $fclose(f2);
         input_insert = 0;
         
      end
      if ((memory_io_core_ports_0_resp_bits_data_OUT == 32'h00010113) & memory_io_core_ports_0_resp_valid_OUT) begin // mv	sp,sp      or    mv x2, x2
         if (!prog_started) begin
            $display("not started?");
            $finish;
         end
         $fclose(f);
         // $fclose(f3);
         
         $display("done printing");
         
         prog_started = 0;
      end
      
      if (prog_started | input_insert) begin
         // whether load/store
         isMem = ((memory_io_core_ports_0_resp_bits_data_OUT[6:0] == 7'h3) | (memory_io_core_ports_0_resp_bits_data_OUT[6:0] == 7'b0100011));
         isSPLD = (memory_io_core_ports_0_resp_bits_data_OUT == 32'h00008093);

         // if in scratch pad and not load word
         if (inScratchPad & (memory_io_core_ports_0_resp_bits_data_OUT[6:0] != 7'h3))
           $fwrite(input_insert ? f2 : f, " S");
         // if arith or (mem and mem responds)
         if ((memory_io_core_ports_0_resp_valid_OUT & !core_io_dmem_req_valid) | (memory_io_core_ports_0_resp_valid_OUT & core_io_dmem_req_valid & memory_io_core_ports_1_resp_valid)) begin
            
            $fwrite(input_insert ? f2 : f, "\n%x %x %d %s %d", core_io_imem_req_bits_addr, memory_io_core_ports_0_resp_bits_data_OUT, datpath_T150 - lastT150, isMem ? (inScratchPad ? "S" : "M") : (isSPLD ? "SPLD" : "A"), MemSize);
            if (!input_insert & isMem) begin
               // $fwrite(f3, "%x %x\n", core_io_imem_req_bits_addr, core_io_dmem_req_bits_addr);
            end
            
            lastT150 = datpath_T150;
         end
      end
      
   end

   wire               isNextReqSpld;
   wire [15:0]        MemSize;
   wire               IFSPCmdValid;
   wire               IFSPCmdReady;
   wire               isReplaceable;
   
   
  InstructionFilter inst_filter (.Clock(clk),
				 .Reset(io_host_reset),
				 .InInstRespValid(memory_io_core_ports_0_resp_valid),
				 .InInstRespData(memory_io_core_ports_0_resp_bits_data),
				 .OutInstRespValid(memory_io_core_ports_0_resp_valid_filtered),
				 .OutInstRespData(memory_io_core_ports_0_resp_bits_data_filtered),
                                 .isNextReqSpld(isNextReqSpld),
                                 .IFSPCmdValid(IFSPCmdValid),
                                 .IFSPCmdReady(IFSPCmdReady),
                                 .MemSize(MemSize),
                                 .isMemReplaceable(isReplaceable)
				 );
   wire 		CmdReady;
  wire 	      funnel_in_ready;
   wire 	     load_funnel_out_valid;

  assign memory_io_core_ports_1_req_ready = core_io_dmem_req_bits_fcn == 1'b1 ? funnel_in_ready & CmdReady : CmdReady;
  assign memory_io_core_ports_1_resp_valid = core_io_dmem_req_bits_fcn == 1'b1 ? 
    (funnel_in_ready & CmdReady & core_io_dmem_req_valid) :
    (load_funnel_out_valid);

   reg 	   initialization_done;
   wire    CmdValid_final;
   reg    CmdValid_initialization;
   wire [ORAMB-1:0] DataStore_final;
   reg [ORAMB-1:0] DataStore_initialization;
   wire 	    DataValid_final;
   reg 		    DataValid_initialization;
   wire [BECMDWidth-1:0] Cmd_final;
   reg [BECMDWidth-1:0]  Cmd_initialization;
   wire [ORAMU-1:0] 	 Addr_final;
   reg [ORAMU-1:0] 	 Addr_initialization;
   wire 		 ClippedCmdValid;
   
   ClipCmdValid clipper(.Clock(               clk),
			.Reset(               io_host_reset),
			.InCmdValid(          core_io_dmem_req_valid),
			.InCmdReady(          CmdReady),
			.InCmd(               Cmd_final),
			.OutCmdValid(         ClippedCmdValid),
			.io_dmem_resp_valid(  load_funnel_out_valid)
			);
   
   
   assign DataValid_final = (initialization_done == 1'b1) ? core_io_dmem_req_valid & CmdReady & (core_io_dmem_req_bits_fcn == 1'b1) : DataValid_initialization;
   
   assign DataStore_final = (initialization_done == 1'b1) ? {{(ORAMB-32){1'b0}}, core_io_dmem_req_bits_data} : {{(ORAMB-32){1'b0}}, DataStore_initialization};
   
   assign CmdValid_final = (initialization_done == 1'b1) ? (core_io_dmem_req_bits_fcn == 1'b1 ? core_io_dmem_req_valid & funnel_in_ready : ClippedCmdValid) : CmdValid_initialization;

      assign Cmd_final = (initialization_done == 1'b1) ? (core_io_dmem_req_bits_fcn == 1'b1 ? BECMD_Update : BECMD_Read) : Cmd_initialization;
   
   assign Addr_final = (initialization_done == 1'b1) ? core_io_dmem_req_bits_addr : Addr_initialization;
   
   wire[ORAMB-1:0] load_data;
   assign memory_io_core_ports_1_resp_bits_data = load_data[31:0];

   wire [2:0]      UnalignedType_final;
   reg [2:0]      UnalignedType_initialization;

   assign UnalignedType_final = (initialization_done == 1'b1) ? core_io_dmem_req_bits_typ : UnalignedType_initialization;

   // going to a smaller address space; TODO(kartiknayak): fix this later
  ScratchPad scratchpad(	.Clock(					clk),
                                .Reset(                 io_host_reset & !initialization_done),
                                
                                // interface with Setup            
                                .InCmd(                   Cmd_final),
                                .InPAddr(                 Addr_final),
                                .InCmdValid(              CmdValid_final),
                                .InCmdReady(              CmdReady),
			        .InDataStoreReady(           funnel_in_ready),
			        .InDataStoreValid(           DataValid_final), 
			        .InDataStore(                DataStore_final),
			        .OutDataLoadReady(          1'b1),
			        .OutDataLoadValid(          load_funnel_out_valid), 
			        .OutDataLoad(               load_data),
                                .UnalignedType(         UnalignedType_final),
                                
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

                                // communication with InstructionFilter
                                .isNextReqSpld(         isNextReqSpld),
                                .memForSpld(            MemSize),
                                .isReplaceable(         isReplaceable),
                                .IFSPCmdValid(          IFSPCmdValid),
                                .IFSPCmdReady(          IFSPCmdReady),
                                .inScratchPad(          inScratchPad)
);

  wire memory_io_core_ports_1_resp_valid_UNUSED;
  wire memory_io_core_ports_1_req_ready_UNUSED;
   wire[31:0] memory_io_core_ports_1_resp_bits_data_UNUSED;
   

  ScratchPadMemory memory(.clk(clk),
       .io_core_ports_1_req_ready( memory_io_core_ports_1_req_ready_UNUSED ),
//       .io_core_ports_1_req_valid( core_io_dmem_req_valid ),
       .io_core_ports_1_req_valid( 1'b0 ), // setting this bit to 0 as data requests would be answered by ORAM
       .io_core_ports_1_req_bits_addr( core_io_dmem_req_bits_addr ),
       .io_core_ports_1_req_bits_data( core_io_dmem_req_bits_data ),
       .io_core_ports_1_req_bits_fcn( core_io_dmem_req_bits_fcn ),
       .io_core_ports_1_req_bits_typ( core_io_dmem_req_bits_typ ),
       .io_core_ports_1_resp_valid( memory_io_core_ports_1_resp_valid_UNUSED ), // just connection to a wire that is not used anywhere
       .io_core_ports_1_resp_bits_data( memory_io_core_ports_1_resp_bits_data_UNUSED ),
       .io_core_ports_0_req_ready( memory_io_core_ports_0_req_ready ),
       .io_core_ports_0_req_valid( core_io_imem_req_valid ),
       .io_core_ports_0_req_bits_addr( core_io_imem_req_bits_addr ),
       //.io_core_ports_0_req_bits_data(  )
       .io_core_ports_0_req_bits_fcn( core_io_imem_req_bits_fcn ),
       .io_core_ports_0_req_bits_typ( core_io_imem_req_bits_typ ),
       .io_core_ports_0_resp_valid( memory_io_core_ports_0_resp_valid ),
       .io_core_ports_0_resp_bits_data( memory_io_core_ports_0_resp_bits_data ),
       .io_htif_port_req_ready( memory_io_htif_port_req_ready ),
       .io_htif_port_req_valid( io_host_mem_req_valid ),
       .io_htif_port_req_bits_addr( T1 ),
       .io_htif_port_req_bits_data( io_host_mem_req_bits_data ),
       .io_htif_port_req_bits_fcn( io_host_mem_req_bits_rw ),
       //.io_htif_port_req_bits_typ(  )
       .io_htif_port_resp_valid( memory_io_htif_port_resp_valid ),
       .io_htif_port_resp_bits_data( memory_io_htif_port_resp_bits_data )
  );
`ifndef SYNTHESIS   
// synthesis translate_off
    assign memory.io_core_ports_0_req_bits_data = {1{$random}};
// synthesis translate_on
`endif

   reg [31:0] temp_data_bank0 [262143:0];
   reg [31:0] temp_data_bank1 [262143:0];
   integer    j;
   reg [31:0] lines [1:0];
   
   
   initial begin // TODO(kartiknayak): should be a more flexible logic to invoke this
      $readmemh(`CODE_PATH_LINES, lines, 0);
      for (j = 0; j < lines[0] + 8; j = j + 1) begin
         temp_data_bank0[32'h200 + j] = 0;
         temp_data_bank1[32'h200 + j] = 0;
      end
      
      $readmemh(`CODE_PATH_TEMP_0, temp_data_bank0, 32'h200);
      $readmemh(`CODE_PATH_TEMP_1, temp_data_bank1, 32'h200);
      f = $fopen(`CODE_OUTPUT, "w");
      f2 = $fopen(`CODE_INPUT, "w");
      // f3 = $fopen(`BUNZIP_EXTRA, "w");
      
      // $fopen(`CODE_PATH_LINES, "r");
      // $fscanf("%d", lines);
        // $readmemh("/home/kartik/code/obfus/code3/all_riscv/add/opcode_add_0.out", temp_data_bank0, 32'h200);
        // $readmemh("/home/kartik/code/obfus/code3/all_riscv/add/opcode_add_1.out", temp_data_bank1, 32'h200);
      // $readmemh("/home/kartik/code/obfus/code3/all_riscv/bzip_riscv/opcode_micro_bunzip_0.out", temp_data_bank0, 32'h200);
      // $readmemh("/home/kartik/code/obfus/code3/all_riscv/bzip_riscv/opcode_micro_bunzip_1.out", temp_data_bank1, 32'h200);      
//      $readmemh("/home/kartik/code/obfus/code3/all_riscv/simpler/opcode_simpler_0.out", temp_data_bank0, 32'h200);
//      $readmemh("/home/kartik/code/obfus/code3/all_riscv/simpler/opcode_simpler_1.out", temp_data_bank1, 32'h200);
//      $readmemh("/home/kartik/code/obfus/code3/all_riscv/selection_sort/opcode0_sort.out.copy", temp_data_bank0, 32'h201);
//      $readmemh("/home/kartik/code/obfus/code3/all_riscv/selection_sort/opcode1_sort.out.copy", temp_data_bank1, 32'h201);
//      $readmemh("/home/kartik/code/obfus/code3/oram/opcode0_sort.out.copy", temp_data_bank0, 32'h201);
//      $readmemh("/home/kartik/code/obfus/code3/obfuscation/oram/opcode1_sort.out.copy", temp_data_bank1, 32'h201);
      initialization_done = 1'b0;
      CmdValid_initialization = 0;
      DataValid_initialization = 0;
      UnalignedType_initialization = 3'h0; // 3 is for sw/lw
      prog_started = 0;
      input_insert = 0;
      
      lastT150 = 0;
      
      #(3 * ClockCycle);
      
     for (j = 0; j < lines[0]; j = j + 8) begin // TODO(kartiknayak): this hardcoding should be fixed (old value 710); one line at a time?
	    Task_StartORAMAccess(32'h200 * 8 + j * 8, {temp_data_bank1[32'h200 + j + 7],
                                                       temp_data_bank0[32'h200 + j + 7],
                                                       temp_data_bank1[32'h200 + j + 6],
                                                       temp_data_bank0[32'h200 + j + 6],
                                                       temp_data_bank1[32'h200 + j + 5],
                                                       temp_data_bank0[32'h200 + j + 5],
                                                       temp_data_bank1[32'h200 + j + 4],
                                                       temp_data_bank0[32'h200 + j + 4],
                                                       temp_data_bank1[32'h200 + j + 3],
                                                       temp_data_bank0[32'h200 + j + 3],
                                                       temp_data_bank1[32'h200 + j + 2],
                                                       temp_data_bank0[32'h200 + j + 2],
                                                       temp_data_bank1[32'h200 + j + 1],
                                                       temp_data_bank0[32'h200 + j + 1],
                                                       temp_data_bank1[32'h200 + j],
                                                       temp_data_bank0[32'h200 + j]});
        // #(ClockCycle);
	    // Task_StartORAMAccess(32'h200 * 8 + j * 8 + 4, {{ORAMB-32{1'b0}}, temp_data_bank1[32'h200 + j]});
        #(ClockCycle);
     end
      #(ClockCycle);
      initialization_done = 1'b1;			    
   end

   // Should be used only during initialization
   task Task_StartORAMAccess;
        input [ORAMU-1:0] addr;
        input [ORAMB-1:0] data;
        
	begin
	    while(!funnel_in_ready | !CmdReady ) #(ClockCycle);
            Cmd_initialization = BECMD_Update;
            Addr_initialization = addr;
    	    DataStore_initialization = data;
	    CmdValid_initialization = 1;
            DataValid_initialization = 1;
            #(ClockCycle);
            CmdValid_initialization = 0;
            DataValid_initialization = 0;           
	end
    endtask
endmodule

module Queue_0(input clk, input reset,
    output io_enq_ready,
    input  io_enq_valid,
    input  io_enq_bits_rw,
    input [11:0] io_enq_bits_addr,
    input [63:0] io_enq_bits_data,
    input  io_deq_ready,
    output io_deq_valid,
    output io_deq_bits_rw,
    output[11:0] io_deq_bits_addr,
    output[63:0] io_deq_bits_data,
    output[1:0] io_count
);

  wire[1:0] T0;
  wire ptr_diff;
  reg  R1;
  wire T21;
  wire T2;
  wire T3;
  wire do_deq;
  reg  R4;
  wire T22;
  wire T5;
  wire T6;
  wire do_enq;
  wire T7;
  wire ptr_match;
  reg  maybe_full;
  wire T23;
  wire T8;
  wire T9;
  wire[63:0] T10;
  wire[76:0] T11;
  reg [76:0] ram [1:0];
  wire[76:0] T12;
  wire[76:0] T13;
  wire[76:0] T14;
  wire[75:0] T15;
  wire[11:0] T16;
  wire T17;
  wire T18;
  wire empty;
  wire T19;
  wire T20;
  wire full;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    // #0.002;
    R1 = {1{$random}};
    R4 = {1{$random}};
    maybe_full = {1{$random}};
    for (initvar = 0; initvar < 2; initvar = initvar+1)
      ram[initvar] = {3{$random}};
  end
// synthesis translate_on
`endif

  assign io_count = T0;
  assign T0 = {T7, ptr_diff};
  assign ptr_diff = R4 - R1;
  assign T21 = reset ? 1'h0 : T2;
  assign T2 = do_deq ? T3 : R1;
  assign T3 = R1 + 1'h1;
  assign do_deq = io_deq_ready & io_deq_valid;
  assign T22 = reset ? 1'h0 : T5;
  assign T5 = do_enq ? T6 : R4;
  assign T6 = R4 + 1'h1;
  assign do_enq = io_enq_ready & io_enq_valid;
  assign T7 = maybe_full & ptr_match;
  assign ptr_match = R4 == R1;
  assign T23 = reset ? 1'h0 : T8;
  assign T8 = T9 ? do_enq : maybe_full;
  assign T9 = do_enq != do_deq;
  assign io_deq_bits_data = T10;
  assign T10 = T11[6'h3f:1'h0];
  assign T11 = ram[R1];
  assign T13 = T14;
  assign T14 = {io_enq_bits_rw, T15};
  assign T15 = {io_enq_bits_addr, io_enq_bits_data};
  assign io_deq_bits_addr = T16;
  assign T16 = T11[7'h4b:7'h40];
  assign io_deq_bits_rw = T17;
  assign T17 = T11[7'h4c:7'h4c];
  assign io_deq_valid = T18;
  assign T18 = empty ^ 1'h1;
  assign empty = ptr_match & T19;
  assign T19 = maybe_full ^ 1'h1;
  assign io_enq_ready = T20;
  assign T20 = full ^ 1'h1;
  assign full = ptr_match & maybe_full;

  always @(posedge clk) begin
    if(reset) begin
      R1 <= 1'h0;
    end else if(do_deq) begin
      R1 <= T3;
    end
    if(reset) begin
      R4 <= 1'h0;
    end else if(do_enq) begin
      R4 <= T6;
    end
    if(reset) begin
      maybe_full <= 1'h0;
    end else if(T9) begin
      maybe_full <= do_enq;
    end
    if (do_enq)
      ram[R4] <= T13;
  end
endmodule

module Queue_1(input clk, input reset,
    output io_enq_ready,
    input  io_enq_valid,
    input [63:0] io_enq_bits,
    input  io_deq_ready,
    output io_deq_valid,
    output[63:0] io_deq_bits,
    output[1:0] io_count
);

  wire[1:0] T0;
  wire ptr_diff;
  reg  R1;
  wire T15;
  wire T2;
  wire T3;
  wire do_deq;
  reg  R4;
  wire T16;
  wire T5;
  wire T6;
  wire do_enq;
  wire T7;
  wire ptr_match;
  reg  maybe_full;
  wire T17;
  wire T8;
  wire T9;
  wire[63:0] T10;
  reg [63:0] ram [1:0];
  wire[63:0] T11;
  wire T12;
  wire empty;
  wire T13;
  wire T14;
  wire full;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    // #0.002;
    R1 = {1{$random}};
    R4 = {1{$random}};
    maybe_full = {1{$random}};
    for (initvar = 0; initvar < 2; initvar = initvar+1)
      ram[initvar] = {2{$random}};
  end
// synthesis translate_on
`endif

  assign io_count = T0;
  assign T0 = {T7, ptr_diff};
  assign ptr_diff = R4 - R1;
  assign T15 = reset ? 1'h0 : T2;
  assign T2 = do_deq ? T3 : R1;
  assign T3 = R1 + 1'h1;
  assign do_deq = io_deq_ready & io_deq_valid;
  assign T16 = reset ? 1'h0 : T5;
  assign T5 = do_enq ? T6 : R4;
  assign T6 = R4 + 1'h1;
  assign do_enq = io_enq_ready & io_enq_valid;
  assign T7 = maybe_full & ptr_match;
  assign ptr_match = R4 == R1;
  assign T17 = reset ? 1'h0 : T8;
  assign T8 = T9 ? do_enq : maybe_full;
  assign T9 = do_enq != do_deq;
  assign io_deq_bits = T10;
  assign T10 = ram[R1];
  assign io_deq_valid = T12;
  assign T12 = empty ^ 1'h1;
  assign empty = ptr_match & T13;
  assign T13 = maybe_full ^ 1'h1;
  assign io_enq_ready = T14;
  assign T14 = full ^ 1'h1;
  assign full = ptr_match & maybe_full;

  always @(posedge clk) begin
    if(reset) begin
      R1 <= 1'h0;
    end else if(do_deq) begin
      R1 <= T3;
    end
    if(reset) begin
      R4 <= 1'h0;
    end else if(do_enq) begin
      R4 <= T6;
    end
    if(reset) begin
      maybe_full <= 1'h0;
    end else if(T9) begin
      maybe_full <= do_enq;
    end
    if (do_enq)
      ram[R4] <= io_enq_bits;
  end
endmodule

module Queue_2(input clk, input reset,
    output io_enq_ready,
    input  io_enq_valid,
    input  io_enq_bits,
    input  io_deq_ready,
    output io_deq_valid,
    output io_deq_bits,
    output[1:0] io_count
);

  wire[1:0] T0;
  wire ptr_diff;
  reg  R1;
  wire T15;
  wire T2;
  wire T3;
  wire do_deq;
  reg  R4;
  wire T16;
  wire T5;
  wire T6;
  wire do_enq;
  wire T7;
  wire ptr_match;
  reg  maybe_full;
  wire T17;
  wire T8;
  wire T9;
  wire T10;
  reg [0:0] ram [1:0];
  wire T11;
  wire T12;
  wire empty;
  wire T13;
  wire T14;
  wire full;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    // #0.002;
    R1 = {1{$random}};
    R4 = {1{$random}};
    maybe_full = {1{$random}};
    for (initvar = 0; initvar < 2; initvar = initvar+1)
      ram[initvar] = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_count = T0;
  assign T0 = {T7, ptr_diff};
  assign ptr_diff = R4 - R1;
  assign T15 = reset ? 1'h0 : T2;
  assign T2 = do_deq ? T3 : R1;
  assign T3 = R1 + 1'h1;
  assign do_deq = io_deq_ready & io_deq_valid;
  assign T16 = reset ? 1'h0 : T5;
  assign T5 = do_enq ? T6 : R4;
  assign T6 = R4 + 1'h1;
  assign do_enq = io_enq_ready & io_enq_valid;
  assign T7 = maybe_full & ptr_match;
  assign ptr_match = R4 == R1;
  assign T17 = reset ? 1'h0 : T8;
  assign T8 = T9 ? do_enq : maybe_full;
  assign T9 = do_enq != do_deq;
  assign io_deq_bits = T10;
  assign T10 = ram[R1];
  assign io_deq_valid = T12;
  assign T12 = empty ^ 1'h1;
  assign empty = ptr_match & T13;
  assign T13 = maybe_full ^ 1'h1;
  assign io_enq_ready = T14;
  assign T14 = full ^ 1'h1;
  assign full = ptr_match & maybe_full;

  always @(posedge clk) begin
    if(reset) begin
      R1 <= 1'h0;
    end else if(do_deq) begin
      R1 <= T3;
    end
    if(reset) begin
      R4 <= 1'h0;
    end else if(do_enq) begin
      R4 <= T6;
    end
    if(reset) begin
      maybe_full <= 1'h0;
    end else if(T9) begin
      maybe_full <= do_enq;
    end
    if (do_enq)
      ram[R4] <= io_enq_bits;
  end
endmodule

module Queue_3(input clk, input reset,
    output io_enq_ready,
    input  io_enq_valid,
    input  io_enq_bits_rw,
    input [63:0] io_enq_bits_addr,
    input [63:0] io_enq_bits_data,
    input  io_deq_ready,
    output io_deq_valid,
    output io_deq_bits_rw,
    output[63:0] io_deq_bits_addr,
    output[63:0] io_deq_bits_data,
    output[1:0] io_count
);

  wire[1:0] T0;
  wire ptr_diff;
  reg  R1;
  wire T21;
  wire T2;
  wire T3;
  wire do_deq;
  reg  R4;
  wire T22;
  wire T5;
  wire T6;
  wire do_enq;
  wire T7;
  wire ptr_match;
  reg  maybe_full;
  wire T23;
  wire T8;
  wire T9;
  wire[63:0] T10;
  wire[128:0] T11;
  reg [128:0] ram [1:0];
  wire[128:0] T12;
  wire[128:0] T13;
  wire[128:0] T14;
  wire[127:0] T15;
  wire[63:0] T16;
  wire T17;
  wire T18;
  wire empty;
  wire T19;
  wire T20;
  wire full;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    // #0.002;
    R1 = {1{$random}};
    R4 = {1{$random}};
    maybe_full = {1{$random}};
    for (initvar = 0; initvar < 2; initvar = initvar+1)
      ram[initvar] = {5{$random}};
  end
// synthesis translate_on
`endif

  assign io_count = T0;
  assign T0 = {T7, ptr_diff};
  assign ptr_diff = R4 - R1;
  assign T21 = reset ? 1'h0 : T2;
  assign T2 = do_deq ? T3 : R1;
  assign T3 = R1 + 1'h1;
  assign do_deq = io_deq_ready & io_deq_valid;
  assign T22 = reset ? 1'h0 : T5;
  assign T5 = do_enq ? T6 : R4;
  assign T6 = R4 + 1'h1;
  assign do_enq = io_enq_ready & io_enq_valid;
  assign T7 = maybe_full & ptr_match;
  assign ptr_match = R4 == R1;
  assign T23 = reset ? 1'h0 : T8;
  assign T8 = T9 ? do_enq : maybe_full;
  assign T9 = do_enq != do_deq;
  assign io_deq_bits_data = T10;
  assign T10 = T11[6'h3f:1'h0];
  assign T11 = ram[R1];
  assign T13 = T14;
  assign T14 = {io_enq_bits_rw, T15};
  assign T15 = {io_enq_bits_addr, io_enq_bits_data};
  assign io_deq_bits_addr = T16;
  assign T16 = T11[7'h7f:7'h40];
  assign io_deq_bits_rw = T17;
  assign T17 = T11[8'h80:8'h80];
  assign io_deq_valid = T18;
  assign T18 = empty ^ 1'h1;
  assign empty = ptr_match & T19;
  assign T19 = maybe_full ^ 1'h1;
  assign io_enq_ready = T20;
  assign T20 = full ^ 1'h1;
  assign full = ptr_match & maybe_full;

  always @(posedge clk) begin
    if(reset) begin
      R1 <= 1'h0;
    end else if(do_deq) begin
      R1 <= T3;
    end
    if(reset) begin
      R4 <= 1'h0;
    end else if(do_enq) begin
      R4 <= T6;
    end
    if(reset) begin
      maybe_full <= 1'h0;
    end else if(T9) begin
      maybe_full <= do_enq;
    end
    if (do_enq)
      ram[R4] <= T13;
  end
endmodule

module Top(input clk, input reset,
    output io_debug_stats_csr,
    input  io_htif_reset,
    output io_htif_debug_stats_csr,
    input  io_htif_id,
    output io_htif_csr_req_ready,
    input  io_htif_csr_req_valid,
    input  io_htif_csr_req_bits_rw,
    input [11:0] io_htif_csr_req_bits_addr,
    input [63:0] io_htif_csr_req_bits_data,
    input  io_htif_csr_rep_ready,
    output io_htif_csr_rep_valid,
    output[63:0] io_htif_csr_rep_bits,
    input  io_htif_ipi_req_ready,
    output io_htif_ipi_req_valid,
    output io_htif_ipi_req_bits,
    output io_htif_ipi_rep_ready,
    input  io_htif_ipi_rep_valid,
    input  io_htif_ipi_rep_bits,
    output io_htif_mem_req_ready,
    input  io_htif_mem_req_valid,
    input  io_htif_mem_req_bits_rw,
    input [63:0] io_htif_mem_req_bits_addr,
    input [63:0] io_htif_mem_req_bits_data,
    output io_htif_mem_rep_valid,
    output[63:0] io_htif_mem_rep_bits,
    output    [DDRAWidth-1:0]    DDR3SDRAM_Address,
    output    [DDRCWidth-1:0]    DDR3SDRAM_Command,
    output                    DDR3SDRAM_CommandValid,
    input                    DDR3SDRAM_CommandReady,
    input    [NetworkWidth-1:0] DDR3SDRAM_ReadData,
    input                    DDR3SDRAM_ReadValid,
    output    [NetworkWidth-1:0] DDR3SDRAM_WriteData,
    output                    DDR3SDRAM_WriteValid,
    input                    DDR3SDRAM_WriteReady
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

  
  parameter				NetworkWidth =		64;
  parameter				JTPWidth =			8;
  reg  reset_signal;
  reg  R0;
  reg  R1;
  wire Queue_io_enq_ready;
  wire Queue_io_deq_valid;
  wire Queue_io_deq_bits_rw;
  wire[11:0] Queue_io_deq_bits_addr;
  wire[63:0] Queue_io_deq_bits_data;
  wire Queue_1_io_enq_ready;
  wire Queue_1_io_deq_valid;
  wire[63:0] Queue_1_io_deq_bits;
  wire Queue_2_io_enq_ready;
  wire Queue_2_io_deq_valid;
  wire Queue_2_io_deq_bits;
  wire Queue_3_io_enq_ready;
  wire Queue_3_io_deq_valid;
  wire Queue_3_io_deq_bits;
  wire Queue_4_io_enq_ready;
  wire Queue_4_io_deq_valid;
  wire Queue_4_io_deq_bits_rw;
  wire[63:0] Queue_4_io_deq_bits_addr;
  wire[63:0] Queue_4_io_deq_bits_data;
  wire tile_io_host_debug_stats_csr;
  wire tile_io_host_csr_req_ready;
  wire tile_io_host_csr_rep_valid;
  wire[63:0] tile_io_host_csr_rep_bits;
  wire tile_io_host_ipi_req_valid;
  wire tile_io_host_ipi_req_bits;
  wire tile_io_host_ipi_rep_ready;
  wire tile_io_host_mem_req_ready;
  wire tile_io_host_mem_rep_valid;
  wire[63:0] tile_io_host_mem_rep_bits;
   wire [31:0] datpath_T150;
   

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    // #0.002;
    reset_signal = {1{$random}};
    R0 = {1{$random}};
    R1 = {1{$random}};
  end
// synthesis translate_on
`endif

`ifndef SYNTHESIS
// synthesis translate_off
//  assign io_htif_debug_stats_csr = {1{$random}};
// synthesis translate_on
`endif
  assign io_htif_mem_rep_bits = tile_io_host_mem_rep_bits;
  assign io_htif_mem_rep_valid = tile_io_host_mem_rep_valid;
  assign io_htif_mem_req_ready = Queue_4_io_enq_ready;
  assign io_htif_ipi_rep_ready = Queue_2_io_enq_ready;
  assign io_htif_ipi_req_bits = Queue_3_io_deq_bits;
  assign io_htif_ipi_req_valid = Queue_3_io_deq_valid;
  assign io_htif_csr_rep_bits = Queue_1_io_deq_bits;
  assign io_htif_csr_rep_valid = Queue_1_io_deq_valid;
  assign io_htif_csr_req_ready = Queue_io_enq_ready;
  assign io_debug_stats_csr = R1;
  SodorTile tile(.clk(clk),
       .io_host_reset( reset_signal ),
       .io_host_debug_stats_csr( tile_io_host_debug_stats_csr ),
       .io_host_id( 1'h0 ),
       .io_host_csr_req_ready( tile_io_host_csr_req_ready ),
       .io_host_csr_req_valid( Queue_io_deq_valid ),
       .io_host_csr_req_bits_rw( Queue_io_deq_bits_rw ),
       .io_host_csr_req_bits_addr( Queue_io_deq_bits_addr ),
       .io_host_csr_req_bits_data( Queue_io_deq_bits_data ),
       .io_host_csr_rep_ready( Queue_1_io_enq_ready ),
       .io_host_csr_rep_valid( tile_io_host_csr_rep_valid ),
       .io_host_csr_rep_bits( tile_io_host_csr_rep_bits ),
       .io_host_ipi_req_ready( Queue_3_io_enq_ready ),
       .io_host_ipi_req_valid( tile_io_host_ipi_req_valid ),
       .io_host_ipi_req_bits( tile_io_host_ipi_req_bits ),
       .io_host_ipi_rep_ready( tile_io_host_ipi_rep_ready ),
       .io_host_ipi_rep_valid( Queue_2_io_deq_valid ),
       .io_host_ipi_rep_bits( Queue_2_io_deq_bits ),
       .io_host_mem_req_ready( tile_io_host_mem_req_ready ),
       .io_host_mem_req_valid( Queue_4_io_deq_valid ),
       .io_host_mem_req_bits_rw( Queue_4_io_deq_bits_rw ),
       .io_host_mem_req_bits_addr( Queue_4_io_deq_bits_addr ),
       .io_host_mem_req_bits_data( Queue_4_io_deq_bits_data ),
       .io_host_mem_rep_valid( tile_io_host_mem_rep_valid ),
       .io_host_mem_rep_bits( tile_io_host_mem_rep_bits ),
       .DDR3SDRAM_Address(DDR3SDRAM_Address),
       .DDR3SDRAM_Command(DDR3SDRAM_Command),
       .DDR3SDRAM_CommandValid(DDR3SDRAM_CommandValid),
       .DDR3SDRAM_CommandReady(DDR3SDRAM_CommandReady),
       .DDR3SDRAM_ReadData(DDR3SDRAM_ReadData),
       .DDR3SDRAM_ReadValid(DDR3SDRAM_ReadValid),
       .DDR3SDRAM_WriteData(DDR3SDRAM_WriteData),
       .DDR3SDRAM_WriteValid(DDR3SDRAM_WriteValid),
       .DDR3SDRAM_WriteReady(DDR3SDRAM_WriteReady),
                 .datpath_T150(datpath_T150)
  );
  Queue_0 Queue(.clk(clk), .reset(reset),
       .io_enq_ready( Queue_io_enq_ready ),
       .io_enq_valid( io_htif_csr_req_valid ),
       .io_enq_bits_rw( io_htif_csr_req_bits_rw ),
       .io_enq_bits_addr( io_htif_csr_req_bits_addr ),
       .io_enq_bits_data( io_htif_csr_req_bits_data ),
       .io_deq_ready( tile_io_host_csr_req_ready ),
       .io_deq_valid( Queue_io_deq_valid ),
       .io_deq_bits_rw( Queue_io_deq_bits_rw ),
       .io_deq_bits_addr( Queue_io_deq_bits_addr ),
       .io_deq_bits_data( Queue_io_deq_bits_data )
       //.io_count(  )
  );
  Queue_1 Queue_1(.clk(clk), .reset(reset),
       .io_enq_ready( Queue_1_io_enq_ready ),
       .io_enq_valid( tile_io_host_csr_rep_valid ),
       .io_enq_bits( tile_io_host_csr_rep_bits ),
       .io_deq_ready( io_htif_csr_rep_ready ),
       .io_deq_valid( Queue_1_io_deq_valid ),
       .io_deq_bits( Queue_1_io_deq_bits )
       //.io_count(  )
  );
  Queue_2 Queue_2(.clk(clk), .reset(reset),
       .io_enq_ready( Queue_2_io_enq_ready ),
       .io_enq_valid( io_htif_ipi_rep_valid ),
       .io_enq_bits( io_htif_ipi_rep_bits ),
       .io_deq_ready( tile_io_host_ipi_rep_ready ),
       .io_deq_valid( Queue_2_io_deq_valid ),
       .io_deq_bits( Queue_2_io_deq_bits )
       //.io_count(  )
  );
  Queue_2 Queue_3(.clk(clk), .reset(reset),
       .io_enq_ready( Queue_3_io_enq_ready ),
       .io_enq_valid( tile_io_host_ipi_req_valid ),
       .io_enq_bits( tile_io_host_ipi_req_bits ),
       .io_deq_ready( io_htif_ipi_req_ready ),
       .io_deq_valid( Queue_3_io_deq_valid ),
       .io_deq_bits( Queue_3_io_deq_bits )
       //.io_count(  )
  );
  Queue_3 Queue_4(.clk(clk), .reset(reset),
       .io_enq_ready( Queue_4_io_enq_ready ),
       .io_enq_valid( io_htif_mem_req_valid ),
       .io_enq_bits_rw( io_htif_mem_req_bits_rw ),
       .io_enq_bits_addr( io_htif_mem_req_bits_addr ),
       .io_enq_bits_data( io_htif_mem_req_bits_data ),
       .io_deq_ready( tile_io_host_mem_req_ready ),
       .io_deq_valid( Queue_4_io_deq_valid ),
       .io_deq_bits_rw( Queue_4_io_deq_bits_rw ),
       .io_deq_bits_addr( Queue_4_io_deq_bits_addr ),
       .io_deq_bits_data( Queue_4_io_deq_bits_data )
       //.io_count(  )
  );

  always @(posedge clk) begin
    reset_signal <= R0;
    R0 <= io_htif_reset;
    R1 <= tile_io_host_debug_stats_csr;
  end
  
  reg Reset;
  reg Io_htif_reset;
  reg Io_htif_id;
  reg Io_htif_csr_req_valid;
  reg Io_htif_csr_req_bits_rw;
  reg[11:0] Io_htif_csr_req_bits_addr;
  reg[63:0] Io_htif_csr_req_bits_data;
  reg Io_htif_csr_rep_ready;
  reg Io_htif_ipi_req_ready;
  reg Io_htif_ipi_rep_valid;
  reg Io_htif_ipi_rep_bits;
  reg Io_htif_mem_req_valid;
  reg Io_htif_mem_req_bits_rw;
  reg[63:0] Io_htif_mem_req_bits_addr;
  reg Io_htif_mem_req_bits_data;
  
  ClockSource #(ClockFreq) ClockGen(1'b1, clk);
  
  assign reset = Reset;
  assign io_htif_reset = Io_htif_reset;
  assign io_htif_id = Io_htif_id;
  assign io_htif_csr_req_valid = Io_htif_csr_req_valid;
  assign io_htif_csr_req_bits_rw = Io_htif_csr_req_bits_rw;
  assign io_htif_csr_req_bits_addr = Io_htif_csr_req_bits_addr;
  assign io_htif_csr_req_bits_data = Io_htif_csr_req_bits_data;
  assign io_htif_csr_rep_ready = Io_htif_csr_rep_ready;
  assign io_htif_ipi_req_ready = Io_htif_ipi_req_ready;
  assign io_htif_ipi_rep_valid = Io_htif_ipi_rep_valid;
  assign io_htif_ipi_rep_bits = Io_htif_ipi_rep_bits;
  assign io_htif_mem_req_valid = Io_htif_mem_req_valid;
  assign io_htif_mem_req_bits_rw = Io_htif_mem_req_bits_rw;
  assign io_htif_mem_req_bits_addr = Io_htif_mem_req_bits_addr;
  assign io_htif_mem_req_bits_data = Io_htif_mem_req_bits_data;
  assign io_htif_debug_stats_csr = 1;
  
  initial begin
          Io_htif_reset = 1;
          Io_htif_id = 0;
          Io_htif_csr_req_valid = 0;
          Io_htif_csr_req_bits_rw = 0;
          Io_htif_csr_req_bits_addr = 0;
          Io_htif_csr_req_bits_data = 0;
          Io_htif_csr_rep_ready = 0;
          Io_htif_ipi_req_ready = 0;
          Io_htif_ipi_rep_valid = 0;
          Io_htif_ipi_rep_bits = 0;
          Io_htif_mem_req_valid = 0;
          Io_htif_mem_req_bits_rw = 0;
          Io_htif_mem_req_bits_addr = 0;
          Io_htif_mem_req_bits_data = 0;
          Reset = 1;
          #(ClockCycle * 10);
          Io_htif_reset = 0;
          Reset = 0;
  end
endmodule
