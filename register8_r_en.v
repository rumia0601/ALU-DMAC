module register8_r_en(clk, reset_n, en, d_in, d_out); //one 8bit register is eight 1bit register
	input clk, reset_n, en;
	input[7:0] d_in;
	output[7:0] d_out;
	
	_dff_r_en _dff_r_en_1(clk, reset_n, en, d_in[0], d_out[0]);
	_dff_r_en _dff_r_en_2(clk, reset_n, en, d_in[1], d_out[1]);
	_dff_r_en _dff_r_en_3(clk, reset_n, en, d_in[2], d_out[2]);
	_dff_r_en _dff_r_en_4(clk, reset_n, en, d_in[3], d_out[3]);
	_dff_r_en _dff_r_en_5(clk, reset_n, en, d_in[4], d_out[4]);
	_dff_r_en _dff_r_en_6(clk, reset_n, en, d_in[5], d_out[5]);
	_dff_r_en _dff_r_en_7(clk, reset_n, en, d_in[6], d_out[6]);
	_dff_r_en _dff_r_en_8(clk, reset_n, en, d_in[7], d_out[7]);
endmodule 