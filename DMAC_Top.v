module DMAC_Top(clk, reset_n, m_grant, m_din, s_sel, s_wr, s_address, s_din, m_req, m_wr, m_address, m_dout, s_dout, s_interrupt);
	input clk, reset_n, m_grant;
	input[31:0] m_din;
	input s_sel, s_wr;
	input[15:0] s_address;
	input[31:0] s_din;
	output m_req;
	output m_wr;
	output[15:0] m_address;
	output[31:0] m_dout;
	output[31:0] s_dout;
	output s_interrupt;
	
	//
	wire m_end;
	wire m_begin;
	
	wire empty, full;
	wire wr_ack, wr_err, rd_ack, rd_err;
	wire[4:0] data_count;
	
	wire push_1, push_2, push_3;
	wire[31:0] d_in1, d_in2, d_in3;
	wire[31:0] d_out1, d_out2, d_out3;
	
	wire pop_1, pop_2, pop_3;
	wire[3:0] state;
	wire[31:0] m_din2;
	//
	
	parameter Waiting = 2'b00;
	parameter Executing = 2'b01;
	parameter Done = 2'b10;
	parameter Fault = 2'b11;
	//state encoding
	
	DMAC_slave DMAC_slave1(clk, reset_n, s_sel, s_wr, s_address, s_din, m_end, empty, full, wr_ack, wr_err, s_dout, s_interrupt, m_begin, push_1, push_2, push_3, d_in1, d_in2, d_in3);
	DMAC_fifo DMAC_fifo1(clk, reset_n, pop_1, push_1, d_in1, d_out1, full, empty, wr_ack, wr_err, rd_ack, rd_err, data_count); //fifo for source
	DMAC_fifo DMAC_fifo2(clk, reset_n, pop_2, push_2, d_in2, d_out2); //fifo for destination
	DMAC_fifo DMAC_fifo3(clk, reset_n, pop_3, push_3, d_in3, d_out3); //fifo for data_size
	DMAC_master DMAC_master(clk, reset_n, m_grant, m_din, m_begin, d_out1, d_out2, d_out3, empty, rd_ack, rd_err, full, m_req, m_wr, m_address, m_dout, m_end, pop_1, pop_2, pop_3, state, m_din2);
endmodule  