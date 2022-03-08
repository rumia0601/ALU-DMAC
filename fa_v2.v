module fa_v2(a,b,ci,s);
	input a,b,ci;
	output s;
	wire wo;
	
	_xor2 xor21(a,b,wo);
	_xor2 xor22(wo,ci,s); // s = a^b^ci
endmodule 