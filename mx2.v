module mx2(d0,d1,s,y);
	input[31:0] d0,d1;
	input s;
	output reg[31:0] y;
	wire[31:0] sb,w0,w1;
	
	always @ (d0, d1, s)
		begin
			if (s == 1'b0) y = d0;
			else if (s == 1'b1) y = d1;
			else y = 32'bxxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx;
		end
	
	//assign (~s)&d0 | s&d1
	//= assign ~((~s) nand d0) & (s nand s1))
	//= assign ((~s) nand d0) nand (s nand s1)
endmodule 