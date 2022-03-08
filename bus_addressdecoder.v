module bus_addressdecoder(address, sel);
	input[15:0] address;
	output reg[4:0] sel;
	
	wire[7:0] upper_8bit = address[15:8];
	
	always @ (upper_8bit)
		begin
			if(upper_8bit == 3'b0000_0000)
				sel = 5'b10000; //when s0 is selected
			else if(upper_8bit == 3'b0000_0001)
				sel = 5'b01000; //when s1 is selected
			else if(upper_8bit == 3'b0000_0010)
				sel = 5'b00100; //when s2 is selected
			else if(upper_8bit == 3'b0000_0011)
				sel = 5'b00010; //when s3 is selected
			else if(upper_8bit == 3'b0000_0100)
				sel = 5'b00001; //when s4 is selected
			else
				sel = 5'b00000; //when no slave is selected (wrong slave address)
		end 
				
	//memory map
	//s0 = 0000 0000 0000 0000 ~ 0000 0000 0001 1111
	//s1 = 0000 0001 0000 0000 ~ 0000 0001 0001 1111
	//s2 = 0000 0010 0000 0000 ~ 0000 0010 0011 1111
	//s3 = 0000 0011 0000 0000 ~ 0000 0011 0011 1111
	//s4 = 0000 0100 0000 0000 ~ 0000 0100 0011 1111
endmodule 