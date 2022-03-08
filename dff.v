module dff_3bit (clk, reset_n, d, q);
	input clk, reset_n;
	input[2:0] d;
	
	output reg[2:0] q;
	
	always @ (posedge clk, negedge reset_n)
		begin
			if (reset_n == 1'b0) //resetted
				q <= 3'b000;
		
			else if (clk == 1'b1) //updating
				q <= d;
				
			else
				q <= 3'bxxx;
		end
endmodule 