module fifo (clk, reset_n, rd_en, wr_en, d_in, d_out, full, empty, wr_ack, wr_err, rd_ack, rd_err, data_count);
	input clk, reset_n, rd_en, wr_en;
	input[31:0] d_in;
	output reg[31:0] d_out;
	output full, empty, wr_ack, wr_err, rd_ack, rd_err;
	output[3:0] data_count;
	
	wire we, re;
	wire[2:0] next_state, next_head, next_tail;
	reg[2:0] state, head, tail;
	wire[3:0] next_data_count;
	reg[3:0] data_count;
	wire[31:0] rData, next_d_out;

	fifo_ns fifo_ns_1 (wr_en, rd_en, state, data_count, next_state);
	fifo_cal_addr fifo_cal_addr_1(next_state, head, tail, data_count, we, re, next_head, next_tail, next_data_count);
	//next state logic is contain 2 logics
	
	fifo_out fifo_out_1(state, data_count, full, empty, wr_ack, wr_err, rd_ack, rd_err);
	Register_file Register_file_1(clk, reset_n, tail, d_in, we, head, rData);
	//output logic is contain 2 logics
	
	mx2 mx2_1(32'b0000_0000_0000_0000_0000_0000_0000_0000, rData, re, next_d_out); //mux for d_out
	
	always @ (posedge clk, negedge reset_n)
		begin
			if (reset_n == 1'b0) //reset has 1st priority (asynchronous)
				{state, data_count, head, tail, d_out} = 45'b000_0000_000_000_0000_0000_0000_0000_0000_0000_0000_0000;
			else //clock has 2nd priority
				{state, data_count, head, tail, d_out} = {next_state, next_data_count, next_head, next_tail, next_d_out};
		end
	//register logic
endmodule 