module ASR128(d_in, d_out);//128 bit Arithmetic Shift Right (always shift 1 bits)
	input[127:0] d_in;
	output[127:0] d_out;
	
	assign d_out[126:0] = d_in[127:1]; //Nth bit of shifted bit = N+1th bit of non-shifted bit
	assign d_out[127] = d_in[127]; //sign bit of shifted bit = sign bit of not-shifted bit
endmodule 