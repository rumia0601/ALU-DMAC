`timescale 1ns/100ps

module tb_ALU_registerfile;
	reg clk, reset_n, we;
	reg[3:0] wAddr, rAddr;
	reg[31:0] wData;
	wire[31:0] rData;
	
	ALU_registerfile ALU_registerfile_1(clk, reset_n, wAddr, wData, we, rAddr, rData);
	
	always
		begin
			#5; clk = ~clk; //cycle of clock is 10ns
		end
		
	initial
		begin
			clk = 0; reset_n = 1; we = 0; wAddr = 4'b0000; rAddr = 4'b0000; #4; //read 1st register(but x value)
			reset_n = 0; #10; reset_n = 1; #10; //resetted
			wAddr = 4'b0000; wData = 32'b0101_1011_1011_1101_1111_0111_1110_1111; #10;//write 1st register(but not be writted), read 1st register
			we = 1; wAddr = 4'b0001; wData = 32'b0101_1011_1011_1101_1111_0111_1110_1111; #10;//write 2nd register
			we = 0; rAddr = 4'b0001; #10; //read 2nd register
			we = 1; wAddr = 4'b0111; wData = 32'b1011_0111_0111_1011_1110_1111_1101_1111; #10;//write 8th register
			we = 0; rAddr = 4'b0111; #10; //read 8th register
			wAddr = 4'b1000; wData = 32'b0101_1011_1011_1101_1111_0111_1110_1111; #10;//write 9th register(but not be writted), read 1st register
			we = 1; wAddr = 4'b1001; wData = 32'b0101_1011_1011_1101_1111_0111_1110_1111; #10;//write 10th register
			we = 0; rAddr = 4'b1001; #10; //read 10th register
			we = 1; wAddr = 4'b1111; wData = 32'b1011_0111_0111_1011_1110_1111_1101_1111; #10;//write 16th register
			we = 0; rAddr = 4'b1111; #10; //read 16th register
			
			/*
			clk = 0; reset_n = 1; we = 0;
			reset_n = 0; #10; reset_n = 1; #10; //resetted
			we = 1; wAddr = 4'b0000; wData = 1; #10;//write 1
			we = 1; wAddr = 4'b0001; wData = 2; #10;//write 2
			we = 1; wAddr = 4'b0010; wData = 3; #10;//write 3
			we = 1; wAddr = 4'b0011; wData = 4; #10;//write 4
			we = 1; wAddr = 4'b0100; wData = 5; #10;//write 5
			we = 1; wAddr = 4'b0101; wData = 6; #10;//write 6
			we = 1; wAddr = 4'b0110; wData = 7; #10;//write 7
			we = 1; wAddr = 4'b0111; wData = 8; #10;//write 8
			we = 1; wAddr = 4'b1000; wData = 9; #10;//write 9
			we = 1; wAddr = 4'b1001; wData = 10; #10;//write 10
			we = 1; wAddr = 4'b1010; wData = 11; #10;//write 11
			we = 1; wAddr = 4'b1011; wData = 12; #10;//write 12
			we = 1; wAddr = 4'b1100; wData = 13; #10;//write 13
			we = 1; wAddr = 4'b1101; wData = 14; #10;//write 14
			we = 1; wAddr = 4'b1110; wData = 15; #10;//write 15
			we = 1; wAddr = 4'b1111; wData = 16; #10;//write 16
			we = 0; rAddr = 4'b0000; #10;//read 1
			we = 0; rAddr = 4'b0001; #10;//read 2
			we = 0; rAddr = 4'b0010; #10;//read 3
			we = 0; rAddr = 4'b0011; #10;//read 4
			we = 0; rAddr = 4'b0100; #10;//read 5
			we = 0; rAddr = 4'b0101; #10;//read 6
			we = 0; rAddr = 4'b0110; #10;//read 7
			we = 0; rAddr = 4'b0111; #10;//read 8
			we = 0; rAddr = 4'b1000; #10;//read 9
			we = 0; rAddr = 4'b1001; #10;//read 10
			we = 0; rAddr = 4'b1010; #10;//read 11
			we = 0; rAddr = 4'b1011; #10;//read 12
			we = 0; rAddr = 4'b1100; #10;//read 13
			we = 0; rAddr = 4'b1101; #10;//read 14
			we = 0; rAddr = 4'b1110; #10;//read 15
			we = 0; rAddr = 4'b1111; #10;//read 16
			*/
		end
endmodule 