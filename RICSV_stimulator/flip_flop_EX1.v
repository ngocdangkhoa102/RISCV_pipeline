module flip_flop_EX1(i_pc,i_aluout,i_rs2_out_fwd,i_memRW,i_wbsel,o_pc,o_aluout,o_rs2_out_fwd,o_memRW,o_wbsel,clk);
parameter	PC_LENGTH = 32;
parameter 	DATA_LENGTH = 32;

input [PC_LENGTH-1:0] 	i_pc;
input [DATA_LENGTH-1:0]	i_rs2_out_fwd,i_aluout;
input [1:0] i_wbsel;
input i_memRW;
input clk; 

output reg [PC_LENGTH-1:0] 	o_pc;
output reg [DATA_LENGTH-1:0]	o_rs2_out_fwd,o_aluout;
output reg [1:0] o_wbsel;
output reg o_memRW;

always @(posedge clk)
begin
	o_pc = i_pc;
	o_rs2_out_fwd = i_rs2_out_fwd;
	o_aluout = i_aluout;
	o_wbsel = i_wbsel;
	o_memRW = i_memRW; 
end 

endmodule
