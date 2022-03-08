module cla4(a,b,ci,s,co); //4 bit carry lookahead adder
	input[3:0] a,b;
	input ci;
	output[3:0] s;
	output co;
	
	wire c1, c2, c3;
	
	clb4 U4_clb4(a,b,ci,c1,c2,c3,co); //get c1, c2, c3 and co from 4 bit carry lookahead block
	
	fa_v2 U0_fa_v2(a[0],b[0],ci,s[0]);
	fa_v2 U1_fa_v2(a[1],b[1],c1,s[1]);
	fa_v2 U2_fa_v2(a[2],b[2],c2,s[2]);
	fa_v2 U3_fa_v2(a[3],b[3],c3,s[3]); //get s[0], s[1], s[2], s[3] from 4 bit full adder
endmodule 