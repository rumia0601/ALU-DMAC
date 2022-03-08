module mux2_1bit(d0, d1, s, y);
	input d0, d1, s;
	output reg y;
	
	always @ (d0, d1, s)
		begin
			case(s)
				(1'b0) : y <= d0;
				(1'b1) : y <= d1;
				default : y <= 1'bx;
			endcase 
		end
	//s == 0, y = d0
	//s == 1, y = d1
	//2 bit
endmodule 

module mux2_16bit(d0, d1, s, y);
	input[15:0] d0, d1;
	input s;
	output reg[15:0] y;
	
	always @ (d0, d1, s)
		begin
			case(s)
				(1'b0) : y <= d0;
				(1'b1) : y <= d1;
				default : y <= 16'hxxxx;
			endcase 
		end
	//s == 0, y = d0
	//s == 1, y = d1
	//16 bit
endmodule 

module mux2_32bit(d0, d1, s, y);
	input[31:0] d0, d1;
	input s;
	output reg[31:0] y;
	
	always @ (d0, d1, s)
		begin
			case(s)
				(1'b0) : y <= d0;
				(1'b1) : y <= d1;
				default : y <= 32'hxxxx_xxxx;
			endcase 
		end
	//s == 0, y = d0
	//s == 1, y = d1
	//32 bit
endmodule 
	
module mux6_32bit(zero, d0, d1, d2, d3, d4, s, y);
	input[31:0] zero, d0, d1, d2, d3, d4;
	input[2:0] s;
	output reg[31:0] y;
	
	always @ (zero, d0, d1, d2, d3, d4, s)
		begin
			case(s)
				(3'b000) : y <= zero; //no slave selected
				(3'b001) : y <= d0; //s0 selected
				(3'b010) : y <= d1; //s1 selected
				(3'b011) : y <= d2; //s2 selected
				(3'b100) : y <= d3; //s3 selected
				(3'b101) : y <= d4; //s4 selected
				default : y <= 32'hxxxx_xxxx; //error (wrong encoding)
			endcase 
		end
	//s == 0, y = d0
	//s == 1, y = d1
endmodule 