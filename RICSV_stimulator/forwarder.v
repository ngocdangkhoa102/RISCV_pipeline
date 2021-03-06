module forwarder(inst1,inst2,inst3,fwd1,fwd2);
parameter INST_LENGTH = 32;
parameter REG_ADDR_LENGTH = 5; 
parameter OPCODE_LENGTH = 7;

input [INST_LENGTH-1:0] inst1,inst2,inst3;
output reg [1:0] fwd1,fwd2;

reg [REG_ADDR_LENGTH-1:0] rd2, rd3, rs11 ,rs21;
reg [OPCODE_LENGTH-1:0] opcode1,opcode2,opcode3; 

always @(inst1 or inst2 or inst3)
begin 
	rd2 = inst2[11:7];
	rd3 = inst3[11:7];
	rs11 = inst1[19:15];
	rs21 = inst1[24:20];

	opcode1 = inst1 [6:0];
	opcode2 = inst2 [6:0];
	opcode3 = inst3 [6:0];

//forwarding cho opA
	if(opcode2 != 7'b1100011 && opcode2 != 7'b0100011)
		begin 
		if(rs11 == rd2 && rd2 != 5'b00000)
			begin 
			if(opcode2 == 7'b0000011)
				fwd1 = 2'b10;
			else 
				fwd1 = 2'b01;
			end
		else if(opcode3 != 7'b1100011 && opcode3 != 7'b0100011)
			begin 
			if(rs11 == rd3 && rd3 != 5'b00000)
				fwd1 = 2'b11;
			else 
				fwd1 = 2'b00;
			end
		else 
			fwd1 = 2'b00;
	
		end
	else if(opcode3 != 7'b1100011 && opcode3 != 7'b0100011)
		begin 
			if(rs11 == rd3 && rd3 != 5'b00000 )
				fwd1 = 2'b11;
			else
				fwd1 = 2'b00;
		end
	else
		fwd1 = 2'b00;
		
//forwarding cho opB
	if(opcode2 != 7'b1100011 && opcode2 != 7'b0100011)
		begin 
		if(rs21 == rd2 && rd2 != 5'b00000)
			begin 
			if(opcode2 == 7'b0000011)
				fwd2 = 2'b10;
			else 
				fwd2 = 2'b01;
			end
		else if(opcode3 != 7'b1100011 && opcode3 != 7'b0100011)
			begin 
			if(rs21 == rd3 && rd3 != 5'b00000)
				fwd2 = 2'b11;
			else 
				fwd2 = 2'b00;
			end
		else 
			fwd2 = 2'b00;
	
		end
	else if(opcode3 != 7'b1100011 && opcode3 != 7'b0100011)
		begin 
			if(rs21 == rd3 && rd3 != 5'b00000)
				fwd2 = 2'b11;
			else
				fwd2 = 2'b00;
		end
	else
		fwd2 = 2'b00;

end

endmodule 