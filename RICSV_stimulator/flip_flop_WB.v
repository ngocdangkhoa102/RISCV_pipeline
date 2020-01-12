module flip_flop_WB(i_inst,i_wbout,i_rd,i_regWEn,o_inst,o_wbout,o_rd,o_regWEn,clk);
parameter	INST_LENGTH = 32;
parameter 	DATA_LENGTH = 32;
parameter 	REG_ADDR_LENGTH = 5; 

input [INST_LENGTH-1:0] i_inst;
input [DATA_LENGTH-1:0] i_wbout;
input [REG_ADDR_LENGTH-1:0] i_rd;
input i_regWEn;
input clk;

output reg [INST_LENGTH-1:0] o_inst;
output reg [DATA_LENGTH-1:0] o_wbout;
output reg [REG_ADDR_LENGTH-1:0] o_rd;
output reg o_regWEn;

always @(posedge clk)
begin 
	o_inst = i_inst;
	o_wbout = i_wbout;
	o_rd = i_rd;
	o_regWEn = i_regWEn;
end
endmodule
