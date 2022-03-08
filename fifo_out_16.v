module fifo_out_16(state, data_count, full, empty, wr_ack, wr_err, rd_ack, rd_err);
	input[2:0] state;
	input[4:0] data_count;
	output reg full, empty, wr_ack, wr_err, rd_ack, rd_err;
	
	parameter INIT = 3'b000;
	parameter NO_OP = 3'b001;
	parameter WRITE = 3'b010;
	parameter WR_ERR = 3'b011;
	parameter READ = 3'b100;
	parameter RD_ERR = 3'b101;
	
	always @ (state, data_count)
		begin
			if (state == INIT) {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_0_0;
			//when state was INIT(NONE)
			
			else if (state == NO_OP)
				case (data_count)
					(5'b00000) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_1_0_0_0_0;
					(5'b00001) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_0_0;
					(5'b00010) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_0_0;
					(5'b00011) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_0_0;
					(5'b00100) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_0_0;
					(5'b00101) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_0_0;
					(5'b00110) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_0_0;
					(5'b00111) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_0_0;
					(5'b01000) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_0_0;
					(5'b01001) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_0_0;
					(5'b01010) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_0_0;
					(5'b01011) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_0_0;
					(5'b01100) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_0_0;
					(5'b01101) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_0_0;
					(5'b01110) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_0_0;
					(5'b01111) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_0_0;
					(5'b10000) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b1_0_0_0_0_0;
					default : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'bx_x_x_x_x_x;
				endcase 
			//when state was NO_OP(NONE)
			
			else if (state == WRITE)
				case (data_count)
					(5'b00001) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
					(5'b00010) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
					(5'b00011) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
					(5'b00100) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
					(5'b00101) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
					(5'b00110) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
					(5'b00111) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
					(5'b01000) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
					(5'b01001) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
					(5'b01010) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
					(5'b01011) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
					(5'b01100) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
					(5'b01101) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
					(5'b01110) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
					(5'b01111) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
					(5'b10000) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b1_0_1_0_0_0;
					default : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'bx_x_x_x_x_x;
				endcase
			//when state was WRITE
		
			else if (state == WR_ERR) {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b1_0_0_1_0_0;
			//when state was WR_ERR
			
			else if (state == READ)
				case (data_count)
					(5'b00000) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_1_0_0_1_0;
					(5'b00001) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
					(5'b00010) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
					(5'b00011) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
					(5'b00100) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
					(5'b00101) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
					(5'b00110) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
					(5'b00111) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
					(5'b01000) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
					(5'b01001) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
					(5'b01010) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
					(5'b01011) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
					(5'b01100) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
					(5'b01101) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
					(5'b01110) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
					(5'b01111) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
					default : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'bx_x_x_x_x_x;
				endcase
			//when state was READ
		
			else if (state == RD_ERR) {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_1_0_0_0_1;
			//when state was RD_ERR
			
			else {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'bx_x_x_x_x_x;
		end
endmodule 