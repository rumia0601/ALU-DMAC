module DMAC_master(clk, reset_n, m_grant, m_din, m_begin, data1, data2, data3, empty, rd_ack, rd_err, full, m_req, m_wr, m_address, m_dout, m_end, pop_1, pop_2, pop_3, state, m_din2);
	input clk, reset_n;
	input m_grant;
	input[31:0] m_din;
	
	input m_begin;
	input[31:0] data1, data2, data3;
	input empty, full;
	input rd_ack, rd_err;
	
	output reg m_req, m_wr;
	output reg [31:0] m_address;
	output reg [31:0] m_dout;
	
	output reg m_end;
	output reg pop_1, pop_2, pop_3;
	
	output[31:0] m_din2;
	assign m_din2 = m_din;
	
	output reg[3:0] state; //
	parameter none = 4'b0000;
	parameter receive_begin = 4'b0001; //read start
	parameter receiving_fifo = 4'b0010;
	parameter receiving_bus = 4'b0011;
	parameter receive_end = 4'b0100; //read end
	parameter send_begin = 4'b0101; //write start
	parameter sending = 4'b0110;
	parameter send_end = 4'b0111; //write end
	parameter done = 4'b1000;
	//states encoding
	
	reg[31:0] temp_data;
	reg[15:0] temp_address;
	
	always @ (posedge clk or negedge reset_n)
		begin
			if (reset_n == 1'b0) //-> none
				begin
					m_req = 1'b0;
					m_wr = 1'b0;
					state = none;
					m_address = 16'h0000;
					m_dout = 32'h0000_0000;
					m_end = 1'b0;
					pop_1 = 1'b0; pop_2 = 1'b0; pop_3 = 1'b0;
					temp_data = 32'h0000_0000; temp_address = 16'h0000;
				end
			else if (clk == 1'b1)
				begin
					if ({state, m_begin} == {none, 1'b0}) //when master not receive begin signal
						begin
							state = none; //none -> none
						end
					else if ({state, m_begin} == {none, 1'b1}) //when master receive begin signal
						begin
							state = receive_begin; //none -> receive_begin
						end
						
					else if (state == receive_begin)
						begin //pop from fifo
							pop_1 = 1'b1; pop_2 = 1'b1; pop_3 = 1'b1;
							state = receiving_fifo;
						end
						
					else if (state == receiving_fifo)
						begin
							pop_1 = 1'b0;
							pop_2 = 1'b0;
							pop_3 = 1'b0;
						
							if (rd_ack == 1'b1) //when fifo is done
								begin
									m_address = data1[15:0]; 
									temp_address = data2[15:0];
									m_req = 1'b1;
									m_wr = 1'b0;
									state = receiving_bus; //receiving_fifo -> receiving_bus
								end
							else if (rd_ack == 1'b0) //fifo is not finished but working...
								;
						end
						
					else if (state == receiving_bus) 
						begin
							if (m_grant == 1'b1) //when bus is done
								begin
									m_req = 1'b0;
									state = receive_end; //receiving_bus -> receive_end
								end
							else if (m_grant == 1'b0) //bus is not finished but working...
									m_req = 1'b0;
						end 
						
					else if (state == receive_end) 
						begin
							temp_data = m_din;
							state = send_begin; //receive_end -> send_begin
						end 
						
					else if (state == send_begin)
						begin
							m_req = 1'b1;
							m_wr = 1'b1;
							m_dout = temp_data;
							m_address = temp_address;
							state = sending; //send_begin -> sending
						end
						
					else if (state == sending)
						begin
							if (m_grant == 1'b1) //when bus is done
								begin
									m_req = 1'b0;
									m_wr = 1'b0;
									state = send_end; //sending -> send_end
								end
							else if (m_grant == 1'b0) //bus is not finished but working...
								;
						end
						
					else if (state == send_end)
						begin
							if (empty == 1'b0)
								begin
									m_end = 1'b0;
									state = receive_begin; //send_end -> receive_begin
								end 
							else if (empty == 1'b1)
								begin
									m_end = 1'b1;
									state = done; //send_end -> done
								end 
						end
					
					else if (state == done) //do nothing when master is done
						begin
							m_end = 1'b0;
							state = none;
						end
				end 
		end
endmodule 