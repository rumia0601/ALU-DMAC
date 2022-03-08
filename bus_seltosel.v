module bus_seltosel(slave_sel, select_sel);
	input[4:0] slave_sel;
	output reg[2:0] select_sel;

	always @ (slave_sel)
		begin
			case(slave_sel)
				(5'b00000) : select_sel = 3'b000; //no slave selected
				(5'b10000) : select_sel = 3'b001; //s0 selected
				(5'b01000) : select_sel = 3'b010; //s1 selected
				(5'b00100) : select_sel = 3'b011; //s2 selected
				(5'b00010) : select_sel = 3'b100; //s3 selected
				(5'b00001) : select_sel = 3'b101; //s4 selected
				default : select_sel = 3'bxxx; //wrong encoding (error)
			endcase 
		end
endmodule 