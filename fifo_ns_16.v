module fifo_ns_16 (wr_en, rd_en, state, data_count, next_state);
	input wr_en, rd_en;
	input[2:0] state;
	input[4:0] data_count;
	output reg[2:0] next_state;
	
	parameter INIT = 3'b000;
	parameter NO_OP = 3'b001;
	parameter WRITE = 3'b010;
	parameter WR_ERR = 3'b011;
	parameter READ = 3'b100;
	parameter RD_ERR = 3'b101;
	//states encoding
	//110 and 111 are not used
	
	always @ (wr_en, rd_en, state, data_count)
		begin
			//every States to INIT (NONE)
		
			if ({wr_en,rd_en} == 2'b00) next_state = NO_OP;
			else if ({wr_en,rd_en} == 2'b11) next_state = NO_OP;
			//every States to NO_OP
			
			else if ({wr_en,rd_en} == 2'b10)
				case (data_count)
					(5'b00000) : next_state = WRITE;//0
					(5'b00001) : next_state = WRITE;
					(5'b00010) : next_state = WRITE;//2
					(5'b00011) : next_state = WRITE;
					(5'b00100) : next_state = WRITE;//4
					(5'b00101) : next_state = WRITE;
					(5'b00110) : next_state = WRITE;
					(5'b00111) : next_state = WRITE;
					(5'b01000) : next_state = WRITE;//8
					(5'b01001) : next_state = WRITE;
					(5'b01010) : next_state = WRITE;
					(5'b01011) : next_state = WRITE;
					(5'b01100) : next_state = WRITE;
					(5'b01101) : next_state = WRITE;
					(5'b01110) : next_state = WRITE;
					(5'b01111) : next_state = WRITE;
					(5'b10000) : next_state = WR_ERR;//16
					default : next_state = 3'bxxx;
				endcase
			//every States to WRITE and WR_ERR
		
			else if ({wr_en,rd_en} == 2'b01)
				case (data_count)
					(5'b00000) : next_state = RD_ERR;//0
					(5'b00001) : next_state = READ;
					(5'b00010) : next_state = READ;//2
					(5'b00011) : next_state = READ;
					(5'b00100) : next_state = READ;//4
					(5'b00101) : next_state = READ;
					(5'b00110) : next_state = READ;
					(5'b00111) : next_state = READ;
					(5'b01000) : next_state = READ;//8
					(5'b01001) : next_state = READ;
					(5'b01010) : next_state = READ;
					(5'b01011) : next_state = READ;
					(5'b01100) : next_state = READ;
					(5'b01101) : next_state = READ;
					(5'b01110) : next_state = READ;
					(5'b01111) : next_state = READ;
					(5'b10000) : next_state = READ;//16
					default : next_state = 3'bxxx;
				endcase
			//every States to READ and RD_ERR
			
			else next_state = 3'bxxx;
		end
endmodule 