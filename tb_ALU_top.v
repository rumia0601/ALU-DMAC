`timescale 1ns/100ps

module tb_ALU_top;
	reg clk, reset_n, s_sel, s_wr;
	reg[15:0] s_addr;
	reg[31:0] s_din;
	
	wire[31:0] s_dout;
	wire s_interrupt;
	//wire for register file
	
	ALU_Top ALU_Top_1(clk, reset_n, s_sel, s_wr, s_addr, s_din, s_dout, s_interrupt);
	
	always
		begin
			#5; clk = ~clk; //cycle of clock is 10ns
		end
	
	initial
		begin
			#4; clk = 1'b0; reset_n = 1'b1; s_sel = 1'b0; s_wr = 1'b0;
			s_addr = 16'h0000; s_din = 32'h0000_0000; #10; //initialize
			
			reset_n = 1'b0; #10; reset_n = 1'b1; #10; //resetted
			
			s_sel = 1'b1; s_wr = 1'b1; s_addr = 16'h0003; s_din = 32'b0000_0000_0000_0000_00_1111_0000_0001_00; #10; s_sel = 1'b0; #10;//1th operation
			s_sel = 1'b1; s_wr = 1'b1; s_addr = 16'h0003; s_din = 32'b0000_0000_0000_0000_00_1111_0010_0011_00; #10; s_sel = 1'b0; #10;//2th operation
			s_sel = 1'b1; s_wr = 1'b1; s_addr = 16'h0003; s_din = 32'b0000_0000_0000_0000_00_1111_0100_0101_00; #10; s_sel = 1'b0; #10;//3th operation
			s_sel = 1'b1; s_wr = 1'b1; s_addr = 16'h0003; s_din = 32'b0000_0000_0000_0000_00_1111_0110_0111_00; #10; s_sel = 1'b0; #10;//4th operation
			s_sel = 1'b1; s_wr = 1'b1; s_addr = 16'h0003; s_din = 32'b0000_0000_0000_0000_00_1111_1000_1001_00; #10; s_sel = 1'b0; #10;//5th operation
			s_sel = 1'b1; s_wr = 1'b1; s_addr = 16'h0003; s_din = 32'b0000_0000_0000_0000_00_1111_1010_1011_00; #10; s_sel = 1'b0; #10;//6th operation
			s_sel = 1'b1; s_wr = 1'b1; s_addr = 16'h0003; s_din = 32'b0000_0000_0000_0000_00_1111_1100_1101_00; #10; s_sel = 1'b0; #10;//7th operation
			s_sel = 1'b1; s_wr = 1'b1; s_addr = 16'h0003; s_din = 32'b0000_0000_0000_0000_00_1111_1110_1111_00; #10; s_sel = 1'b0; #10;//8th operation
			//push 8 instruction
			
			s_sel = 1'b1; s_wr = 1'b1; s_addr = 16'h0010; s_din = -1; #10; s_sel = 1'b0; #10; //1th operand
			s_sel = 1'b1; s_wr = 1'b1; s_addr = 16'h0011; s_din = 2; #10; s_sel = 1'b0; #10; //2th operand
			s_sel = 1'b1; s_wr = 1'b1; s_addr = 16'h0012; s_din = 100; #10; s_sel = 1'b0; #10; //3th operand
			s_sel = 1'b1; s_wr = 1'b1; s_addr = 16'h0013; s_din = 1000; #10; s_sel = 1'b0; #10; //4th operand
			s_sel = 1'b1; s_wr = 1'b1; s_addr = 16'h0014; s_din = 10000; #10; s_sel = 1'b0; #10; //5th operand
			s_sel = 1'b1; s_wr = 1'b1; s_addr = 16'h0015; s_din = 100000; #10; s_sel = 1'b0; #10; //6th operand
			s_sel = 1'b1; s_wr = 1'b1; s_addr = 16'h0016; s_din = 1000000; #10; s_sel = 1'b0; #10; //7th operand
			s_sel = 1'b1; s_wr = 1'b1; s_addr = 16'h0017; s_din = 10000000; #10; s_sel = 1'b0; #10; //8th operand
			s_sel = 1'b1; s_wr = 1'b1; s_addr = 16'h0018; s_din = -5; #10; s_sel = 1'b0; #10; //9th operand
			s_sel = 1'b1; s_wr = 1'b1; s_addr = 16'h0019; s_din = 50; #10; s_sel = 1'b0; #10; //10th operand
			s_sel = 1'b1; s_wr = 1'b1; s_addr = 16'h001A; s_din = 500; #10; s_sel = 1'b0; #10; //11th operand
			s_sel = 1'b1; s_wr = 1'b1; s_addr = 16'h001B; s_din = 5000; #10; s_sel = 1'b0; #10; //12th operand
			s_sel = 1'b1; s_wr = 1'b1; s_addr = 16'h001C; s_din = 50000; #10; s_sel = 1'b0; #10; //13th operand
			s_sel = 1'b1; s_wr = 1'b1; s_addr = 16'h001D; s_din = 500000; #10; s_sel = 1'b0; #10; //14th operand
			s_sel = 1'b1; s_wr = 1'b1; s_addr = 16'h001E; s_din = 5000000; #10; s_sel = 1'b0; #10; //15th operand
			s_sel = 1'b1; s_wr = 1'b1; s_addr = 16'h001F; s_din = 50000000; #10; s_sel = 1'b0; #10; //16th operand
			
			s_sel = 1'b1; s_wr = 1'b1; s_addr = 16'h0000; s_din = 32'h0000_0001; #10; s_sel = 1'b0; #10; //start
			#10000; //and done
	
			s_sel = 1'b1; s_wr = 1'b0; s_addr = 16'h0004; #10; s_sel = 1'b0; #20;
			s_sel = 1'b1; s_wr = 1'b0; s_addr = 16'h0004; #10; s_sel = 1'b0; #20;
			s_sel = 1'b1; s_wr = 1'b0; s_addr = 16'h0004; #10; s_sel = 1'b0; #20;
			s_sel = 1'b1; s_wr = 1'b0; s_addr = 16'h0004; #10; s_sel = 1'b0; #20;
			s_sel = 1'b1; s_wr = 1'b0; s_addr = 16'h0004; #10; s_sel = 1'b0; #20;
			s_sel = 1'b1; s_wr = 1'b0; s_addr = 16'h0004; #10; s_sel = 1'b0; #20;
			s_sel = 1'b1; s_wr = 1'b0; s_addr = 16'h0004; #10; s_sel = 1'b0; #20;
			s_sel = 1'b1; s_wr = 1'b0; s_addr = 16'h0004; #10; s_sel = 1'b0; #20;
			s_sel = 1'b1; s_wr = 1'b0; s_addr = 16'h0004; #10; s_sel = 1'b0; #20;
			s_sel = 1'b1; s_wr = 1'b0; s_addr = 16'h0004; #10; s_sel = 1'b0; #20;
			s_sel = 1'b1; s_wr = 1'b0; s_addr = 16'h0004; #10; s_sel = 1'b0; #20;
			s_sel = 1'b1; s_wr = 1'b0; s_addr = 16'h0004; #10; s_sel = 1'b0; #20;
			s_sel = 1'b1; s_wr = 1'b0; s_addr = 16'h0004; #10; s_sel = 1'b0; #20;
			s_sel = 1'b1; s_wr = 1'b0; s_addr = 16'h0004; #10; s_sel = 1'b0; #20;
			s_sel = 1'b1; s_wr = 1'b0; s_addr = 16'h0004; #10; s_sel = 1'b0; #20;
			s_sel = 1'b1; s_wr = 1'b0; s_addr = 16'h0004; #10; s_sel = 1'b0; #20;
			//check 16 result
			//00 - operation start
			//01 - interrupt
			//02 - interrupt clear
			//03 - instruction
			//04 - result
			//05 - alu status
			//10
			//1f - operand
			
		end 
endmodule 