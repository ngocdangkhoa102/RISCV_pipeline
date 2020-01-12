module main(clk);
parameter	PC_LENGTH = 32;
parameter	INST_LENGTH = 32;
parameter 	DATA_LENGTH = 32;
parameter 	REG_ADDR_LENGTH = 5; 
parameter 	IMMIN_LENGTH = INST_LENGTH - 7;
parameter 	DMEM_ADDR_LENGTH = 32;

input clk;

////
//ngo ra
///
//PC
wire [PC_LENGTH-1:0] pcOut;
//add4
wire [PC_LENGTH-1:0] pc_plus_4;
//IMEM
wire [INST_LENGTH-1:0] inst;
//Control Unit
wire [2:0] ALUSel, immSel;
wire [1:0] WBSel_ex;
wire BrUn,PCSel,ASel,BSel,MemRW_ex,RegWEn_ex;
//Reg
wire [REG_ADDR_LENGTH - 1 : 0] addrA,addrB,addrD;
wire [DATA_LENGTH - 1 : 0] dataA,dataB;
//flipflop ID
wire [DATA_LENGTH - 1:0] rs1_out,rs2_out;
wire [INST_LENGTH - 1:0] inst_ex;
wire [PC_LENGTH - 1:0] pc_ex;
//forwarder
wire [1:0] fwd_A, fwd_B;
//mux fwd A
wire [DATA_LENGTH - 1:0] rs1_out_fwd;
//mux fwd B
wire [DATA_LENGTH - 1:0] rs2_out_fwd_ex;
//BrCompare
wire BrEq,BrLt;
//ImmGen
wire [IMMIN_LENGTH - 1:0] immIn;
wire [DATA_LENGTH - 1:0] immOut;
//muxA
wire [DATA_LENGTH - 1:0] alumux1_out;
//muxB
wire [DATA_LENGTH - 1:0] alumux2_out;
//ALU
wire [DATA_LENGTH - 1:0] aluout_ex;
wire Cout;
//flipflop EX1
wire [PC_LENGTH - 1:0] pc_mem;
wire [DATA_LENGTH - 1:0] aluout_mem;
wire [DATA_LENGTH - 1:0] rs2_out_fwd_mem;
wire [1:0] WBSel_mem;
wire MemRW_mem;
//DMEM
wire [DATA_LENGTH-1:0] dataR;
//add4
wire [PC_LENGTH-1:0] pc_mem_plus_4;
//muxDMEM
wire [DATA_LENGTH - 1 : 0] wbout_mem;
//flipflop EX2
wire [INST_LENGTH - 1:0] inst_mem;
wire [REG_ADDR_LENGTH - 1:0] rd_mem;
wire RegWEn_mem; 
//flipflop WB
wire [INST_LENGTH - 1:0] inst_wb;
wire [DATA_LENGTH - 1:0] wbout_wb;
wire [REG_ADDR_LENGTH - 1:0] rd_wb;
wire RegWEn_wb;
//muxPC
//wire [PC_LENGTH-1:0] pcIn; 


////
//day noi
////
//PC
wire [PC_LENGTH-1:0] pcIn;
//add4

//IMEM

//Control Unit

//Reg
wire [DATA_LENGTH - 1 : 0] dataD;
//BrCompare

//ImmGen

//muxA

//muxB

//ALU
wire M,S0,S1,Cin;
//DMEM

//muxDMEM
wire [DATA_LENGTH-1:0] in3;
//flipflop EX2
//wire [REG_ADDR_LENGTH-1:0] rd_ex;

////
//ghep khoi
////
//PC
PC u1(pcIn,pcOut,clk);
//add4
add4 u2(pcOut,pc_plus_4);
//IMEM
IMEM u3(pcOut,inst);
//Control Unit
Control_Unit u4(inst_ex,BrEq,BrLt,BrUn,PCSel,immSel,ASel,BSel,ALUSel,MemRW_ex,RegWEn_ex,WBSel_ex);
//Reg
assign addrA = inst[19:15];
assign addrB = inst[24:20];
assign addrD = inst_ex[11:7];
assign dataD = wbout_wb;
Reg u5(addrA,addrB,rd_wb,dataD,dataA,dataB,RegWEn_wb,clk);
//fipflop ID
flip_flop_ID u6(inst,dataA,dataB,pcOut,inst_ex,rs1_out,rs2_out,pc_ex,PCSel,clk);
//forwarder
forwarder u7(inst_ex,inst_mem,inst_wb,fwd_A,fwd_B);
//mux fwd A
mux4_1 u8(rs1_out,aluout_mem,dataR,wbout_wb,rs1_out_fwd,fwd_A);
//mux fwd B
mux4_1 u9(rs2_out,aluout_mem,dataR,wbout_wb,rs2_out_fwd_ex,fwd_B);
//BrCompare
BrCompare u10(rs1_out_fwd,rs2_out_fwd_ex,BrUn,BrEq,BrLt);
//ImmGen
assign immIn = inst_ex[31:7];
ImmGen u11(immIn,immOut,immSel);
//muxA
mux2_1 u12(rs1_out_fwd,pc_ex,alumux1_out,ASel);
//muxB
mux2_1 u13(rs2_out_fwd_ex,immOut,alumux2_out,BSel);
//ALU
assign {M,S1,S0} = ALUSel;
assign Cin = 1'b0;
ALU32b u14(M,S1,S0,alumux1_out,alumux2_out,Cin,aluout_ex,Cout);
//flipflop EX1
flip_flop_EX1 u15(pc_ex,aluout_ex,rs2_out_fwd_ex,MemRW_ex,WBSel_ex,pc_mem,aluout_mem,rs2_out_fwd_mem,MemRW_mem,WBSel_mem,clk);
//DMEM
DMEM u16(aluout_mem,rs2_out_fwd_mem,dataR,MemRW_mem,clk);
//add4 
add4 u17(pc_mem,pc_mem_plus_4);
//muxDMEM
assign in3 = 32'hABBA_0102;
mux4_1 u18(aluout_mem,dataR,pc_mem_plus_4,in3,wbout_mem,WBSel_mem);
//flipflop EX2
flip_flop_EX2 u19(inst_ex,addrD,RegWEn_ex,inst_mem,rd_mem,RegWEn_mem,clk);
//flipflop WB
flip_flop_WB u20(inst_mem,wbout_mem,rd_mem,RegWEn_mem,inst_wb,wbout_wb,rd_wb,RegWEn_wb,clk);
//muxPC
mux2_1 u0(pc_plus_4,aluout_ex,pcIn,PCSel);

endmodule 
