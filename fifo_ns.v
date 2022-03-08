module fifo_ns (wr_en, rd_en, state, data_count, next_state);
	input wr_en, rd_en;
	input[2:0] state;
	input[3:0] data_count;
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
					(4'b0000) : next_state = WRITE;
					(4'b0001) : next_state = WRITE;
					(4'b0010) : next_state = WRITE;
					(4'b0011) : next_state = WRITE;
					(4'b0100) : next_state = WRITE;
					(4'b0101) : next_state = WRITE;
					(4'b0110) : next_state = WRITE;
					(4'b0111) : next_state = WRITE;
					(4'b1000) : next_state = WR_ERR;
					default : next_state = 3'bxxx;
				endcase
			//every States to WRITE and WR_ERR
		
			else if ({wr_en,rd_en} == 2'b01)
				case (data_count)
					(4'b0001) : next_state = READ;
					(4'b0010) : next_state = READ;
					(4'b0011) : next_state = READ;
					(4'b0100) : next_state = READ;
					(4'b0101) : next_state = READ;
					(4'b0110) : next_state = READ;
					(4'b0111) : next_state = READ;
					(4'b1000) : next_state = READ;
					(4'b0000) : next_state = RD_ERR;
					default : next_state = 3'bxxx;
				endcase
			//every States to READ and RD_ERR
			
			else next_state = 3'bxxx;
			
			/*
			if ({wr_en,data_count} == 5'b1_0000) next_state = WRITE;
			else if ({wr_en,data_count} == 5'b1_0001) next_state = WRITE;
			else if ({wr_en,data_count} == 5'b1_0010) next_state = WRITE;
			else if ({wr_en,data_count} == 5'b1_0011) next_state = WRITE;
			else if ({wr_en,data_count} == 5'b1_0100) next_state = WRITE;
			else if ({wr_en,data_count} == 5'b1_0101) next_state = WRITE;
			else if ({wr_en,data_count} == 5'b1_0110) next_state = WRITE;
			else if ({wr_en,data_count} == 5'b1_0111) next_state = WRITE;
			//every States to WRITE
			else if ({wr_en,data_count} == 5'b1_1000) next_state = WR_ERR;
			//every States to WR_ERR
			
			if ({rd_en,data_count} == 5'b1_0001) next_state = READ;
			else if ({rd_en,data_count} == 5'b1_0010) next_state = READ;
			else if ({rd_en,data_count} == 5'b1_0011) next_state = READ;
			else if ({rd_en,data_count} == 5'b1_0100) next_state = READ;
			else if ({rd_en,data_count} == 5'b1_0101) next_state = READ;
			else if ({rd_en,data_count} == 5'b1_0110) next_state = READ;
			else if ({rd_en,data_count} == 5'b1_0111) next_state = READ;
			else if ({rd_en,data_count} == 5'b1_1000) next_state = READ;
			//every States to READ
			else if ({rd_en,data_count} == 5'b1_0000) next_state = RD_ERR;
			//every States to RD_ERR
			*/
		end
endmodule 