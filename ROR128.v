module ROR128(d_in, d_out);//128 bit Rotate Right (always rotate 2 bits)
	input[127:0] d_in;
	output[127:0] d_out;
	
	assign d_out[127:126] = d_in[1:0]; //Higest 2 bit of rotated bit = Loweser 2 bit of non-rotated bit
	assign d_out[125:0] = d_in[127:2]; //Nth Bit of rotated bit = N+2th bit of non-rotated bit
endmodule 