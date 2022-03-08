module bus_arbiter(clk, reset_n, m0_req, m1_req, m0_grant, m1_grant);
	input clk, reset_n;
	input m0_req, m1_req;
	output reg m0_grant, m1_grant;
	
	reg[1:0] next_state, state;
	
	parameter NO_GRANT = 2'b00;
	parameter M0_GRANT = 2'b01;
	parameter M1_GRANT = 2'b10;
	//state encoding
	
	always @ (m0_req, m1_req, state)
		begin
			if (state == NO_GRANT) //when state is no_grant	
				begin
					case({m0_req,m1_req})
						(2'b0_0): next_state <= NO_GRANT; //no grant
						(2'b0_1): next_state <= M1_GRANT;
						(2'b1_0): next_state <= M0_GRANT;
						(2'b1_1): next_state <= M0_GRANT;
						default : next_state <= 2'bxx;
					endcase
				end 
		
			else if (state == M0_GRANT) //when state is m0_grant	
				begin
					case({m0_req,m1_req})
						(2'b0_0): next_state <= NO_GRANT; //no grant
						(2'b0_1): next_state <= M1_GRANT;
						(2'b1_0): next_state <= M0_GRANT;
						(2'b1_1): next_state <= M0_GRANT;
						default : next_state <= 2'bxx;
					endcase
				end 
			else if (state == M1_GRANT) //when state is m1_grant
				begin
					case({m0_req,m1_req})
						(2'b0_0): next_state <= NO_GRANT; //no grant
						(2'b0_1): next_state <= M1_GRANT;
						(2'b1_0): next_state <= M0_GRANT;
						(2'b1_1): next_state <= M1_GRANT;
						default : next_state <= 2'bxx;
					endcase
				end
			else
				next_state = 2'bxx; //wrong state
		end
	//next state logic
	
	always @ (posedge clk, negedge reset_n)
		begin
			if (reset_n == 1'b0) //when resetted
				state <= NO_GRANT;
			else if (clk == 1'b1)
				state <= next_state;
			else
				state <= 2'bx;
		end
	//register logic	
		
	always @ (state)
		begin
			if (state == NO_GRANT)
				begin
					m0_grant <= 1'b0;
					m1_grant <= 1'b0;
				end 
			else if (state == M0_GRANT)
				begin
					m0_grant <= 1'b1;
					m1_grant <= 1'b0;
				end 
			else if (state == M1_GRANT)
				begin
					m0_grant <= 1'b0;
					m1_grant <= 1'b1;
				end
			else //wrong state
				begin
					m0_grant <= 1'bx;
					m1_grant <= 1'bx;
				end
		end
	//output logic
endmodule 