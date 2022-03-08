module ALU_alu_top(clk, reset_n, alu_begin, o_empty, o_rd_err, o_rd_ack, o_dout, r_full, r_wr_err, r_wr_ack, rData, o_pop, r_push, alu_done, re, rAddr, wData, state, operand1, operand2, result2, result1, state);
	input clk, reset_n;
	input alu_begin;
	input o_empty, o_rd_err, o_rd_ack;
	input[31:0] o_dout;
	input r_full, r_wr_err, r_wr_ack;
	input[31:0] rData;
	
	output reg o_pop;
	output reg alu_done;
	output reg re;
	output reg[3:0] rAddr;
	output reg r_push;
	output reg[31:0] wData;

	output reg[4:0] state;
	reg[31:0] instruction;
	output reg[31:0] operand1, operand2;
	output reg[31:0] result2, result1;
	
	reg[3:0] code;
	reg[3:0] addr1, addr2;
	reg[1:0] shift; //datas from the instruction
	
	wire[3:0] w_code;
	wire[1:0] w_shift;
	reg op_start, op_clear;
	wire[31:0] w_operand1, w_operand2;
	wire[31:0] w_result2, w_result1;
	wire op_done; 
	//wire for ALU_alu
	
	parameter error = 5'b00000;
	parameter none = 5'b00001;
	parameter before_instruction = 5'b00010;
	parameter instructing = 5'b00011;
	parameter after_instruction = 5'b00100;
	parameter before_operand = 5'b00101;
	parameter operanding1 = 5'b00110;
	parameter operanding2 = 5'b00111;
	parameter operanding3 = 5'b01000;
	parameter after_operand = 5'b01001;
	parameter before_operate = 5'b01010;
	parameter operating = 5'b01011;
	parameter after_operate = 5'b01100;
	parameter before_result = 5'b01101;
	parameter resulting1 = 5'b01110;
	parameter resulting2 = 5'b01111;
	parameter after_result = 5'b10000;
	parameter done = 5'b10001;
	//states encoding (before_x -> xing -> after_x)
	
	assign w_code = code;
	assign w_shift = shift;
	assign w_operand1 = operand1;
	assign w_operand2 = operand2;
	ALU_alu ALU_alu1(clk, reset_n, w_code, w_shift, w_operand1, w_operand2, op_start, op_clear, w_result2, w_result1, op_done); //calculating result part	
	
	always @ (posedge clk or negedge reset_n)
		begin
			if (reset_n == 1'b0)
				begin
					o_pop = 1'b0;
					alu_done = 1'b0;
					re = 1'b0;
					rAddr = 4'b0000;
					r_push = 1'b0;
					wData = 32'h0000_0000;
					state = 4'b0000;
				
					instruction = 32'h0000_0000;
					operand1 = 32'h0000_0000;
					operand2 = 32'h0000_0000;
					result2 = 32'h0000_0000;
					result1 = 32'h0000_0000;
					
					code = 4'b0000;
					addr1 = 4'b0000;
					addr2 = 4'b0000;
					shift = 2'b00;
					
					op_start = 1'b0;
					op_clear = 1'b0;
					
					state = none; // -> none
				end
		
			else if (clk == 1'b1)
				begin
					if({state, alu_begin} == {none, 1'b1})
						begin
							if(o_empty == 1'b1) //when there is no instruction
								begin
									state = error;
								end
							else if(r_full == 1'b1) //when there is no empty space for result
								begin
									state = error;
								end
							else if({o_empty, r_full} == 2'b00)
								begin
									state = before_instruction; //none -> before_instruction //
									//state = before_instruction;
								end
							else //keeps none
								;
						end
						
					else if(state == before_instruction)
						begin
							o_pop = 1'b1;
							state = instructing; //before_instruction -> instructing
						end
					
					else if(state == instructing)
						begin
							if(o_rd_err == 1'b1)
								begin
									o_pop = 1'b0;
									state = error; //instructing -> error
								end
					
							else if(o_rd_ack == 1'b1)
								begin
									o_pop = 1'b0;
									instruction = o_dout;
									state = after_instruction; //instructing -> after_instruction
								end
							else
								o_pop = 1'b0; //instruction fifo is working...			
						end
						
					else if(state == after_instruction)
						begin
							code = instruction[13:10];
							addr1 = instruction[9:6];
							addr2 = instruction[5:2];
							shift = instruction[1:0]; //get 4 data from instruction
							state = before_operand; //after_instruction -> before_operand
							
							if(code == 4'b0000) //when NOP
								begin
									state = before_instruction; //after_instruction -> before_instruction
								end
						end
						
					else if(state == before_operand)
						begin
							re = 1'b1; //read
							rAddr = addr1;
							op_start = 1'b0;
							op_clear = 1'b1;
							state = operanding1; //before_operand -> operanding
						end 
						
					else if(state == operanding1)
						begin
							state = operanding2; //operanding...
						end
						
					else if(state == operanding2)
						begin
							operand1 = rData; //get first operand
							rAddr = addr2;
							state = operanding3; //operanding...
						end
						
					else if(state == operanding3)
						begin
							state = after_operand; //operanding...
						end
						
					else if(state == after_operand)
						begin
							operand2 = rData; //get second operand
							state = before_operate; //after_operand -> before_operate
						end
						
					else if(state == before_operate)
						begin
							op_clear = 1'b0;
							op_start = 1'b1;
							state = operating; //before_operate -> operating
						end
						
					else if(state == operating)
						begin
							if(op_done == 1'b1)
								begin
									op_start = 1'b0;
									result2 = w_result2;
									result1 = w_result1; //get two result
									state = after_operate; //operating -> after_operate
								end
								
							else if(op_done == 1'b0)
								op_start = 1'b0; //ALU is working...
								
							else //error
								;
						end
						
					else if(state == after_operate)
						begin
							state = before_result; //after_operate -> before_result
						end
					
					else if(state == before_result)
						begin
							wData = result2; //1. store upper bit
							r_push = 1'b1;
							state = resulting1; //before_result -> resulting1
						end
						
					else if(state == resulting1)
						begin
							if(r_wr_err == 1'b1)
								begin
									wData = 32'h0000_0000;
									r_push = 1'b0;
									state = error; //resulting -> error
								end
					
							else if(r_wr_ack == 1'b1)
								begin
									wData = result1;
									r_push = 1'b1; //2. store lower bit
									state = resulting2; //instructing -> resulting2
								end
							else
								r_push = 1'b0; //result fifo is working...
						end
						
					else if(state == resulting2)
						begin
							if(r_wr_err == 1'b1)
								begin
									wData = 32'h0000_0000;
									r_push = 1'b0;
									state = error; //resulting -> error
								end
					
							else if(r_wr_ack == 1'b1)
								begin
									wData = 32'h0000_0000;
									r_push = 1'b0;
									state = after_result; //resulting2 -> after_result
								end
							else
								r_push = 1'b0; //result fifo is working...
						end	
						
					else if(state == after_result)
						begin
							if(o_empty == 1'b1)
								begin
									alu_done = 1'b1; //send done signal
									state = done; //after_result -> done
								end
								
							else if(o_empty == 1'b0)
								begin
									state = before_instruction; //after_result -> before_instruction
								end
						end
						
					else if(state == done) //do nothing when it is done
						begin
							alu_done = 1'b0;
							state = none;
						end
				end
		end 
endmodule 
