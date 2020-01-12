module flip_flop_EX2(i_inst,i_rd,i_regWEn,o_inst,o_rd,o_regWEn,clk);
parameter	INST_LENGTH = 32;
parameter 	REG_ADDR_LENGTH = 5; 

input [INST_LENGTH-1:0] i_inst;
input [REG_ADDR_LENGTH-1:0] i_rd;
input i_regWEn;
input clk;

output reg [INST_LENGTH-1:0] o_inst;
output reg [REG_ADDR_LENGTH-1:0] o_rd;
output reg o_regWEn;

always @(posedge clk)
begin
	o_inst = i_inst;
	o_rd = i_rd;
	o_regWEn = i_regWEn;
end

endmodule
