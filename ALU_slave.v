module ALU_slave(clk, reset_n, s_sel, s_wr, s_addr, s_din, o_wr_ack, o_wr_err, r_rd_ack, r_rd_err, r_dout, instruction_empty, alu_done, o_din, o_push, r_pop, we, wAddr, wData, s_dout, s_interrupt, alu_begin, operand_state, instruction_state, need_pop, RESULT);
	input clk, reset_n, s_sel, s_wr;
	input[15:0] s_addr;
	input[31:0] s_din;
	
	input o_wr_ack, o_wr_err;
	
	input r_rd_ack, r_rd_err;
	input[31:0] r_dout;
	
	input instruction_empty;
	input alu_done;
	
	output reg[31:0] o_din;
	output reg o_push; //output for instruction fifo
	
	output reg we;
	output reg[3:0] wAddr;
	output reg[31:0] wData; //output for register file
	
	output reg r_pop; //output for result fifo
	
	output reg[31:0] s_dout;
	output reg s_interrupt;
	
	output reg alu_begin;

	reg[31:0] OPERATION_START;
	reg[31:0] INTERRUPT;
	reg[31:0] INTERRUPT_ENABLE;
	reg[31:0] INSTRUCTION;
	output reg[31:0] RESULT; //
	reg[31:0] ALU_STATUS;
	reg[31:0] OPERAND_00;
	reg[31:0] OPERAND_01;
	reg[31:0] OPERAND_02;
	reg[31:0] OPERAND_03;
	reg[31:0] OPERAND_04;
	reg[31:0] OPERAND_05;
	reg[31:0] OPERAND_06;
	reg[31:0] OPERAND_07;
	reg[31:0] OPERAND_08;
	reg[31:0] OPERAND_09;
	reg[31:0] OPERAND_10;
	reg[31:0] OPERAND_11;
	reg[31:0] OPERAND_12;
	reg[31:0] OPERAND_13;
	reg[31:0] OPERAND_14;
	reg[31:0] OPERAND_15;
	
	parameter Waiting = 2'b00;
	parameter Executing = 2'b01;
	parameter Done = 2'b10;
	parameter Fault = 2'b11;
	
	output reg operand_state;
	parameter before_operand = 1'b0;
	parameter after_operand = 1'b1; //state for register file
	
	output reg instruction_state;
	parameter before_instruction = 1'b0;
	parameter after_instruction = 1'b1; //state for instruction fifo
	
	output reg need_pop;
	
	always @ (posedge clk or negedge reset_n)
		begin
			if (reset_n == 1'b0) //reset
				begin
					OPERATION_START = 32'h0000_0000; //OPERATION_START
					INTERRUPT = 32'h0000_0000; //INTERRUPT
					INTERRUPT_ENABLE = 32'h0000_0000; //INTERRUPT_ENABLE
					INSTRUCTION = 32'h0000_0000; //INSTRUCTION
					RESULT = 32'h0000_0000; //RESULT
					ALU_STATUS = 32'h0000_0000; //ALU_STATUS
					OPERAND_00 = 32'h0000_0000;
					OPERAND_01 = 32'h0000_0000;
					OPERAND_02 = 32'h0000_0000;
					OPERAND_03 = 32'h0000_0000;
					OPERAND_04 = 32'h0000_0000;
					OPERAND_05 = 32'h0000_0000;
					OPERAND_06 = 32'h0000_0000;
					OPERAND_07 = 32'h0000_0000;
					OPERAND_08 = 32'h0000_0000;
					OPERAND_09 = 32'h0000_0000;
					OPERAND_10 = 32'h0000_0000;
					OPERAND_11 = 32'h0000_0000;
					OPERAND_12 = 32'h0000_0000;
					OPERAND_13 = 32'h0000_0000;
					OPERAND_14 = 32'h0000_0000;
					OPERAND_15 = 32'h0000_0000; //OPERANDs
					
					o_din = 32'h0000_0000;
					o_push = 1'b0;
					we = 1'b0;
					wAddr = 4'b0000;
					wData = 32'h0000_0000;
					r_pop = 1'b0;					
					alu_begin = 1'b0;
					s_dout = 32'h0000_0000;
					s_interrupt = 1'b0;
					operand_state = 1'b0;
					instruction_state = 1'b0;
					need_pop = 1'b0;
					//clear output to behave safer
				end
				
			else if (clk == 1'b1)
				begin
					if (operand_state == after_operand) //when after write to register file : write -> read
						begin
							we = 1'b0;
							wData = 32'h0000_0000;
							wAddr = 4'b0000;
							operand_state = before_operand;
						end
				
					if (instruction_state == after_instruction) //when after write to instruction fifo : write -> none
						begin
							if(o_wr_ack == 1'b1)
								begin
									o_din = 32'h0000_0000;
									o_push = 1'b0;
									instruction_state = before_instruction;
								end
								
							else if(o_wr_err == 1'b1)
								begin
									o_din = 32'h0000_0000;
									o_push = 1'b0;
									instruction_state = before_instruction;
									ALU_STATUS[1:0] = 2'b11; //fifo is error
								end
							
							else
								o_push = 1'b0; //fifo is working...
						end
						
					if (need_pop == 1'b1) //when pop is needed
						begin
							r_pop = 1'b1;
							need_pop = 1'b0;
						end
					else if (need_pop == 1'b0)
						begin
							if(r_rd_ack == 1'b1)
								begin
									r_pop = 1'b0;
									RESULT = r_dout;
									need_pop = 1'b0;
								end
								
							else if(r_rd_err == 1'b1)
								begin
									r_pop = 1'b0;
									need_pop = 1'b0;
									//fifo is error
								end
							
							else
								r_pop = 1'b0; //fifo is working...
						end
				
					if ({s_sel,s_wr} == 2'b11) //write
						begin
							case (s_addr[7:0])
								(8'b0000_0000) : OPERATION_START = s_din; //OPERATION_STARY
								(8'b0000_0001) : INTERRUPT = s_din; //INTERRUPT
								(8'b0000_0010) : INTERRUPT_ENABLE = s_din; //INTERRUPT_ENABLE
								(8'b0000_0011) : {INSTRUCTION, o_din, o_push, instruction_state} = {s_din, s_din, 1'b1, after_instruction}; //INSTRUCTION
								//(8'b0000_0100) : RESULT = s_din; //RESULT (read only)
								//(8'b0000_0101) : ALU_STATUS = s_din; //ALU_STATUS (read only)
								(8'b0001_0000) : {OPERAND_00, wData, wAddr, we, operand_state} = {s_din, s_din, 4'b0000, 1'b1, after_operand}; //send to register file
								(8'b0001_0001) : {OPERAND_01, wData, wAddr, we, operand_state} = {s_din, s_din, 4'b0001, 1'b1, after_operand}; //send to register file
								(8'b0001_0010) : {OPERAND_02, wData, wAddr, we, operand_state} = {s_din, s_din, 4'b0010, 1'b1, after_operand}; //send to register file
								(8'b0001_0011) : {OPERAND_03, wData, wAddr, we, operand_state} = {s_din, s_din, 4'b0011, 1'b1, after_operand}; //send to register file
								(8'b0001_0100) : {OPERAND_04, wData, wAddr, we, operand_state} = {s_din, s_din, 4'b0100, 1'b1, after_operand}; //send to register file
								(8'b0001_0101) : {OPERAND_05, wData, wAddr, we, operand_state} = {s_din, s_din, 4'b0101, 1'b1, after_operand}; //send to register file
								(8'b0001_0110) : {OPERAND_06, wData, wAddr, we, operand_state} = {s_din, s_din, 4'b0110, 1'b1, after_operand}; //send to register file
								(8'b0001_0111) : {OPERAND_07, wData, wAddr, we, operand_state} = {s_din, s_din, 4'b0111, 1'b1, after_operand}; //send to register file
								(8'b0001_1000) : {OPERAND_08, wData, wAddr, we, operand_state} = {s_din, s_din, 4'b1000, 1'b1, after_operand}; //send to register file
								(8'b0001_1001) : {OPERAND_09, wData, wAddr, we, operand_state} = {s_din, s_din, 4'b1001, 1'b1, after_operand}; //send to register file
								(8'b0001_1010) : {OPERAND_10, wData, wAddr, we, operand_state} = {s_din, s_din, 4'b1010, 1'b1, after_operand}; //send to register file
								(8'b0001_1011) : {OPERAND_11, wData, wAddr, we, operand_state} = {s_din, s_din, 4'b1011, 1'b1, after_operand}; //send to register file
								(8'b0001_1100) : {OPERAND_12, wData, wAddr, we, operand_state} = {s_din, s_din, 4'b1100, 1'b1, after_operand}; //send to register file
								(8'b0001_1101) : {OPERAND_13, wData, wAddr, we, operand_state} = {s_din, s_din, 4'b1101, 1'b1, after_operand}; //send to register file
								(8'b0001_1110) : {OPERAND_14, wData, wAddr, we, operand_state} = {s_din, s_din, 4'b1110, 1'b1, after_operand}; //send to register file
								(8'b0001_1111) : {OPERAND_15, wData, wAddr, we, operand_state} = {s_din, s_din, 4'b1111, 1'b1, after_operand}; //send to register file
								//OPERANDs
								default : ;
							endcase
						end
					else if ({s_sel,s_wr} == 2'b10) //read
						begin
							case (s_addr[7:0])
								(8'b0000_0000) : s_dout = OPERATION_START;
								(8'b0000_0001) : s_dout = INTERRUPT;
								(8'b0000_0010) : s_dout = INTERRUPT_ENABLE;
								(8'b0000_0011) : s_dout = INSTRUCTION; //INSTRUCTION
								(8'b0000_0100) : {s_dout, need_pop} = {RESULT, 1'b1}; //RESULT
								(8'b0000_0101) : s_dout = ALU_STATUS; //ALU_STATUS
								(8'b0001_0000) : s_dout = OPERAND_00;
								(8'b0001_0001) : s_dout = OPERAND_01;
								(8'b0001_0010) : s_dout = OPERAND_02;
								(8'b0001_0011) : s_dout = OPERAND_03;
								(8'b0001_0100) : s_dout = OPERAND_04;
								(8'b0001_0101) : s_dout = OPERAND_05;
								(8'b0001_0110) : s_dout = OPERAND_06;
								(8'b0001_0111) : s_dout = OPERAND_07;
								(8'b0001_1000) : s_dout = OPERAND_08;
								(8'b0001_1001) : s_dout = OPERAND_09;
								(8'b0001_1010) : s_dout = OPERAND_10;
								(8'b0001_1011) : s_dout = OPERAND_11;
								(8'b0001_1100) : s_dout = OPERAND_12;
								(8'b0001_1101) : s_dout = OPERAND_13;
								(8'b0001_1110) : s_dout = OPERAND_14;
								(8'b0001_1111) : s_dout = OPERAND_15; //OPERANDs
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
							if(instruction_empty == 1'b1) //instruction empty (error)
								begin
									ALU_STATUS[1:0] = 2'b11;
								end
							else if(instruction_empty == 1'b0)
								begin
									alu_begin = 1'b1; //send begin signal to master
									ALU_STATUS[1:0] = 2'b01; //master is Executing
								end
							else //when fifo is error
								begin
									ALU_STATUS[1:0] = 2'bxx;
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
						
					if({alu_done,ALU_STATUS[1:0]} == 3'b1_01) //when receive done signal from alu
						begin
							alu_begin = 1'b0;
							ALU_STATUS[1:0] = 2'b10; //done
							need_pop = 1'b1;
							INTERRUPT[0] = 1'b1;
						end
				end
		end 
endmodule 