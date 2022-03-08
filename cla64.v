module cla64(a,b,ci,s,co); //single 128 bit carry lookahead adder = 32 cla4 modules
	input[63:0] a,b;
	input ci;
	output[63:0] s;
	output co;
	
	wire c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15;
	
	cla4 cla4_1(a[3:0],b[3:0],ci,s[3:0],c1);
	cla4 cla4_2(a[7:4],b[7:4],c1,s[7:4],c2);
	cla4 cla4_3(a[11:8],b[11:8],c2,s[11:8],c3);
	cla4 cla4_4(a[15:12],b[15:12],c3,s[15:12],c4);
	cla4 cla4_5(a[19:16],b[19:16],c4,s[19:16],c5);
	cla4 cla4_6(a[23:20],b[23:20],c5,s[23:20],c6);
	cla4 cla4_7(a[27:24],b[27:24],c6,s[27:24],c7);
	cla4 cla4_8(a[31:28],b[31:28],c7,s[31:28],c8);
	cla4 cla4_9(a[35:32],b[35:32],c8,s[35:32],c9);
	cla4 cla4_10(a[39:36],b[39:36],c9,s[39:36],c10);
	
	cla4 cla4_11(a[43:40],b[43:40],c10,s[43:40],c11);
	cla4 cla4_12(a[47:44],b[47:44],c11,s[47:44],c12);
	cla4 cla4_13(a[51:48],b[51:48],c12,s[51:48],c13);
	cla4 cla4_14(a[55:52],b[55:52],c13,s[55:52],c14);
	cla4 cla4_15(a[59:56],b[59:56],c14,s[59:56],c15);
	cla4 cla4_16(a[63:60],b[63:60],c15,s[63:60],co);
endmodule 