module DMAC_slave(clk, reset_n, s_sel, s_wr, s_address, s_din, m_end, empty, full, wr_ack, wr_err, s_dout, s_interrupt, m_begin, push_1, push_2, push_3, data_1, data_2, data_3);
	input clk, reset_n;
	input s_sel, s_wr;
	input[15:0] s_address;
	input[31:0] s_din;
	input m_end;
	
	input empty, full;
	input wr_ack, wr_err;
	
	output reg[31:0] s_dout;
	output reg s_interrupt;
	
	output reg m_begin;
	
	output reg push_1, push_2, push_3;
	output reg[31:0] data_1, data_2, data_3;

	reg[1:0] write_status;
	parameter before_write = 2'b00;
	parameter writting = 2'b01;
	parameter after_write = 2'b10;

	reg[31:0] OPERATION_START; //OPERATION_START
	reg[31:0] INTERRUPT; //INTERRUPT
	reg[31:0] INTERRUPT_ENABLE; //INTERRUPT_ENABLE
	reg[31:0] SOURCE_ADDRESS; //SOURCE_ADDRESS
	reg[31:0] DESTINATION_ADDRESS; //DESTINATION_ADDRESS
	reg[31:0] DATA_SIZE; //DATA_SIZE
	//reg[31:0] DESCRIPTOR_SIZE; //DESCRIPTOR_SIZE
	reg[31:0] DESCRIPTOR_PUSH; //DESCRIPTOR_PUSH
	reg[31:0] OPERATION_MODE; //OPERATION_MODE
	reg[31:0] DMA_STATUS; //DMA_STATUS
	parameter Waiting = 2'b00;
	parameter Executing = 2'b01;
	parameter Done = 2'b10;
	parameter Fault = 2'b11;

	always @ (posedge clk or negedge reset_n)
		begin
			if (reset_n == 1'b0)
				begin
					OPERATION_START = 32'h0000_0000; //OPERATION_START
					INTERRUPT = 32'h0000_0000; //INTERRUPT
					INTERRUPT_ENABLE = 32'h0000_0000; //INTERRUPT_ENABLE
					SOURCE_ADDRESS = 32'h0000_0000; //SOURCE_ADDRESS
					DESTINATION_ADDRESS = 32'h0000_0000; //DESTINATION_ADDRESS
					DATA_SIZE = 32'h0000_0000; //DATA_SIZE
					//DESCRIPTOR_SIZE = 32'h0000_0000; //DESCRIPTOR_SIZE
					DESCRIPTOR_PUSH = 32'h0000_0000; //DESCRIPTOR_PUSH
					OPERATION_MODE = 32'h0000_0000; //OPERATION_MODE
					DMA_STATUS = 32'h0000_0000; //DMA_STATUS
					s_dout = 32'h0000_0000;
					s_interrupt = 1'b0;
					m_begin = 1'b0;
					push_1 = 1'b0; push_2 = 1'b0; push_3 = 1'b0;
					data_1 = 32'h0000_0000; data_2 = 32'h0000_0000; data_3 = 32'h0000_0000;
					write_status = before_write;
				end
				
			else if (clk == 1'b1)
				begin
					if ({s_sel,s_wr} == 2'b11) //write
						begin
							case (s_address[7:0])
								(8'b0000_0000) : OPERATION_START = s_din;
								(8'b0000_0001) : INTERRUPT = s_din;
								(8'b0000_0010) : INTERRUPT_ENABLE = s_din;
								(8'b0000_0011) : SOURCE_ADDRESS = s_din;
								(8'b0000_0100) : DESTINATION_ADDRESS = s_din;
								(8'b0000_0101) : DATA_SIZE = s_din;
								(8'b0000_0110) : DESCRIPTOR_PUSH = s_din;
								(8'b0000_0111) : OPERATION_MODE = s_din;
								//(8'b0000_1000) : DMA_STATUS = s_din;//(DMA_STATUS) 1001 is read only
								default : ;
							endcase
						end
					else if ({s_sel,s_wr} == 2'b10) //read
						begin
							case (s_address[7:0])
								(8'b0000_0000) : s_dout = OPERATION_START;
								(8'b0000_0001) : s_dout = INTERRUPT;
								(8'b0000_0010) : s_dout = INTERRUPT_ENABLE;
								(8'b0000_0011) : s_dout = SOURCE_ADDRESS;
								(8'b0000_0100) : s_dout = DESTINATION_ADDRESS;
								(8'b0000_0101) : s_dout = DATA_SIZE;
								(8'b0000_0110) : s_dout = DESCRIPTOR_PUSH;
								(8'b0000_0111) : s_dout = OPERATION_MODE;
								(8'b0000_1000) : s_dout = DMA_STATUS;
								default : s_dout = 32'hxxxx_xxxx;
							endcase 
						end
					else if (s_sel == 1'b0)
						begin
							s_dout = 32'h0000_0000; //meaningless output
						end
					else
						begin
							s_dout = 32'hxxxx_xxxx; //error
						end
						
					if(OPERATION_START[0] == 1'b1) //check OPERATION_START
						begin
							if(empty == 1'b1) //fifo empty (error)
								begin
									DMA_STATUS[1:0] = 2'b11;
								end
							else if(empty == 1'b0)
								begin
									m_begin = 1'b1; //send begin signal to master
									DMA_STATUS[1:0] = 2'b01; //master is Executing
								end
							else //when fifo is error
								begin
									DMA_STATUS[1:0] = 2'bxx;
								end
						end
						
					if(INTERRUPT_ENABLE[0] == 1'b1) //check INTERRUPT_ENABLE
						begin
							if(INTERRUPT[0] == 1'b1)
								begin
									s_interrupt = 1'b1; //interrupt and abled
								end
							else if(INTERRUPT[0] == 1'b0) //check INTERRUPT
								begin
									s_interrupt = 1'b0;
									OPERATION_START[0] = 1'b0;
								end 
						end	
					else if(INTERRUPT_ENABLE[0] == 1'b0)
						begin
							if(INTERRUPT[0] == 1'b1)
								begin
									s_interrupt = 1'b0; //interrupt but disabled
								end
							else if(INTERRUPT[0] == 1'b0) //check INTERRUPT
								begin
									s_interrupt = 1'b0;
									OPERATION_START[0] = 1'b0;
								end 
						end
					else //When INTERRUPT_ENABLE is error
						begin
							s_interrupt = 1'bx;
						end
					
					if(DESCRIPTOR_PUSH[0] == 1'b0) //check DESCRIPTOR_PUSH
						begin
							push_1 = 1'b0;
							data_1 = 32'h0000_0000;
							push_2 = 1'b0;
							data_2 = 32'h0000_0000;
							push_3 = 1'b0;
							data_3 = 32'h0000_0000;
							DESCRIPTOR_PUSH[0] = 1'b0;
							write_status = before_write; //not write to fifo
						end 
					else if(DESCRIPTOR_PUSH[0] == 1'b1) //push to fifo
						begin
							if(full == 1'b1) //fifo full (error)
								begin
									DMA_STATUS[1:0] = 2'b11;
								end
							else if(full == 1'b0) //fifo not full
								begin
									push_1 = 1'b1;
									data_1 = SOURCE_ADDRESS;
									push_2 = 1'b1;
									data_2 = DESTINATION_ADDRESS;
									push_3 = 1'b1;
									data_3 = DATA_SIZE;
									DESCRIPTOR_PUSH[0] = 1'b0;
									write_status = writting; //now writing to fifo
								end
							else //when fifo is error
								begin
									DMA_STATUS[1:0] = 2'bxx;
								end
						end
					else //when DESCRIPTOR_PUSH is error
						begin
							push_1 = 1'bx;
							data_1 = 32'hxxxx_xxxx;
							push_2 = 1'bx;
							data_2 = 32'hxxxx_xxxx;
							push_3 = 1'bx;
							data_3 = 32'hxxxx_xxxx;
							DESCRIPTOR_PUSH[0] = 1'bx;
						end
						
					if(write_status == writting) //when write to fifo
						begin
							if(wr_ack == 1'b1)
							write_status = before_write; //write to fifo is done
						end
							
					if({m_end, DMA_STATUS[1:0]} == 3'b1_01) //when receive end signal from master
						begin
							m_begin = 1'b0;
							INTERRUPT[0] = 1'b1;
							OPERATION_START[0] = 1'b0;
							DMA_STATUS[1:0] = 2'b10; //master is Done
						end	
				end
		end
endmodule 