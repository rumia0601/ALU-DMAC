 module multiplier(clk, reset_n, multiplier, multiplicand, op_start, op_clear, op_done, result);
	input clk, reset_n, op_start, op_clear;
	input[63:0] multiplier, multiplicand;
	output reg op_done;
	output reg[127:0] result;
	 
	reg[127:0] y;
	wire[127:0] rotate_y, first_y;
	wire[63:0] minus_multiplier;
	
	reg[127:0] product;
	wire[127:0] shift_product, add_product, add_shift_product, sub_product, sub_shift_product;
	
	reg[7:0] count;
	wire[7:0] add_count;
	
	reg[63:0] first_multiplier;
	
	reg enable;
	
	parameter zero = 2'b00; //case of shift only
	parameter plus = 2'b01; //case of add and shift
	parameter minus = 2'b10; //case of subtract and shift
	
	multiplicand_to_y multiplicand_to_y_1(multiplicand, first_y); //set first y (not rotated) by multiplier
	ROR128 ROR128_1(y, rotate_y); //set value to rotated y
	
	ASR128 ASR128_1(product, shift_product); //set value to shifted product
	cla128 cla128_1(product, {first_multiplier, 64'h0000_0000_0000_0000}, 1'b0, add_product); //co of cla is not needed
	ASR128 ASR128_2(add_product, add_shift_product); //set value to added and shifted product
	cla64 cla64_1(~first_multiplier, 64'h0000_0000_0000_0000, 1'b1, minus_multiplier); //co of cla is not needed
	cla128 cla128_2(product, {minus_multiplier, 64'h0000_0000_0000_0000}, 1'b0, sub_product); //co of cla is not needed
	ASR128 ASR128_3(sub_product, sub_shift_product); //set value to subtracted and shifted product
	
	cla8 cla8_1(count, 8'b0000_0001, 1'b0, add_count); //set value to added count (co of cla is not needed)
	
	always @ (negedge reset_n or posedge op_clear or posedge op_start or posedge clk)
		begin		
			if(reset_n == 1'b0) //when reset is activated : reset all values to 0, reset y to inial y
				begin
					op_done = 1'b0;
					result = 128'h0000_0000_0000_0000_0000_0000_0000_0000;
					enable = 1'b0;
			
					count = 8'b0000_0000;
					
					product = 128'h0000_0000_0000_0000_0000_0000_0000_0000;
				end
				
			else if(clk == 1'b1)
				begin					
					if(op_clear == 1'b1) //when clear is activated : reset all values to 0, reset y to inial y (same as reset)
						begin
							op_done = 1'b0;
							result = 128'h0000_0000_0000_0000_0000_0000_0000_0000;
							enable = 1'b0;
					
							count = 8'b0000_0000;
					
							product = 128'h0000_0000_0000_0000_0000_0000_0000_0000;
						end
				
					else if (enable == 1'b1) //when abled
						begin
							count = add_count; //get value from added count
			
							case (y[1:0])
								zero: product = shift_product; //get value from shifted product
								plus: product = add_shift_product; //get value from added and shifted product
								minus: product = sub_shift_product; //get value from subtracted and shifted product
								default: product = 128'hxxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx; //wrong encoded value
							endcase
							
							y = rotate_y; //get value from rotated y
							
							result = product;
							
							if (count == 8'b0100_0000) //when count is 64
								begin
									op_done = 1'b1;
									enable = 1'b0;
								end
						end
						
					else if (enable == 1'b0) //when disabled
						begin											
							//do nothing
						end
						
					if(op_start == 1'b1) //when start is activated : initialize multiplier and y when count is 0
						begin
							if(count == 8'b0000_0000)
								begin
									enable = 1'b1;
							
									y = first_y;
									first_multiplier = multiplier;
								end
						end
				
					else if(op_start == 1'b0) //when op_start is 0
						begin
							//do nothing
						end		
						
					else //can't know whether it is able or disable
						begin
							count = 8'bxxxx_xxxx;
				
							y = 128'hxxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx;
			
							product = 128'hxxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx;
							
							op_done = 1'bx;
							result = 128'hxxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx;
							enable = 1'bx;	
						end
				end
		end 
endmodule 