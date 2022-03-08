`timescale 1ns/100ps

module tb_bus;
	reg clk, reset_n, m0_req, m0_wr;
	reg[15:0] m0_addr;
	reg[31:0] m0_dout;
	reg m1_req, m1_wr;
	reg[15:0] m1_addr;
	reg[31:0] m1_dout, s0_dout, s1_dout, s2_dout, s3_dout, s4_dout;
	wire m0_grant, m1_grant;
	wire[31:0] m_din;
	wire s0_sel, s1_sel, s2_sel, s3_sel, s4_sel;
	wire[15:0] s_addr;
	wire s_wr;
	wire[31:0] s_din;
	
	BUS bus_1(clk, reset_n, m0_req, m0_wr, m0_addr, m0_dout, m1_req, m1_wr, m1_addr, m1_dout, s0_dout, s1_dout, s2_dout, s3_dout, s4_dout, m0_grant, m1_grant, m_din, s0_sel, s1_sel, s2_sel, s3_sel, s4_sel, s_addr, s_wr, s_din);
	
	always
		begin
			#5; clk = ~clk; //cycle of clk is 10ns
		end
		
	initial
		begin
			clk = 0; reset_n = 1;
			m0_req = 0; m0_wr = 0; m0_addr = 16'h0000; m0_dout = 32'h0000_0000;
			m1_req = 0; m1_wr = 0; m1_addr = 16'h0000; m1_dout = 32'h0000_0000;
			s0_dout = 32'h0000_0000; s1_dout = 32'h0000_0000; s2_dout = 32'h0000_0000; s3_dout = 32'h0000_0000; s4_dout = 32'h0000_0000; #4;
			
			reset_n = 0; #10; reset_n = 1; #10; //resetted
			
			s0_dout = 32'h0000_0001; #10; //s0_dout changed
			m0_req = 1; #10; m0_wr = 0; #10; m0_addr = 16'h0000; #10; //m0 read 1 from s0
			m0_wr = 1; #10; m0_addr = 16'h0000; #10; m0_dout = 32'h0000_0020; #10; //m0 write 20 to s0
			
			s1_dout = 32'h0000_0300; #10; //s1_dout changed
			m0_req = 0; #10; m1_req = 1; #10; m1_wr = 0; #10; m1_addr = 16'h0100; #10; //m1 read 300 from s1
			m1_wr = 1; #10; m1_addr = 16'h0100; #10; m1_dout = 32'h0000_4000; #10; //m1 write 4000 to s1
			
			s2_dout = 32'h0005_0000; #10; //s2_dout changed
			m1_req = 0; #10; m0_req = 1; #10; m0_wr = 0; #10; m0_addr = 16'h0200; #10; //m0 read 50000 from s2
			m0_wr = 1; #10; m0_addr = 16'h0200; #10; m0_dout = 32'h0060_0000; #10; //m0 write 600000 to s2
			
			s3_dout = 32'h0700_0000; #10; //s3_dout changed
			m0_req = 0; #10; m1_req = 1; #10; m1_wr = 0; #10; m1_addr = 16'h0300; #10; //m1 read 7000000 from s3
			m1_wr = 1; #10; m1_addr = 16'h0300; #10; m1_dout = 32'h8000_0000; #10; //m1 write 80000000 to s3
			
			s4_dout = 32'h0000_0011; #10; //s4_dout changed
			m1_req = 0; #10; m0_req = 1; #10; m0_wr = 0; #10; m0_addr = 16'h0400; #10; //m0 read 11 from s1
			m0_wr = 1; #10; m0_addr = 16'h0400; #10; m0_dout = 32'h0000_2200; #10; //m0 write 2200 to s1
			
			//memory map
			//s0 = 0000 0000 0000 0000 ~ 0000 0000 0001 1111
			//s1 = 0000 0001 0000 0000 ~ 0000 0001 0001 1111
			//s2 = 0000 0010 0000 0000 ~ 0000 0010 0011 1111
			//s3 = 0000 0011 0000 0000 ~ 0000 0011 0011 1111
			//s4 = 0000 0100 0000 0000 ~ 0000 0100 0011 1111
		end
endmodule 