module BUS(clk, reset_n, m0_req, m0_wr, m0_addr, m0_dout, m1_req, m1_wr, m1_addr, m1_dout, s0_dout, s1_dout, s2_dout, s3_dout, s4_dout, m0_grant, m1_grant, m_din, s0_sel, s1_sel, s2_sel, s3_sel, s4_sel, s_addr, s_wr, s_din);
	input clk, reset_n, m0_req, m0_wr;
	input[15:0] m0_addr;
	input[31:0] m0_dout;
	input m1_req, m1_wr;
	input[15:0] m1_addr;
	input[31:0] m1_dout, s0_dout, s1_dout, s2_dout, s3_dout, s4_dout;
	output m0_grant, m1_grant;
	output[31:0] m_din;
	output s0_sel, s1_sel, s2_sel, s3_sel, s4_sel;
	output[15:0] s_addr;
	output s_wr;
	output[31:0] s_din;
	
	wire[2:0] d, q;
	
	bus_arbiter bus_arbiter_1(clk, reset_n, m0_req, m1_req, m0_grant, m1_grant);
	mux2_1bit mux2_1(m0_wr, m1_wr, m1_grant, s_wr); //wr = granted master's wr
	mux2_16bit mux2_2(m0_addr, m1_addr, m1_grant, s_addr); //address = granted master's address
	mux2_32bit mux2_3(m0_dout, m1_dout, m1_grant, s_din); //din = granted master's dout
	bus_addressdecoder bus_addressdecoder_1(s_addr, {s0_sel, s1_sel, s2_sel, s3_sel, s4_sel});
	//master to slave
	
	bus_seltosel bus_seltosel_1({s0_sel, s1_sel, s2_sel, s3_sel, s4_sel}, d);
	dff_3bit dff_1(clk, reset_n, d, q);
	mux6_32bit mux6_1(32'h0000_0000, s0_dout, s1_dout, s2_dout, s3_dout, s4_dout, q, m_din); //granted master's din = dout 
	//slave to master
	
endmodule 