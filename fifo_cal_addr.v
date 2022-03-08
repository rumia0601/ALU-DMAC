module fifo_cal_addr(state, head, tail, data_count, we, re, next_head, next_tail, next_data_count);
	input[2:0] state, head, tail;
	input[3:0] data_count;
	output reg we, re;
	output reg[2:0] next_head, next_tail;
	output reg[3:0] next_data_count;
	
	parameter INIT = 3'b000;
	parameter NO_OP = 3'b001;
	parameter WRITE = 3'b010;
	parameter WR_ERR = 3'b011;
	parameter READ = 3'b100;
	parameter RD_ERR = 3'b101;
	//states encoding
	//110 and 111 are not used
	
	always @ (state, head, tail, data_count)
		begin
			if (state == WRITE)
			begin
				case (tail)
					(3'b000) : next_tail = 3'b001;
					(3'b001) : next_tail = 3'b010;
					(3'b010) : next_tail = 3'b011;
					(3'b011) : next_tail = 3'b100;
					(3'b100) : next_tail = 3'b101;
					(3'b101) : next_tail = 3'b110;
					(3'b110) : next_tail = 3'b111;
					(3'b111) : next_tail = 3'b000;
					default : next_tail = 3'bxxx;
				endcase 
				//tail ++
				case (data_count)
					(4'b0000) : next_data_count = 4'b0001;
					(4'b0001) : next_data_count = 4'b0010;
					(4'b0010) : next_data_count = 4'b0011;
					(4'b0011) : next_data_count = 4'b0100;
					(4'b0100) : next_data_count = 4'b0101;
					(4'b0101) : next_data_count = 4'b0110;
					(4'b0110) : next_data_count = 4'b0111;
					(4'b0111) : next_data_count = 4'b1000;
					default : next_data_count = 4'bxxxx;
				endcase
				//data_count++
				{next_head, we, re} = {head, 1'b1, 1'b0};
			end
			//When state was WRITE
			
			else if (state == READ)
			begin
				case (head)
					(3'b000) : next_head = 3'b001;
					(3'b001) : next_head = 3'b010;
					(3'b010) : next_head = 3'b011;
					(3'b011) : next_head = 3'b100;
					(3'b100) : next_head = 3'b101;
					(3'b101) : next_head = 3'b110;
					(3'b110) : next_head = 3'b111;
					(3'b111) : next_head = 3'b000;
					default : next_head = 3'bxxx;
				endcase 
				//head++
				case (data_count)
					(4'b0001) : next_data_count = 4'b0000;
					(4'b0010) : next_data_count = 4'b0001;
					(4'b0011) : next_data_count = 4'b0010;
					(4'b0100) : next_data_count = 4'b0011;
					(4'b0101) : next_data_count = 4'b0100;
					(4'b0110) : next_data_count = 4'b0101;
					(4'b0111) : next_data_count = 4'b0110;
					(4'b1000) : next_data_count = 4'b0111;
					default : next_data_count = 4'bxxxx;
				endcase
				//data_count--
				{next_tail, we, re} = {tail, 1'b0, 1'b1};
			end
			//When state was READ
		
			else if (state == INIT) {next_head, next_tail, next_data_count, we, re} = 12'b000_000_0000_0_0;
			//when state was INIT
			
			else if (state == NO_OP) {next_head, next_tail, next_data_count, we, re} = {head, tail, data_count, 1'b0, 1'b0};
			//When state was NO_OP
			
			else if (state == WR_ERR) {next_head, next_tail, next_data_count, we, re} = {head, tail, 4'b1000, 1'b0, 1'b0};
			//When state was WR_ERR
			
			else if (state == RD_ERR) {next_head, next_tail, next_data_count, we, re} = {head, tail, 4'b0000, 1'b0, 1'b0};
			//When state was RD_ERR
			
			else {next_head, next_tail, next_data_count, we, re} = 12'bxxx_xxx_xxxx_x_x;
			
			/*
			if ({state,tail} == {WRITE,3'b000}) next_tail = 3'b001;
			else if ({state,tail} == {WRITE,3'b001}) next_tail = 3'b010;
			else if ({state,tail} == {WRITE,3'b010}) next_tail = 3'b011;
			else if ({state,tail} == {WRITE,3'b011}) next_tail = 3'b100;
			else if ({state,tail} == {WRITE,3'b100}) next_tail = 3'b101;
			else if ({state,tail} == {WRITE,3'b101}) next_tail = 3'b110;
			else if ({state,tail} == {WRITE,3'b110}) next_tail = 3'b111;
			//tail++
			if ({state,data_count} == {WRITE,4'b0000}) next_data_count = 4'b0001;
			else if ({state,data_count} == {WRITE,4'b0001}) next_data_count = 4'b0010;
			else if ({state,data_count} == {WRITE,4'b0010}) next_data_count = 4'b0011;
			else if ({state,data_count} == {WRITE,4'b0011}) next_data_count = 4'b0100;
			else if ({state,data_count} == {WRITE,4'b0100}) next_data_count = 4'b0101;
			else if ({state,data_count} == {WRITE,4'b0101}) next_data_count = 4'b0110;
			else if ({state,data_count} == {WRITE,4'b0110}) next_data_count = 4'b0111;
			else if ({state,data_count} == {WRITE,4'b0111}) next_data_count = 4'b1000;
			//data_count++
			if (state == WRITE) {we, re} = 2'b1_0;
			//When state was WRITE
			
			//When state was WR_ERR(NONE)
			
			if ({state,head} == {READ,3'b000}) next_head = 3'b001;
			else if ({state,head} == {READ,3'b001}) next_head = 3'b010;
			else if ({state,head} == {READ,3'b010}) next_head = 3'b011;
			else if ({state,head} == {READ,3'b011}) next_head = 3'b100;
			else if ({state,head} == {READ,3'b100}) next_head = 3'b101;
			else if ({state,head} == {READ,3'b101}) next_head = 3'b110;
			else if ({state,head} == {READ,3'b110}) next_head = 3'b111;
			//head++
			if ({state,data_count} == {READ,4'b0001}) next_data_count = 4'b0000;
			else if ({state,data_count} == {READ,4'b0010}) next_data_count = 4'b0001;
			else if ({state,data_count} == {READ,4'b0011}) next_data_count = 4'b0010;
			else if ({state,data_count} == {READ,4'b0100}) next_data_count = 4'b0011;
			else if ({state,data_count} == {READ,4'b0101}) next_data_count = 4'b0100;
			else if ({state,data_count} == {READ,4'b0110}) next_data_count = 4'b0101;
			else if ({state,data_count} == {READ,4'b0111}) next_data_count = 4'b0110;
			else if ({state,data_count} == {READ,4'b1000}) next_data_count = 4'b0111;
			//data_count--	
			if (state == READ) {we, re} = 2'b0_1;
			//When state was READ
			
			//When state was RD_ERR(NONE)
			*/
		end
endmodule 