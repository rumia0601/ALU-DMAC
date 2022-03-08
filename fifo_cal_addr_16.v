module fifo_cal_addr_16(state, head, tail, data_count, we, re, next_head, next_tail, next_data_count);
	input[2:0] state;
	input[3:0] head, tail;
	input[4:0] data_count;
	output reg we, re;
	output reg[3:0] next_head, next_tail;
	output reg[4:0] next_data_count;
	
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
					(4'b0000) : next_tail = 4'b0001;//0 -> 1
					(4'b0001) : next_tail = 4'b0010;
					(4'b0010) : next_tail = 4'b0011;//2 -> 3
					(4'b0011) : next_tail = 4'b0100;
					(4'b0100) : next_tail = 4'b0101;//4 -> 5
					(4'b0101) : next_tail = 4'b0110;
					(4'b0110) : next_tail = 4'b0111;
					(4'b0111) : next_tail = 4'b1000;
					(4'b1000) : next_tail = 4'b1001;//8 -> 9
					(4'b1001) : next_tail = 4'b1010;
					(4'b1010) : next_tail = 4'b1011;
					(4'b1011) : next_tail = 4'b1100;
					(4'b1100) : next_tail = 4'b1101;
					(4'b1101) : next_tail = 4'b1110;
					(4'b1110) : next_tail = 4'b1111;
					(4'b1111) : next_tail = 4'b0000;//15 -> 0
					default : next_tail = 4'bxxxx;
				endcase 
				//tail ++
				case (data_count)
					(5'b00000) : next_data_count = 5'b00001;//0 -> 1
					(5'b00001) : next_data_count = 5'b00010;
					(5'b00010) : next_data_count = 5'b00011;//2 -> 3
					(5'b00011) : next_data_count = 5'b00100;
					(5'b00100) : next_data_count = 5'b00101;//4 -> 5
					(5'b00101) : next_data_count = 5'b00110;
					(5'b00110) : next_data_count = 5'b00111;
					(5'b00111) : next_data_count = 5'b01000;
					(5'b01000) : next_data_count = 5'b01001;//8 -> 9
					(5'b01001) : next_data_count = 5'b01010;
					(5'b01010) : next_data_count = 5'b01011;
					(5'b01011) : next_data_count = 5'b01100;
					(5'b01100) : next_data_count = 5'b01101;
					(5'b01101) : next_data_count = 5'b01110;
					(5'b01110) : next_data_count = 5'b01111;
					(5'b01111) : next_data_count = 5'b10000;//15 -> 16
					default : next_data_count = 4'bxxxx;
				endcase
				//data_count++
				{next_head, we, re} = {head, 1'b1, 1'b0};
			end
			//When state was WRITE
			
			else if (state == READ)
			begin
				case (head)
					(4'b0000) : next_head = 4'b0001;//0 -> 1
					(4'b0001) : next_head = 4'b0010;
					(4'b0010) : next_head = 4'b0011;//2 -> 3
					(4'b0011) : next_head = 4'b0100;
					(4'b0100) : next_head = 4'b0101;//4 -> 5
					(4'b0101) : next_head = 4'b0110;
					(4'b0110) : next_head = 4'b0111;
					(4'b0111) : next_head = 4'b1000;
					(4'b1000) : next_head = 4'b1001;//8 -> 9
					(4'b1001) : next_head = 4'b1010;
					(4'b1010) : next_head = 4'b1011;
					(4'b1011) : next_head = 4'b1100;
					(4'b1100) : next_head = 4'b1101;
					(4'b1101) : next_head = 4'b1110;
					(4'b1110) : next_head = 4'b1111;
					(4'b1111) : next_head = 4'b0000;//15 -> 0
					default : next_head = 4'bxxxx;
				endcase 
				//head++
				case (data_count)
					(5'b00001) : next_data_count = 5'b00000;//1 -> 0
					(5'b00010) : next_data_count = 5'b00001;//2 -> 1
					(5'b00011) : next_data_count = 5'b00010;
					(5'b00100) : next_data_count = 5'b00011;//4 -> 3
					(5'b00101) : next_data_count = 5'b00100;
					(5'b00110) : next_data_count = 5'b00101;
					(5'b00111) : next_data_count = 5'b00110;
					(5'b01000) : next_data_count = 5'b00111;//8 -> 7
					(5'b01001) : next_data_count = 5'b01000;
					(5'b01010) : next_data_count = 5'b01001;
					(5'b01011) : next_data_count = 5'b01010;
					(5'b01100) : next_data_count = 5'b01011;
					(5'b01101) : next_data_count = 5'b01100;
					(5'b01110) : next_data_count = 5'b01101;
					(5'b01111) : next_data_count = 5'b01110;//15 -> 14
					(5'b10000) : next_data_count = 5'b01111;//16 -> 15
					default : next_data_count = 5'bxxxxx;
				endcase
				//data_count--
				{next_tail, we, re} = {tail, 1'b0, 1'b1};
			end
			//When state was READ
		
			else if (state == INIT) {next_head, next_tail, next_data_count, we, re} = 15'b0000_0000_00000_0_0;
			//when state was INIT
			
			else if (state == NO_OP) {next_head, next_tail, next_data_count, we, re} = {head, tail, data_count, 1'b0, 1'b0};
			//When state was NO_OP
			
			else if (state == WR_ERR) {next_head, next_tail, next_data_count, we, re} = {head, tail, 5'b10000, 1'b0, 1'b0};
			//When state was WR_ERR
			
			else if (state == RD_ERR) {next_head, next_tail, next_data_count, we, re} = {head, tail, 5'b00000, 1'b0, 1'b0};
			//When state was RD_ERR
			
			else {next_head, next_tail, next_data_count, we, re} = 15'bxxxx_xxxx_xxxxx_x_x;
		end
endmodule 