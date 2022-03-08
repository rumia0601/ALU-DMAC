module Top(clk, reset_n, m0_req, m0_wr, m0_address, m0_dout, m0_grant, a_interrupt, d_interrupt, m_din);
	input clk, reset_n, m0_req, m0_wr;
	input[15:0] m0_address;
	input[31:0] m0_dout;
	output m0_grant, a_interrupt, d_interrupt;
	output[31:0] m_din;
	
	wire s1_sel;
	wire[31:0] s1_dout;
	
	wire m1_grant;
	wire s0_sel;
	wire m1_req, m1_wr;
	wire[15:0] m1_address;
	wire[31:0] m1_dout, s0_dout;
	
	wire s2_sel, s_wr;
	wire[31:0] s_address;
	wire[31:0] s_din;
	wire[31:0] s2_dout;
	
	wire s3_sel;
	wire[31:0] s3_dout;
	
	wire s4_sel;
	wire[31:0] s4_dout;
	
	ALU_Top ALU1(.clk(clk), .reset_n(reset_n), .s_sel(s1_sel), .s_wr(s_wr), .s_addr(s_address), .s_din(s_din), .s_dout(s1_dout), .s_interrupt(a_interrupt));
	//	1 1 1 1 16 32 32 1
	DMAC_Top DMAC1(.clk(clk), .reset_n(reset_n), .m_grant(m1_grant), .m_din(m_din), .s_sel(s0_sel), .s_wr(s_wr), .s_address(s_address), .s_din(s_din), .m_req(m1_req), .m_wr(m1_wr), .m_address(m1_address), .m_dout(m1_dout), .s_dout(s0_dout), .s_interrupt(d_interrupt));
	// 1 1 1 32 1 1 16 32 1 1 16 32 32 1
	ram RAM1(clk, s2_sel, s_wr, s_address, s_din, s2_dout);
	// 1 1 1 16 32 32
	ram RAM2(clk, s3_sel, s_wr, s_address, s_din, s3_dout);
	// 1 1 1 16 32 32
	ram RAM3(clk, s4_sel, s_wr, s_address, s_din, s4_dout);
	// 1 1 1 16 32 32
	BUS BUS1(clk, reset_n, m0_req, m0_wr, m0_address, m0_dout, m1_req, m1_wr, m1_address, m1_dout, s0_dout, s1_dout, s2_dout, s3_dout, s4_dout, m0_grant, m1_grant, m_din, s0_sel, s1_sel, s2_sel, s3_sel, s4_sel, s_address, s_wr, s_din);
	// 1 1 1 1 16 32 1 1 16 32 32 32 32 32 32 1 1 32 1 1 1 1 1 16 1 32
endmodule 