module ALU_alu(clk, reset_n, op_code, shift, operand_1, operand_2, op_start, op_clear, result_2, result_1, op_done);
	input clk, reset_n;
	input[3:0] op_code;
	input[1:0] shift;
	input[31:0] operand_1, operand_2;
	input op_start, op_clear;
	
	output reg[31:0] result_2, result_1;
	output reg op_done;
	
	wire[31:0] Y2_0, Y1_0;
	wire[31:0] Y2_1, Y1_1;
	wire[31:0] Y2_2, Y1_2;
	wire[31:0] Y2_3, Y1_3;
	wire[31:0] Y2_4, Y1_4;
	wire[31:0] Y2_5, Y1_5;
	wire[31:0] Y2_6, Y1_6;
	wire[31:0] Y2_7, Y1_7;
	wire[31:0] Y2_8, Y1_8;
	wire[31:0] Y2_9, Y1_9;
	wire[31:0] Y2_A, Y1_A;
	wire[31:0] Y2_B, Y1_B;
	wire[31:0] Y2_C, Y1_C;
	wire[31:0] Y2_D, Y1_D;
	wire[31:0] Y2_E, Y1_E;
	wire[31:0] Y2_F, Y1_F;
	//two operand and 16 results(extended)
	
	reg OP_START, OP_CLEAR;
	wire W_OP_START, W_OP_CLEAR, W_OP_DONE;
	assign W_OP_START = OP_START;
	assign W_OP_CLEAR = OP_CLEAR;
	
	A_NOP NOP_1(operand_1, operand_2, Y2_0, Y1_0);
	A_NOTA NOTA_1(operand_1, operand_2, Y2_1, Y1_1);
	A_NOTB NOTB_1(operand_1, operand_2, Y2_2, Y1_2);
	A_AND AND_1(operand_1, operand_2, Y2_3, Y1_3);
	A_OR OR_1(operand_1, operand_2, Y2_4, Y1_4);
	A_XOR XOR_1(operand_1, operand_2, Y2_5, Y1_5);
	A_XNOR XNOR_1(operand_1, operand_2, Y2_6, Y1_6);
	A_LSLA LSLA_1(operand_1, operand_2, shift, Y2_7, Y1_7);
	A_LSRA LSRA_1(operand_1, operand_2, shift, Y2_8, Y1_8);
	A_ASRA ASRA_1(operand_1, operand_2, shift, Y2_9, Y1_9);
	A_LSLB LSLB_1(operand_1, operand_2, shift, Y2_A, Y1_A);
	A_LSRB LSRB_1(operand_1, operand_2, shift, Y2_B, Y1_B);
	A_ASRB ASRB_1(operand_1, operand_2, shift, Y2_C, Y1_C);
	A_ADD ADD_1(operand_1, operand_2, Y2_D, Y1_D);
	A_SUB SUB_1(operand_1, operand_2, Y2_E, Y1_E);
	A_MUL MUL_1(clk, reset_n, operand_1, operand_2, W_OP_START, W_OP_CLEAR, W_OP_DONE, Y2_F, Y1_F);
	//16 calculating blocks
	
	always @ (posedge clk or negedge reset_n)
		begin
			if (reset_n == 1'b0) //resetted
				begin
					result_2 = 32'h0000_0000;
					result_1 = 32'h0000_0000;
					op_done = 1'b0;
					OP_START = 1'b0;
					OP_CLEAR = 1'b0;
				end
		
			else if (clk == 1'b1)
				begin
					if (op_code == 4'h0) //NOP
						begin
							if (op_start == 1'b1)
								begin 
									result_2 = Y2_0;
									result_1 = Y1_0;
									op_done = 1'b1;
								end
							else if (op_start == 1'b0)
								begin
									result_2 = Y2_0;
									result_1 = Y1_0;
									op_done = 1'b0;
								end
						end
						
					else if (op_code == 4'h1) //NOTA
						begin
							if (op_start == 1'b1)
								begin 
									result_2 = Y2_1;
									result_1 = Y1_1;
									op_done = 1'b1;
								end
							else if (op_start == 1'b0)
								begin
									result_2 = Y2_1;
									result_1 = Y1_1;
									op_done = 1'b0;
								end
						end
						
					else if (op_code == 4'h2) //NOTB
						begin
							if (op_start == 1'b1)
								begin 
									result_2 = Y2_2;
									result_1 = Y1_2;
									op_done = 1'b1;
								end
							else if (op_start == 1'b0)
								begin
									result_2 = Y2_2;
									result_1 = Y1_2;
									op_done = 1'b0;
								end
						end
						
					else if (op_code == 4'h3) //AND
						begin
							if (op_start == 1'b1)
								begin 
									result_2 = Y2_3;
									result_1 = Y1_3;
									op_done = 1'b1;
								end
							else if (op_start == 1'b0)
								begin
									result_2 = Y2_3;
									result_1 = Y1_3;
									op_done = 1'b0;
								end
						end
						
					else if (op_code == 4'h4) //OR
						begin
							if (op_start == 1'b1)
								begin 
									result_2 = Y2_4;
									result_1 = Y1_4;
									op_done = 1'b1;
								end
							else if (op_start == 1'b0)
								begin
									result_2 = Y2_4;
									result_1 = Y1_4;
									op_done = 1'b0;
								end
						end
						
					else if (op_code == 4'h5) //XOR
						begin
							if (op_start == 1'b1)
								begin 
									result_2 = Y2_5;
									result_1 = Y1_5;
									op_done = 1'b1;
								end
							else if (op_start == 1'b0)
								begin
									result_2 = Y2_5;
									result_1 = Y1_5;
									op_done = 1'b0;
								end
						end
						
					else if (op_code == 4'h6) //XNOR
						begin
							if (op_start == 1'b1)
								begin 
									result_2 = Y2_6;
									result_1 = Y1_6;
									op_done = 1'b1;
								end
							else if (op_start == 1'b0)
								begin
									result_2 = Y2_6;
									result_1 = Y1_6;
									op_done = 1'b0;
								end
						end
					
					else if (op_code == 4'h7) //LSLA
						begin
							if (op_start == 1'b1)
								begin 
									result_2 = Y2_7;
									result_1 = Y1_7;
									op_done = 1'b1;
								end
							else if (op_start == 1'b0)
								begin
									result_2 = Y2_7;
									result_1 = Y1_7;
									op_done = 1'b0;
								end
						end
						
					else if (op_code == 4'h8) //LSRA
						begin
							if (op_start == 1'b1)
								begin 
									result_2 = Y2_8;
									result_1 = Y1_8;
									op_done = 1'b1;
								end
							else if (op_start == 1'b0)
								begin
									result_2 = Y2_8;
									result_1 = Y1_8;
									op_done = 1'b0;
								end
						end
						
					else if (op_code == 4'h9) //ASRA
						begin
							if (op_start == 1'b1)
								begin 
									result_2 = Y2_9;
									result_1 = Y1_9;
									op_done = 1'b1;
								end
							else if (op_start == 1'b0)
								begin
									result_2 = Y2_9;
									result_1 = Y1_9;
									op_done = 1'b0;
								end
						end
						
					else if (op_code == 4'hA) //LSLB
						begin
							if (op_start == 1'b1)
								begin 
									result_2 = Y2_A;
									result_1 = Y1_A;
									op_done = 1'b1;
								end
							else if (op_start == 1'b0)
								begin
									result_2 = Y2_A;
									result_1 = Y1_A;
									op_done = 1'b0;
								end
						end
						
					else if (op_code == 4'hB) //LSRB
						begin
							if (op_start == 1'b1)
								begin
									result_2 = Y2_B;
									result_1 = Y1_B;
									op_done = 1'b1;
								end
							else if (op_start == 1'b0)
								begin
									result_2 = Y2_B;
									result_1 = Y1_B;
									op_done = 1'b0;
								end
						end
						
					else if (op_code == 4'hC) //ASRB
						begin
							if (op_start == 1'b1)
								begin 
									result_2 = Y2_C;
									result_1 = Y1_C;
									op_done = 1'b1;
								end
							else if (op_start == 1'b0)
								begin
									result_2 = Y2_C;
									result_1 = Y1_C;
									op_done = 1'b0;
								end
						end
					
					else if (op_code == 4'hD) //ADD
						begin
							if (op_start == 1'b1)
								begin 
									result_2 = Y2_D;
									result_1 = Y1_D;
									op_done = 1'b1;
								end
							else if (op_start == 1'b0)
								begin
									result_2 = Y2_D;
									result_1 = Y1_D;
									op_done = 1'b0;
								end
						end
						
					else if (op_code == 4'hE) //SUB
						begin
							if (op_start == 1'b1)
								begin 
									result_2 = Y2_E;
									result_1 = Y1_E;
									op_done = 1'b1;
								end
							else if (op_start == 1'b0)
								begin
									result_2 = Y2_E;
									result_1 = Y1_E;
									op_done = 1'b0;
								end
						end
					
					else if (op_code == 4'hF) //MUL
						begin
							if (op_clear == 1'b1) //clear
								begin
									OP_CLEAR = 1'b1;
									OP_START = 1'b0;
									op_done = 1'b0;
								end
							if (op_start == 1'b1) //start
								begin
									OP_CLEAR = 1'b0;
									OP_START = 1'b1;
									op_done = 1'b0;
								end
							if (W_OP_DONE == 1'b1) //done
								begin
									result_2 = Y2_F;
									result_1 = Y1_F;
									op_done = 1'b1;
								end
						end
					
					else //wrong opcode
						begin
							result_2 = 32'hxxxx_xxxx;
							result_1 = 32'hxxxx_xxxx;
							op_done = 1'bx;
						end
				end
		end
	
endmodule 