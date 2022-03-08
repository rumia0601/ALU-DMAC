module DMAC_fifo(clk, reset_n, rd_en, wr_en, d_in, d_out, full, empty, wr_ack, wr_err, rd_ack, rd_err, data_count); //16 fifo
	input clk, reset_n, rd_en, wr_en;
	input[31:0] d_in;
	output[31:0] d_out;
	output full, empty, wr_ack, wr_err, rd_ack, rd_err;
	//output[3:0] data_count;
	output[4:0] data_count;
	
	//wire rd_en1, rd_en2;
	//wire wr_en1, wr_en2;
	
	//reg rd_en_1, rd_en_2;
	//reg wr_en_1, wr_en_2;
	//wire[31:0] d_out_1, d_out_2;
	//wire full_1, full_2, empty_1, empty_2, wr_ack_1, wr_ack_2, wr_err_1, wr_err_2, rd_ack_1, rd_ack_2, rd_err_1, rd_err_2;
	//wire[3:0] data_count_1, data_count_2;
	
	//reg state;
	//if state == 0, fifo is not finished
	//if state == 1, fifo is finished
	
	//assign rd_en1 = rd_en_1;
	//assign rd_en2 = rd_en_2;
	//assign wr_en1 = wr_en_1;
	//assign wr_en2 = wr_en_2;
	
	//wire w_full, w_empty, w_wr_ack, w_wr_err, w_rd_ack, w_rd_err;
	//wire[4:0] w_data_count;
	//wire[31:0] w_d_out;
	
	//fifo fifo_1 (clk, reset_n, rd_en, wr_en, d_in, w_d_out, w_full, w_empty, w_wr_ack, w_wr_err, w_rd_ack, w_rd_err, w_data_count);
	fifo_16 fifo_16_1(clk, reset_n, rd_en, wr_en, d_in, d_out, full, empty, wr_ack, wr_err, rd_ack, rd_err, data_count);
	
	//assign full = w_full;
	//assign empty = w_empty;
	//assign wr_ack = w_wr_ack;
	//assign wr_err = w_wr_err;
	//assign rd_ack = w_rd_ack;
	//assign rd_err = w_rd_err;
	//assign data_count = w_data_count;
	//assign d_out = w_d_out;
	
	/*
	
	fifo fifo_1 (clk, reset_n, rd_en1, wr_en1, d_in, d_out_1, full_1, empty_1, wr_ack_1, wr_err_1, rd_ack_1, rd_err_1, data_count_1); //0 to 8
	fifo fifo_2 (clk, reset_n, rd_en2, wr_en2, d_in, d_out_2, full_2, empty_2, wr_ack_2, wr_err_2, rd_ack_2, rd_err_2, data_count_2); //9 to 16
	
	always @ (posedge clk or negedge reset_n)
		begin	//0 - 7 only on fifo_1, 8 both on fifo_1 and fifo_2, 9 - 16 only on fifo_2		
			if (reset_n == 1'b0)
				begin
					data_count = 8'b0000_0000;
					state = 1'b0;
					rd_en_1 = 1'b0; rd_en_2 = 1'b0;
					wr_en_1 = 1'b0; wr_en_2 = 1'b0;
				end
				
			//state = 0 means before fifo will working
			//state = 1 means after fifo worked
			
			if (clk == 1'b1)
				begin 
				if (wr_ack_1 == 1'b1)
					state = 1'b1;
				else if (rd_ack_1 == 1'b1)
					state = 1'b1;
				else if (wr_ack_2 == 1'b1)
					state = 1'b1;
				else if (rd_ack_2 == 1'b1)
					state = 1'b1;
			
				if ({state, data_count} == 9'b0_0000_0000) //0
				begin
					{rd_en_1, wr_en_1} = {rd_en, wr_en};
					{rd_en_2, wr_en_2} = {1'b0, 1'b0};
				end
				else if ({state, data_count} == 9'b1_0000_0000) //0
				begin
					d_out = d_out_1;
					{full, empty, wr_ack, wr_err, rd_ack, rd_err} = {full_2, empty_1, wr_ack_1, wr_err_1, rd_ack_1, rd_err_1};
					data_count = {data_count_1, data_count_2}; //0000_0000 to 1000_1000
					state = 1'b0;
				end
			
				else if ({state, data_count} == 9'b0_0001_0000) //1
				begin
					{rd_en_1, wr_en_1} = {rd_en, wr_en};
					{rd_en_2, wr_en_2} = {1'b0, 1'b0};
				end
				else if ({state, data_count} == 9'b1_0001_0000) //1
				begin
					d_out = d_out_1;
					{full, empty, wr_ack, wr_err, rd_ack, rd_err} = {full_2, empty_1, wr_ack_1, wr_err_1, rd_ack_1, rd_err_1};
					data_count = {data_count_1, data_count_2}; //0000_0000 to 1000_1000
					state = 1'b0;
				end
				
				else if ({state, data_count} == 9'b0_0010_0000) //2
				begin
					{rd_en_1, wr_en_1} = {rd_en, wr_en};
					{rd_en_2, wr_en_2} = {1'b0, 1'b0};
				end
				else if ({state, data_count} == 9'b1_0010_0000) //2
				begin
					d_out = d_out_1;
					{full, empty, wr_ack, wr_err, rd_ack, rd_err} = {full_2, empty_1, wr_ack_1, wr_err_1, rd_ack_1, rd_err_1};
					data_count = {data_count_1, data_count_2}; //0000_0000 to 1000_1000
					state = 1'b0;
				end 
				
				else if ({state, data_count} == 9'b0_0011_0000) //3
				begin
					{rd_en_1, wr_en_1} = {rd_en, wr_en};
					{rd_en_2, wr_en_2} = {1'b0, 1'b0};
				end
				else if ({state, data_count} == 9'b1_0011_0000) //3
				begin
					d_out = d_out_1;
					{full, empty, wr_ack, wr_err, rd_ack, rd_err} = {full_2, empty_1, wr_ack_1, wr_err_1, rd_ack_1, rd_err_1};
					data_count = {data_count_1, data_count_2}; //0000_0000 to 1000_1000
					state = 1'b0;
				end 
				
				else if ({state, data_count} == 9'b0_0100_0000) //4
				begin
					{rd_en_1, wr_en_1} = {rd_en, wr_en};
					{rd_en_2, wr_en_2} = {1'b0, 1'b0};
				end
				else if ({state, data_count} == 9'b1_0100_0000) //4
				begin
					d_out = d_out_1;
					{full, empty, wr_ack, wr_err, rd_ack, rd_err} = {full_2, empty_1, wr_ack_1, wr_err_1, rd_ack_1, rd_err_1};
					data_count = {data_count_1, data_count_2}; //0000_0000 to 1000_1000
					state = 1'b0;
				end 
				
				else if ({state, data_count} == 9'b0_0101_0000) //5
				begin
					{rd_en_1, wr_en_1} = {rd_en, wr_en};
					{rd_en_2, wr_en_2} = {1'b0, 1'b0};
				end
				else if ({state, data_count} == 9'b1_0101_0000) //5
				begin
					d_out = d_out_1;
					{full, empty, wr_ack, wr_err, rd_ack, rd_err} = {full_2, empty_1, wr_ack_1, wr_err_1, rd_ack_1, rd_err_1};
					data_count = {data_count_1, data_count_2}; //0000_0000 to 1000_1000
					state = 1'b0;
				end 
				
				else if ({state, data_count} == 9'b0_0110_0000) //6
				begin
					{rd_en_1, wr_en_1} = {rd_en, wr_en};
					{rd_en_2, wr_en_2} = {1'b0, 1'b0};
				end
				else if ({state, data_count} == 9'b1_0110_0000) //6
				begin
					d_out = d_out_1;
					{full, empty, wr_ack, wr_err, rd_ack, rd_err} = {full_2, empty_1, wr_ack_1, wr_err_1, rd_ack_1, rd_err_1};
					data_count = {data_count_1, data_count_2}; //0000_0000 to 1000_1000
					state = 1'b0;
				end
			
				else if ({state, data_count} == 9'b0_0111_0000) //7
				begin
					{rd_en_1, wr_en_1} = {rd_en, wr_en};
					{rd_en_2, wr_en_2} = {1'b0, 1'b0};
				end
				else if ({state, data_count} == 9'b1_0111_0000) //7
				begin
					d_out = d_out_1;
					{full, empty, wr_ack, wr_err, rd_ack, rd_err} = {full_2, empty_1, wr_ack_1, wr_err_1, rd_ack_1, rd_err_1};
					data_count = {data_count_1, data_count_2}; //0000_0000 to 1000_1000
					state = 1'b0;
				end 	
				
				else if ({state, data_count} == 9'b0_1000_0000) //8
				begin
					{rd_en_1, wr_en_1} = {rd_en, 1'b0};
					{rd_en_2, wr_en_2} = {1'b0, wr_en};
				end
				else if ({state, data_count} == 9'b1_1000_0000) //8
				begin
					d_out = d_out_1;
					{full, empty, wr_ack, wr_err, rd_ack, rd_err} = {full_2, empty_1, wr_ack_2, wr_err_2, rd_ack_1, rd_err_1};
					data_count = {data_count_1, data_count_2}; //0000_0000 to 1000_1000
					state = 1'b0;
				end 
				
				else if ({state, data_count} == 9'b0_1000_0001) //9
				begin
					{rd_en_1, wr_en_1} = {1'b0, 1'b0};
					{rd_en_2, wr_en_2} = {rd_en, wr_en};
				end
				else if ({state, data_count} == 9'b1_1000_0001) //9
				begin
					d_out = d_out_2;
					{full, empty, wr_ack, wr_err, rd_ack, rd_err} = {full_2, empty_1, wr_ack_2, wr_err_2, rd_ack_2, rd_err_2};
					data_count = {data_count_1, data_count_2}; //0000_0000 to 1000_1000
					state = 1'b0;
				end
				
				else if ({state, data_count} == 9'b0_1000_0010) //10
				begin
					{rd_en_1, wr_en_1} = {1'b0, 1'b0};
					{rd_en_2, wr_en_2} = {rd_en, wr_en};
				end
				else if ({state, data_count} == 9'b1_1000_0010) //10
				begin
					d_out = d_out_2;
					{full, empty, wr_ack, wr_err, rd_ack, rd_err} = {full_2, empty_1, wr_ack_2, wr_err_2, rd_ack_2, rd_err_2};
					data_count = {data_count_1, data_count_2}; //0000_0000 to 1000_1000
					state = 1'b0;
				end
				
				else if ({state, data_count} == 9'b0_1000_0011) //11
				begin
					{rd_en_1, wr_en_1} = {1'b0, 1'b0};
					{rd_en_2, wr_en_2} = {rd_en, wr_en};
				end
				else if ({state, data_count} == 9'b1_1000_0011) //11
				begin
					d_out = d_out_2;
					{full, empty, wr_ack, wr_err, rd_ack, rd_err} = {full_2, empty_1, wr_ack_2, wr_err_2, rd_ack_2, rd_err_2};
					data_count = {data_count_1, data_count_2}; //0000_0000 to 1000_1000
					state = 1'b0;
				end
				
				else if ({state, data_count} == 9'b0_1000_0100) //12
				begin
					{rd_en_1, wr_en_1} = {1'b0, 1'b0};
					{rd_en_2, wr_en_2} = {rd_en, wr_en};
				end
				else if ({state, data_count} == 9'b1_1000_0100) //12
				begin
					d_out = d_out_2;
					{full, empty, wr_ack, wr_err, rd_ack, rd_err} = {full_2, empty_1, wr_ack_2, wr_err_2, rd_ack_2, rd_err_2};
					data_count = {data_count_1, data_count_2}; //0000_0000 to 1000_1000
					state = 1'b0;
				end
				
				else if ({state, data_count} == 9'b0_1000_0101) //13
				begin
					{rd_en_1, wr_en_1} = {1'b0, 1'b0};
					{rd_en_2, wr_en_2} = {rd_en, wr_en};
				end
				else if ({state, data_count} == 9'b1_1000_0101) //13
				begin
					d_out = d_out_2;
					{full, empty, wr_ack, wr_err, rd_ack, rd_err} = {full_2, empty_1, wr_ack_2, wr_err_2, rd_ack_2, rd_err_2};
					data_count = {data_count_1, data_count_2}; //0000_0000 to 1000_1000
					state = 1'b0;
				end
				
				else if ({state, data_count} == 9'b0_1000_0110) //14
				begin
					{rd_en_1, wr_en_1} = {1'b0, 1'b0};
					{rd_en_2, wr_en_2} = {rd_en, wr_en};
				end
				else if ({state, data_count} == 9'b1_1000_0110) //14
				begin
					d_out = d_out_2;
					{full, empty, wr_ack, wr_err, rd_ack, rd_err} = {full_2, empty_1, wr_ack_2, wr_err_2, rd_ack_2, rd_err_2};
					data_count = {data_count_1, data_count_2}; //0000_0000 to 1000_1000
					state = 1'b0;
				end
				
				else if ({state, data_count} == 9'b0_1000_0111) //15
				begin
					{rd_en_1, wr_en_1} = {1'b0, 1'b0};
					{rd_en_2, wr_en_2} = {rd_en, wr_en};
				end
				else if ({state, data_count} == 9'b1_1000_0111) //15
				begin
					d_out = d_out_2;
					{full, empty, wr_ack, wr_err, rd_ack, rd_err} = {full_2, empty_1, wr_ack_2, wr_err_2, rd_ack_2, rd_err_2};
					data_count = {data_count_1, data_count_2}; //0000_0000 to 1000_1000
					state = 1'b0;
				end
				
				else if ({state, data_count} == 9'b0_1000_1000) //16
				begin
					{rd_en_1, wr_en_1} = {1'b0, 1'b0};
					{rd_en_2, wr_en_2} = {rd_en, wr_en};
				end
				else if ({state, data_count} == 9'b1_1000_1000) //16
				begin
					d_out = d_out_2;
					{full, empty, wr_ack, wr_err, rd_ack, rd_err} = {full_2, empty_1, wr_ack_2, wr_err_2, rd_ack_2, rd_err_2};
					data_count = {data_count_1, data_count_2}; //0000_0000 to 1000_1000
					state = 1'b0;
				end
			end
		end
		*/
endmodule 
