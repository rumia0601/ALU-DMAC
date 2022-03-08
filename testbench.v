`timescale 1ns/100ps

module testbench;
	reg clk, reset_n, m0_req, m0_wr;
	reg[15:0] m0_address;
	reg[31:0] m0_dout;
	wire m0_grant, a_interrupt, d_interrupt;
	wire[31:0] m_din;

	Top Top1(clk, reset_n, m0_req, m0_wr, m0_address, m0_dout, m0_grant, a_interrupt, d_interrupt, m_din);
	
	always
		begin
		
		end
		
	initial
		begin
		
		end
	
endmodule 