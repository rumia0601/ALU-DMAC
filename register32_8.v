module register32_8(clk, reset_n, en, d_in, d_out0, d_out1, d_out2, d_out3, d_out4, d_out5, d_out6, d_out7);
	input clk, reset_n;
	input[7:0] en;
	input[31:0] d_in;
	output[31:0] d_out0, d_out1, d_out2, d_out3, d_out4, d_out5, d_out6, d_out7;
	////eight 32bit register in one module
	
	register32_r_en register32_r_en_1(clk, reset_n, en[0], d_in, d_out0);
	register32_r_en register32_r_en_2(clk, reset_n, en[1], d_in, d_out1);
	register32_r_en register32_r_en_3(clk, reset_n, en[2], d_in, d_out2);
	register32_r_en register32_r_en_4(clk, reset_n, en[3], d_in, d_out3);
	register32_r_en register32_r_en_5(clk, reset_n, en[4], d_in, d_out4);
	register32_r_en register32_r_en_6(clk, reset_n, en[5], d_in, d_out5);
	register32_r_en register32_r_en_7(clk, reset_n, en[6], d_in, d_out6);
	register32_r_en register32_r_en_8(clk, reset_n, en[7], d_in, d_out7);
endmodule 