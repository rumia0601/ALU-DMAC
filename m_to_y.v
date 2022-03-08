module m_to_y(m, y); //radix-2 is used
	input[1:0] m;
	output reg[1:0] y;
	
	parameter zero = 2'b00; //case of shift only
	parameter plus = 2'b01; //case of add and shift
	parameter minus = 2'b10; //case of subtract and shift
	
	always @ (m)
		begin
			if (m[1] == 1'b0 && m[0] == 1'b0) //m is 00 so y is 0
				y[1:0] = zero;
			else if (m[1] == 1'b0 && m[0] == 1'b1) //m is 01 so y is 1
				y[1:0] = plus;
			else if (m[1] == 1'b1 && m[0] == 1'b0) //m is 10 so y is -1
				y[1:0] = minus;
			else if (m[1] == 1'b1 && m[0] == 1'b1) //m is 11 so y is 0
				y[1:0] = zero;
			else
				y[1:0] = 2'bxx;
		end
endmodule 