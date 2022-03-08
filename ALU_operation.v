//set of 16 calculating blocks

module A_NOP(A, B, Y2, Y1); //no opertaion
	input[31:0] A, B;
	output[31:0] Y2, Y1;
	
	assign Y1 = 32'h0000_0000;
	
	assign Y2 = 32'h0000_0000; //sign extension
endmodule 

module A_NOTA(A, B, Y2, Y1); //NOT A
	input[31:0] A, B;
	output[31:0] Y2;
	output[31:0] Y1;
	
	assign Y1 = ~A;
	
	assign Y2[7:0] = {Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31]};
	assign Y2[15:8] = {Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31]};
	assign Y2[23:16] = {Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31]};
	assign Y2[31:24] = {Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31]}; //sign extension
endmodule 

module A_NOTB(A, B, Y2, Y1); //NOT B
	input[31:0] A, B;
	output[31:0] Y2, Y1;
	
	assign Y1 = ~B;
	
	assign Y2[7:0] = {Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31]};
	assign Y2[15:8] = {Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31]};
	assign Y2[23:16] = {Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31]};
	assign Y2[31:24] = {Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31]}; //sign extension
endmodule 

module A_AND(A, B, Y2, Y1); //AND
	input[31:0] A, B;
	output[31:0] Y2, Y1;
	
	assign Y1 = A & B;
	
	assign Y2[7:0] = {Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31]};
	assign Y2[15:8] = {Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31]};
	assign Y2[23:16] = {Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31]};
	assign Y2[31:24] = {Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31]}; //sign extension
endmodule 

module A_OR(A, B, Y2, Y1); //AND
	input[31:0] A, B;
	output[31:0] Y2, Y1;
	
	assign Y1 = A | B;
	
	assign Y2[7:0] = {Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31]};
	assign Y2[15:8] = {Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31]};
	assign Y2[23:16] = {Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31]};
	assign Y2[31:24] = {Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31]}; //sign extension
endmodule

module A_XOR(A, B, Y2, Y1); //XOR
	input[31:0] A, B;
	output[31:0] Y2, Y1;
	
	assign Y1 = A ^ B;
	
	assign Y2[7:0] = {Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31]};
	assign Y2[15:8] = {Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31]};
	assign Y2[23:16] = {Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31]};
	assign Y2[31:24] = {Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31]}; //sign extension
endmodule 

module A_XNOR(A, B, Y2, Y1); //XNOR
	input[31:0] A, B;
	output[31:0] Y2, Y1;
	
	assign Y1 = ~(A ^ B);
	
	assign Y2[7:0] = {Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31]};
	assign Y2[15:8] = {Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31]};
	assign Y2[23:16] = {Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31]};
	assign Y2[31:24] = {Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31], Y1[31]}; //sign extension
endmodule 

module A_LSLA(A, B, S, Y2, Y1); //LSLA
	input[31:0] A, B;
	input[1:0] S;
	output reg[31:0] Y2, Y1;
 
	always @ (A or B or S)
		begin
			if(S == 2'b00) //no shift
				begin
					Y1 = A;
					
					Y2[0] = Y1[31];
					Y2[1:0] = {Y2[0], Y2[0]};
					Y2[3:0] = {Y2[1:0], Y2[1:0]};
					Y2[7:0] = {Y2[3:0], Y2[3:0]};
					Y2[15:0] = {Y2[7:0], Y2[7:0]};
					Y2[31:0] = {Y2[15:0], Y2[15:0]}; //sign extension			
				end
			else if(S == 2'b01) //shift 1 bit
				begin
					Y1 = A;
				
					//A[31] is meaningless in Y1
					Y1[31:1] = A[30:0];
					Y1[0] = 1'b0;
					
					//A[31] is meaningful in Y2
					Y2[0] = A[31];
					Y2[1:0] = {Y2[0], Y2[0]};
					Y2[3:0] = {Y2[1:0], Y2[1:0]};
					Y2[7:0] = {Y2[3:0], Y2[3:0]};
					Y2[15:0] = {Y2[7:0], Y2[7:0]};
					Y2[31:0] = {Y2[15:0], Y2[15:0]}; //sign extension		
				end
			else if(S == 2'b10) //shift 2 bit
				begin
					Y1 = A;
				
					//A[31:30] is meaningless in Y1
					Y1[31:2] = A[29:0];
					Y1[1:0] = 2'b00;
					
					//A[31:30] is meaningful in Y2
					Y2[1:0] = Y1[31:30];
					Y2[3:2] = {Y2[1], Y2[1]};
					Y2[7:4] = {Y2[1], Y2[1], Y2[1], Y2[1]};
					Y2[15:8] = {Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1]};
					Y2[31:16] = {Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1]};
					//sign extension
				end
			else if(S == 2'b11) //shift 3 bit
				begin
					Y1 = A;
				
					//A[31:29] is meaningless in Y1
					Y1[31:3] = A[28:0];
					Y1[2:0] = 3'b000;
					
					//A[31:29] is meaningful in Y2
					Y2[2:0] = Y1[31:29];
					Y2[3] = {Y2[2]};
					Y2[7:4] = {Y2[2], Y2[2], Y2[2], Y2[2]};
					Y2[15:8] = {Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2]};
					Y2[31:16] = {Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2]};
					//sign extension		
				end
			else //wrong shift
				begin
					Y1 = 32'hxxxx_xxxx;
					
					Y2 = 32'hxxxx_xxxx;
				end
		end
endmodule

module A_LSLB(A, B, S, Y2, Y1); //LSLB
	input[31:0] A, B;
	input[1:0] S;
	output reg[31:0] Y2, Y1;
 
	always @ (A or B or S)
		begin
			if(S == 2'b00) //no shift
				begin
					Y1 = B;
					
					Y2[0] = Y1[31];
					Y2[1:0] = {Y2[0], Y2[0]};
					Y2[3:0] = {Y2[1:0], Y2[1:0]};
					Y2[7:0] = {Y2[3:0], Y2[3:0]};
					Y2[15:0] = {Y2[7:0], Y2[7:0]};
					Y2[31:0] = {Y2[15:0], Y2[15:0]}; //sign extension		
				end
			else if(S == 2'b01) //shift 1 bit
				begin
					Y1 = B;
				
					//B[31] is meaningless in Y1
					Y1[31:1] = B[30:0];
					Y1[0] = 1'b0;
					
					//B[31] is meaningful in Y2
					Y2[0] = B[31];
					Y2[1:0] = {Y2[0], Y2[0]};
					Y2[3:0] = {Y2[1:0], Y2[1:0]};
					Y2[7:0] = {Y2[3:0], Y2[3:0]};
					Y2[15:0] = {Y2[7:0], Y2[7:0]};
					Y2[31:0] = {Y2[15:0], Y2[15:0]}; //sign extension		
				end
			else if(S == 2'b10) //shift 2 bit
				begin
					Y1 = B;
				
					//B[31:30] is meaningless in Y1
					Y1[31:2] = B[29:0];
					Y1[1:0] = 2'b00;
					
					//B[31:30] is meaningful in Y2
					Y2[1:0] = Y1[31:30];
					Y2[3:2] = {Y2[1], Y2[1]};
					Y2[7:4] = {Y2[1], Y2[1], Y2[1], Y2[1]};
					Y2[15:8] = {Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1]};
					Y2[31:16] = {Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1], Y2[1]};
					//sign extension
				end
			else if(S == 2'b11) //shift 3 bit
				begin
					Y1 = B;
				
					//B[31:29] is meaningless in Y1
					Y1[31:3] = B[28:0];
					Y1[2:0] = 3'b000;
					
					//B[31:29] is meaningful in Y2
					Y2[2:0] = Y1[31:29];
					Y2[3] = {Y2[2]};
					Y2[7:4] = {Y2[2], Y2[2], Y2[2], Y2[2]};
					Y2[15:8] = {Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2]};
					Y2[31:16] = {Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2], Y2[2]};
					//sign extension
				end
			else //wrong shift
				begin
					Y1 = 32'hxxxx_xxxx;
					
					Y2 = 32'hxxxx_xxxx;
				end
		end
endmodule 

module A_LSRA(A, B, S, Y2, Y1); //LSRA
	input[31:0] A, B;
	input[1:0] S;
	output reg[31:0] Y2, Y1;
 
	always @ (A or B or S)
		begin
			if(S == 2'b00) //no shift
				begin
					Y1 = A;
					
					Y2[0] = Y1[31];
					Y2[1:0] = {Y2[0], Y2[0]};
					Y2[3:0] = {Y2[1:0], Y2[1:0]};
					Y2[7:0] = {Y2[3:0], Y2[3:0]};
					Y2[15:0] = {Y2[7:0], Y2[7:0]};
					Y2[31:0] = {Y2[15:0], Y2[15:0]}; //sign extension
				end
			else if(S == 2'b01) //shift 1 bit
				begin
					Y1 = A;
				
					//A[0] is meaningless
					Y1[30:0] = A[31:1];
					//Y1[31] = Y2[0]
					Y2[0] = Y1[31];
					Y2[1:0] = {Y2[0], Y2[0]};
					Y2[3:0] = {Y2[1:0], Y2[1:0]};
					Y2[7:0] = {Y2[3:0], Y2[3:0]};
					Y2[15:0] = {Y2[7:0], Y2[7:0]};
					Y2[31:0] = {Y2[15:0], Y2[15:0]}; 
					Y2[31] = 1'b0;
					//sign extension			
				end
			else if(S == 2'b10) //shift 2 bit
				begin
					Y1 = A;
				
					//A[1:0] is meaningless
					Y1[29:0] = A[31:2];
					Y1[30] = Y1[31];
					//Y1[31] = Y2[0]
					Y2[0] = Y1[31];
					Y2[1:0] = {Y2[0], Y2[0]};
					Y2[3:0] = {Y2[1:0], Y2[1:0]};
					Y2[7:0] = {Y2[3:0], Y2[3:0]};
					Y2[15:0] = {Y2[7:0], Y2[7:0]};
					Y2[31:0] = {Y2[15:0], Y2[15:0]};
					Y2[31:30] = 2'b00;
					//sign extension
				end
			else if(S == 2'b11) //shift 3 bit
				begin
					Y1 = A;
				
					//A[2:0] is meaningless
					Y1[28:0] = A[31:3];
					Y1[30:29] = {Y1[31], Y1[31]};
					//Y1[31] = Y2[0]
					Y2[0] = Y1[31];
					Y2[1:0] = {Y2[0], Y2[0]};
					Y2[3:0] = {Y2[1:0], Y2[1:0]};
					Y2[7:0] = {Y2[3:0], Y2[3:0]};
					Y2[15:0] = {Y2[7:0], Y2[7:0]};
					Y2[31:0] = {Y2[15:0], Y2[15:0]};
					Y2[31:29] = 3'b000;
					//sign extension			
				end
			else //wrong shift
				begin
					Y1 = 32'hxxxx_xxxx;
					
					Y2 = 32'hxxxx_xxxx;
				end
		end
endmodule

module A_LSRB(A, B, S, Y2, Y1); //LSRB
	input[31:0] A, B;
	input[1:0] S;
	output reg[31:0] Y2, Y1;
 
	always @ (A or B or S)
		begin
			if(S == 2'b00) //no shift
				begin
					Y1 = B;
					
					Y2[0] = Y1[31];
					Y2[1:0] = {Y2[0], Y2[0]};
					Y2[3:0] = {Y2[1:0], Y2[1:0]};
					Y2[7:0] = {Y2[3:0], Y2[3:0]};
					Y2[15:0] = {Y2[7:0], Y2[7:0]};
					Y2[31:0] = {Y2[15:0], Y2[15:0]}; //sign extension	
				end
			else if(S == 2'b01) //shift 1 bit
				begin
					Y1 = B;
				
					//B[0] is meaningless
					Y1[30:0] = B[31:1];
					//Y1[31] = Y2[0]
					Y2[0] = Y1[31];
					Y2[1:0] = {Y2[0], Y2[0]};
					Y2[3:0] = {Y2[1:0], Y2[1:0]};
					Y2[7:0] = {Y2[3:0], Y2[3:0]};
					Y2[15:0] = {Y2[7:0], Y2[7:0]};
					Y2[31:0] = {Y2[15:0], Y2[15:0]}; 
					Y2[31] = 1'b0;
					//sign extension	
				end
			else if(S == 2'b10) //shift 2 bit
				begin
					Y1 = B;
				
					//B[1:0] is meaningless
					Y1[29:0] = B[31:2];
					Y1[30] = Y1[31];
					//Y1[31] = Y2[0]
					Y2[0] = Y1[31];
					Y2[1:0] = {Y2[0], Y2[0]};
					Y2[3:0] = {Y2[1:0], Y2[1:0]};
					Y2[7:0] = {Y2[3:0], Y2[3:0]};
					Y2[15:0] = {Y2[7:0], Y2[7:0]};
					Y2[31:0] = {Y2[15:0], Y2[15:0]};
					Y2[31:30] = 2'b00;
					//sign extension
				end
			else if(S == 2'b11) //shift 3 bit
				begin
					Y1 = B;
				
					//B[2:0] is meaningless
					Y1[28:0] = B[31:3];
					Y1[30:29] = {Y1[31], Y1[31]};
					//Y1[31] = Y2[0]
					Y2[0] = Y1[31];
					Y2[1:0] = {Y2[0], Y2[0]};
					Y2[3:0] = {Y2[1:0], Y2[1:0]};
					Y2[7:0] = {Y2[3:0], Y2[3:0]};
					Y2[15:0] = {Y2[7:0], Y2[7:0]};
					Y2[31:0] = {Y2[15:0], Y2[15:0]};
					Y2[31:29] = 3'b000;
					//sign extension		
				end
			else //wrong shift
				begin
					Y1 = 32'hxxxx_xxxx;
					
					Y2 = 32'hxxxx_xxxx;
				end
		end
endmodule 

module A_ASRA(A, B, S, Y2, Y1); //ASRA
	input[31:0] A, B;
	input[1:0] S;
	output reg[31:0] Y2, Y1;
 
	always @ (A or B or S)
		begin
			if(S == 2'b00) //no shift
				begin
					Y1 = A;
					
					Y2[0] = Y1[31];
					Y2[1:0] = {Y2[0], Y2[0]};
					Y2[3:0] = {Y2[1:0], Y2[1:0]};
					Y2[7:0] = {Y2[3:0], Y2[3:0]};
					Y2[15:0] = {Y2[7:0], Y2[7:0]};
					Y2[31:0] = {Y2[15:0], Y2[15:0]}; //sign extension		
				end
			else if(S == 2'b01) //shift 1 bit
				begin
					Y1 = A;
				
					//A[0] is meaningless
					Y1[30:0] = A[31:1];
					Y1[31] = A[31];
					
					Y2[0] = Y1[31];
					Y2[1:0] = {Y2[0], Y2[0]};
					Y2[3:0] = {Y2[1:0], Y2[1:0]};
					Y2[7:0] = {Y2[3:0], Y2[3:0]};
					Y2[15:0] = {Y2[7:0], Y2[7:0]};
					Y2[31:0] = {Y2[15:0], Y2[15:0]}; //sign extension		
				end
			else if(S == 2'b10) //shift 2 bit
				begin
					Y1 = A;
				
					//A[1:0] is meaningless
					Y1[29:0] = A[31:2];
					Y1[31:30] = {A[31], A[31]};
					
					Y2[0] = Y1[31];
					Y2[1:0] = {Y2[0], Y2[0]};
					Y2[3:0] = {Y2[1:0], Y2[1:0]};
					Y2[7:0] = {Y2[3:0], Y2[3:0]};
					Y2[15:0] = {Y2[7:0], Y2[7:0]};
					Y2[31:0] = {Y2[15:0], Y2[15:0]}; //sign extension
				end
			else if(S == 2'b11) //shift 3 bit
				begin
					Y1 = A;
				
					//A[2:0] is meaningless
					Y1[28:0] = A[31:3];
					Y1[31:29] = {A[31], A[31], A[31]};
					
					Y2[0] = Y1[31];
					Y2[1:0] = {Y2[0], Y2[0]};
					Y2[3:0] = {Y2[1:0], Y2[1:0]};
					Y2[7:0] = {Y2[3:0], Y2[3:0]};
					Y2[15:0] = {Y2[7:0], Y2[7:0]};
					Y2[31:0] = {Y2[15:0], Y2[15:0]}; //sign extension		
				end
			else //wrong shift
				begin
					Y1 = 32'hxxxx_xxxx;
					
					Y2 = 32'hxxxx_xxxx;
				end
		end
endmodule 

module A_ASRB(A, B, S, Y2, Y1); //ASRB
	input[31:0] A, B;
	input[1:0] S;
	output reg[31:0] Y2, Y1;
 
	always @ (A or B or S)
		begin
			if(S == 2'b00) //no shift
				begin
					Y1 = B;
					
					Y2[0] = Y1[31];
					Y2[1:0] = {Y2[0], Y2[0]};
					Y2[3:0] = {Y2[1:0], Y2[1:0]};
					Y2[7:0] = {Y2[3:0], Y2[3:0]};
					Y2[15:0] = {Y2[7:0], Y2[7:0]};
					Y2[31:0] = {Y2[15:0], Y2[15:0]}; //sign extension
				end
			else if(S == 2'b01) //shift 1 bit
				begin
					Y1 = B;
				
					//B[0] is meaningless
					Y1[30:0] = B[31:1];
					Y1[31] = B[31];
					
					Y2[0] = Y1[31];
					Y2[1:0] = {Y2[0], Y2[0]};
					Y2[3:0] = {Y2[1:0], Y2[1:0]};
					Y2[7:0] = {Y2[3:0], Y2[3:0]};
					Y2[15:0] = {Y2[7:0], Y2[7:0]};
					Y2[31:0] = {Y2[15:0], Y2[15:0]}; //sign extension			
				end
			else if(S == 2'b10) //shift 2 bit
				begin
					Y1 = B;
				
					//B[1:0] is meaningless
					Y1[29:0] = B[31:2];
					Y1[31:30] = {B[31], B[31]};
					
					Y2[0] = Y1[31];
					Y2[1:0] = {Y2[0], Y2[0]};
					Y2[3:0] = {Y2[1:0], Y2[1:0]};
					Y2[7:0] = {Y2[3:0], Y2[3:0]};
					Y2[15:0] = {Y2[7:0], Y2[7:0]};
					Y2[31:0] = {Y2[15:0], Y2[15:0]}; //sign extension
				end
			else if(S == 2'b11) //shift 3 bit
				begin
					Y1 = B;
				
					//B[2:0] is meaningless
					Y1[28:0] = B[31:3];
					Y1[31:29] = {B[31], B[31], B[31]};
					
					Y2[0] = Y1[31];
					Y2[1:0] = {Y2[0], Y2[0]};
					Y2[3:0] = {Y2[1:0], Y2[1:0]};
					Y2[7:0] = {Y2[3:0], Y2[3:0]};
					Y2[15:0] = {Y2[7:0], Y2[7:0]};
					Y2[31:0] = {Y2[15:0], Y2[15:0]}; //sign extension		
				end
			else //wrong shift
				begin
					Y1 = 32'hxxxx_xxxx;
					
					Y2 = 32'hxxxx_xxxx;
				end
		end
endmodule 

module A_ADD(A1, B1, Y2, Y1); //ADD
	input[31:0] A1, B1;
	output[31:0] Y2, Y1;
	
	wire[31:0] A2, B2;//extended sign
	
	assign A2[7:0] = {A1[31], A1[31], A1[31], A1[31], A1[31], A1[31], A1[31], A1[31]};
	assign A2[15:8] = {A1[31], A1[31], A1[31], A1[31], A1[31], A1[31], A1[31], A1[31]};
	assign A2[23:16] = {A1[31], A1[31], A1[31], A1[31], A1[31], A1[31], A1[31], A1[31]};
	assign A2[31:24] = {A1[31], A1[31], A1[31], A1[31], A1[31], A1[31], A1[31], A1[31]};
	//sign extension (32 -> 64)
	
	assign B2[7:0] = {B1[31], B1[31], B1[31], B1[31], B1[31], B1[31], B1[31], B1[31]};
	assign B2[15:8] = {B1[31], B1[31], B1[31], B1[31], B1[31], B1[31], B1[31], B1[31]};
	assign B2[23:16] = {B1[31], B1[31], B1[31], B1[31], B1[31], B1[31], B1[31], B1[31]};
	assign B2[31:24] = {B1[31], B1[31], B1[31], B1[31], B1[31], B1[31], B1[31], B1[31]};
	//sign extension (32 -> 64)
	
	cla64 cla64_1({A2, A1}, {B2, B1}, 1'b0, {Y2, Y1}); //get add result	
endmodule
	
module A_SUB(A1, B1, Y2, Y1); //SUB
	input[31:0] A1, B1;
	output[31:0] Y2, Y1;
	
	wire[31:0] A2, B2;//extended sign
	
	assign A2[7:0] = {A1[31], A1[31], A1[31], A1[31], A1[31], A1[31], A1[31], A1[31]};
	assign A2[15:8] = {A1[31], A1[31], A1[31], A1[31], A1[31], A1[31], A1[31], A1[31]};
	assign A2[23:16] = {A1[31], A1[31], A1[31], A1[31], A1[31], A1[31], A1[31], A1[31]};
	assign A2[31:24] = {A1[31], A1[31], A1[31], A1[31], A1[31], A1[31], A1[31], A1[31]};
	//sign extension (32 -> 64)
	
	assign B2[7:0] = {B1[31], B1[31], B1[31], B1[31], B1[31], B1[31], B1[31], B1[31]};
	assign B2[15:8] = {B1[31], B1[31], B1[31], B1[31], B1[31], B1[31], B1[31], B1[31]};
	assign B2[23:16] = {B1[31], B1[31], B1[31], B1[31], B1[31], B1[31], B1[31], B1[31]};
	assign B2[31:24] = {B1[31], B1[31], B1[31], B1[31], B1[31], B1[31], B1[31], B1[31]};
	//sign extension (32 -> 64)
	
	cla64 cla64_1({A2, A1}, ~{B2, B1}, 1'b1, {Y2, Y1}); //get SUB result	
endmodule 
	
module A_MUL(clk, reset_n, A1, B1, op_start, op_clear, op_done, Y2, Y1); //32bit x 32bit = 128bit
	input clk, reset_n;
	input[31:0] A1, B1;
	input op_start, op_clear;
	output op_done;
	output[31:0] Y2, Y1;

	wire[31:0] A2, B2;//extended sign
	
	wire[127:0] Y;
	
	assign A2[7:0] = {A1[31], A1[31], A1[31], A1[31], A1[31], A1[31], A1[31], A1[31]};
	assign A2[15:8] = {A1[31], A1[31], A1[31], A1[31], A1[31], A1[31], A1[31], A1[31]};
	assign A2[23:16] = {A1[31], A1[31], A1[31], A1[31], A1[31], A1[31], A1[31], A1[31]};
	assign A2[31:24] = {A1[31], A1[31], A1[31], A1[31], A1[31], A1[31], A1[31], A1[31]};
	//sign extension (32 -> 64)
	
	assign B2[7:0] = {B1[31], B1[31], B1[31], B1[31], B1[31], B1[31], B1[31], B1[31]};
	assign B2[15:8] = {B1[31], B1[31], B1[31], B1[31], B1[31], B1[31], B1[31], B1[31]};
	assign B2[23:16] = {B1[31], B1[31], B1[31], B1[31], B1[31], B1[31], B1[31], B1[31]};
	assign B2[31:24] = {B1[31], B1[31], B1[31], B1[31], B1[31], B1[31], B1[31], B1[31]};
	//sign extension (32 -> 64)
	
	assign Y2 = Y[63:32];
	assign Y1 = Y[31:0]; //128->64
	multiplier multiplier_1(clk, reset_n, {A2, A1}, {B2, B1}, op_start, op_clear, op_done, Y);
	//64bit x 64bit = 128bit
endmodule 