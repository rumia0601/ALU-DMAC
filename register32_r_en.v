module register32_r_en(clk, reset_n, en, d_in, d_out); //one 32bit register is four 8bit register
	input clk, reset_n, en;
	input[31:0] d_in;
	output[31:0] d_out;
	
	register8_r_en register8_r_en_1(clk, reset_n, en, d_in[7:0], d_out[7:0]);
	register8_r_en register8_r_en_2(clk, reset_n, en, d_in[15:8], d_out[15:8]);
	register8_r_en register8_r_en_3(clk, reset_n, en, d_in[23:16], d_out[23:16]);
	register8_r_en register8_r_en_4(clk, reset_n, en, d_in[31:24], d_out[31:24]);
endmodule 