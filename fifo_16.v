module fifo_16 (clk, reset_n, rd_en, wr_en, d_in, d_out, full, empty, wr_ack, wr_err, rd_ack, rd_err, data_count);
	input clk, reset_n, rd_en, wr_en;
	input[31:0] d_in;
	output[31:0] d_out;
	output full, empty, wr_ack, wr_err, rd_ack, rd_err;
	output reg[4:0] data_count;
	
	wire we, re;
	wire[2:0] next_state;
	wire[3:0] next_head, next_tail;
	reg[2:0] state;
	reg[3:0] head, tail;
	wire[4:0] next_data_count;
	wire[31:0] rData, next_d_out;

	fifo_ns_16 fifo_ns_1 (wr_en, rd_en, state, data_count, next_state);
	fifo_cal_addr_16 fifo_cal_addr_1(next_state, head, tail, data_count, we, re, next_head, next_tail, next_data_count);
	//next state logic is contain 2 logics
	
	fifo_out_16 fifo_out_1(state, data_count, full, empty, wr_ack, wr_err, rd_ack, rd_err);
	//Register_file Register_file_1(clk, reset_n, tail[3:0], d_in, we, head[3:0], rData);
	ALU_registerfile Register_file_1(clk, reset_n, tail, d_in, we, head, d_out);
	//output logic is contain 2 logics
	
	mx2 mx2_1(32'b0000_0000_0000_0000_0000_0000_0000_0000, d_out, re, next_d_out); //mux for d_out
	
	always @ (posedge clk, negedge reset_n)
		begin
			if (reset_n == 1'b0) //reset has 1st priority (asynchronous)
				{state, data_count, head, tail} = 16'b000_00000_0000_0000;
			else //clock has 2nd priority
				{state, data_count, head, tail} = {next_state, next_data_count, next_head, next_tail};
		end
	//register logic
endmodule 