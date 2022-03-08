module _dff_r_en(clk, reset_n, en, d, q);
	input clk, reset_n, en, d;
	output reg q;
	
	always @ (posedge clk or negedge reset_n)
		begin
			if (reset_n == 1'b0) //reset has 1st priority
				q <= 1'b0;
			else if (en) //enable has 2nd priority
				q <= d;
			else //clock has 3rd priority
				q <= q;
		end
endmodule 				