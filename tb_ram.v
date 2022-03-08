`timescale 1ns/100ps

module tb_ram;
	reg clk;
	reg cen, wen;
	reg[15:0] addr; //addr = 00000(0) ~ 11111(31)
	reg[31:0] din;
	wire[31:0] dout;
	
	ram ram_1(clk, cen, wen, addr, din, dout);
	
	always
		begin
			#5; clk = ~clk; //cycle of clk is 10ns
		end
	
	initial
		begin
			clk = 1'b0; #4; cen = 1'b0; wen = 1'b0; addr = 16'b0000_0000_0000_0000; din = 32'h0000_0000; #10;
			addr = 16'b0000_0000_0000_0001; #10;
			addr = 16'b0000_0000_0000_0010; #10;
			addr = 16'b0000_0000_0000_0100; #10;
			addr = 16'b0000_0000_0000_1000; #10;
			addr = 16'b0000_0000_0001_0000; #10; //addr increase but do nothing
			
			cen = 1'b1; wen = 1'b1; din = 10000; addr = 16'b0000_0000_0000_0000; #10;
			din = 20000; addr = 16'b0000_0000_0000_0001; #10;
			din = 30000; addr = 16'b0000_0000_0000_0010; #10;
			din = 40000; addr = 16'b0000_0000_0000_0100; #10; //write 4 values
		
			cen = 1'b1; wen = 1'b0; addr = 16'b0000_0000_0000_0010; #10;
			addr = 16'b0000_0000_0000_0100; #10;
			addr = 16'b0000_0000_0000_1000; #10;
			addr = 16'b0000_0000_0001_0000; #10; //read 4 values (only 2 values are meaningfull)
		end
endmodule 