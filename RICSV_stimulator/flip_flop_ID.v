module flip_flop_ID(inst_hat,dataA_hat,dataB_hat,PC_hat,inst,dataA,dataB,PC,PCSel,clk);
parameter	INST_LENGTH = 32;
parameter 	DATA_LENGTH = 32;
parameter	PC_LENGTH = 32;

input	[INST_LENGTH-1:0]	inst_hat;
input 	[DATA_LENGTH-1:0]	dataA_hat,dataB_hat;
input 	[PC_LENGTH-1:0]		PC_hat;
input 	PCSel;
input 	clk;

output reg [INST_LENGTH-1:0] 	inst;
output reg [DATA_LENGTH-1:0]	dataA,dataB;
output reg [PC_LENGTH-1:0]	PC;

always @(posedge clk)
begin
	if(PCSel)
		begin
			inst = 32'h00000033;
			dataA = 32'h00000000;
			dataB = 32'b00000000;
			PC = 32'h00000000;
		end 
	else
		begin
			inst = inst_hat;
			dataA = dataA_hat;
			dataB = dataB_hat;
			PC = PC_hat;
		end
    
end



endmodule  
