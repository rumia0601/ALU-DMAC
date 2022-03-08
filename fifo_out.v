module fifo_out(state, data_count, full, empty, wr_ack, wr_err, rd_ack, rd_err);
	input[2:0] state;
	input[3:0] data_count;
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
					(4'b0000) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_1_0_0_0_0;
					(4'b0001) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_0_0;
					(4'b0010) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_0_0;
					(4'b0011) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_0_0;
					(4'b0100) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_0_0;
					(4'b0101) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_0_0;
					(4'b0110) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_0_0;
					(4'b0111) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_0_0;
					(4'b1000) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b1_0_0_0_0_0;
					default : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'bx_x_x_x_x_x;
				endcase 
			//when state was NO_OP(NONE)
			
			else if (state == WRITE)
				case (data_count)
					(4'b0001) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
					(4'b0010) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
					(4'b0011) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
					(4'b0100) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
					(4'b0101) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
					(4'b0110) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
					(4'b0111) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
					(4'b1000) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b1_0_1_0_0_0;
					default : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'bx_x_x_x_x_x;
				endcase
			//when state was WRITE
		
			else if (state == WR_ERR) {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b1_0_0_1_0_0;
			//when state was WR_ERR
			
			else if (state == READ)
				case (data_count)
					(4'b0000) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_1_0_0_1_0;
					(4'b0001) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
					(4'b0010) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
					(4'b0011) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
					(4'b0100) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
					(4'b0101) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
					(4'b0110) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
					(4'b0111) : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
					default : {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'bx_x_x_x_x_x;
				endcase
			//when state was READ
		
			else if (state == RD_ERR) {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_1_0_0_0_1;
			//when state was RD_ERR
			
			else {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'bx_x_x_x_x_x;
			
			/*
			if ({state,data_count} == {WRITE,4'b0001}) {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
			else if ({state,data_count} == {WRITE,4'b0010}) {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
			else if ({state,data_count} == {WRITE,4'b0011}) {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
			else if ({state,data_count} == {WRITE,4'b0100}) {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
			else if ({state,data_count} == {WRITE,4'b0101}) {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
			else if ({state,data_count} == {WRITE,4'b0110}) {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
			else if ({state,data_count} == {WRITE,4'b0111}) {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_1_0_0_0;
			else if ({state,data_count} == {WRITE,4'b1000}) {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b1_0_1_0_0_0;
			//when state was WRITE
			
			if (state == WR_ERR) {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b1_0_0_1_0_0;
			//when state was WR_ERR
			
			if ({state,data_count} == {READ,4'b0000}) {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_1_0_0_1_0;
			else if ({state,data_count} == {READ,4'b0001}) {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
			else if ({state,data_count} == {READ,4'b0010}) {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
			else if ({state,data_count} == {READ,4'b0011}) {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
			else if ({state,data_count} == {READ,4'b0100}) {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
			else if ({state,data_count} == {READ,4'b0101}) {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
			else if ({state,data_count} == {READ,4'b0110}) {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
			else if ({state,data_count} == {READ,4'b0111}) {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_0_0_0_1_0;
			//when state was READ
			
			if (state == RD_ERR) {full, empty, wr_ack, wr_err, rd_ack, rd_err} = 6'b0_1_0_0_0_1;
			//when state was RD_ERR
			*/
		end
endmodule 