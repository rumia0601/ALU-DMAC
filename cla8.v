module cla8(a,b,ci,s,co); //single 8 bit carry lookahead adder = 2 cla4 modules
	input[7:0] a,b;
	input ci;
	output[7:0] s;
	output co;
	
	wire c1;
	
	cla4 cla4_1(a[3:0],b[3:0],ci,s[3:0],c1);
	cla4 cla4_2(a[7:4],b[7:4],c1,s[7:4],co);
endmodule 