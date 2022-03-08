`timescale 1ns/100ps

module tb_ALU_alu;
	reg clk, reset_n;
	reg[3:0] op_code;
	reg[1:0] shift;
	reg[31:0] operand_1, operand_2;
	reg op_start, op_clear;
	
	wire[31:0] result_2, result_1;
	wire op_done;
	
	ALU_alu ALU_alu_1(clk, reset_n, op_code, shift, operand_1, operand_2, op_start, op_clear, result_2, result_1, op_done);

	always
		begin
			#5; clk = ~clk; //cycle of clk is 10ns
		end
	
	initial
		begin
			#4; clk = 1'b0; reset_n = 1'b1; op_code = 4'b0000; shift = 2'b00;
			operand_1 = -1; operand_2 = -1;
			op_start = 1'b0; op_clear = 1'b0; #10; //set zero
			
			reset_n = 1'b0; #10; reset_n = 1'b1; #10; //resetted
			
			//operand_1 = 10; operand_2 = -10;
			op_code = 4'b0000; op_start = 1'b1; #10; op_start = 1'b0; #10; //0
			
			//operand_1 = 10; operand_2 = -10;
			op_code = 4'b0001; op_start = 1'b1; #10; op_start = 1'b0; #10; //1
			
			//operand_1 = 10; operand_2 = -10;
			op_code = 4'b0010; op_start = 1'b1; #10; op_start = 1'b0; #10; //2
			
			//operand_1 = 10; operand_2 = -10;
			op_code = 4'b0011; op_start = 1'b1; #10; op_start = 1'b0; #10; //3
			
			//operand_1 = 10; operand_2 = -10;
			op_code = 4'b0100; op_start = 1'b1; #10; op_start = 1'b0; #10; //4
			
			//operand_1 = 10; operand_2 = -10;
			op_code = 4'b0101; op_start = 1'b1; #10; op_start = 1'b0; #10; //5
			
			//operand_1 = 10; operand_2 = -10;
			op_code = 4'b0110; op_start = 1'b1; #10; op_start = 1'b0; #10; //6
			
			//operand_1 = 10; operand_2 = -10;
			op_code = 4'b0111; shift = 2'b10; op_start = 1'b1; #10; op_start = 1'b0; shift = 2'b00; #10; //7
			
			//operand_1 = 10; operand_2 = -10;
			op_code = 4'b1000; shift = 2'b10; op_start = 1'b1; #10; op_start = 1'b0; shift = 2'b00; #10; //8
			
			//operand_1 = 10; operand_2 = -10;
			op_code = 4'b1001; shift = 2'b10; op_start = 1'b1; #10; op_start = 1'b0; shift = 2'b00; #10; //9
			
			//operand_1 = 10; operand_2 = -10;
			op_code = 4'b1010; shift = 2'b10; op_start = 1'b1; #10; op_start = 1'b0; shift = 2'b00; #10; //10
			
			//operand_1 = 10; operand_2 = -10;
			op_code = 4'b1011; shift = 2'b10; op_start = 1'b1; #10; op_start = 1'b0; shift = 2'b00; #10; //11
			
			//operand_1 = 10; operand_2 = -10;
			op_code = 4'b1100; shift = 2'b10; op_start = 1'b1; #10; op_start = 1'b0; shift = 2'b00; #10; //12
			
			//operand_1 = 10; operand_2 = -10;
			op_code = 4'b1101; op_start = 1'b1; #10; op_start = 1'b0; #10; //13 
			
			//operand_1 = 10; operand_2 = -10;
			op_code = 4'b1110; op_start = 1'b1; #10; op_start = 1'b0; #10; //14
			
			//operand_1 = 10; operand_2 = -10;
			op_code = 4'b1111; op_clear = 1'b1; #10; op_clear = 1'b0; #10;
			op_start = 1'b1; #10; op_start = 1'b0; #10; //15
			#700; //15
		end
		
	
endmodule 