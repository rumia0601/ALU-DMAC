module ALU_registerfile(clk, reset_n, wAddr, wData, we, rAddr, rData); //register file with 16 data
	input clk, reset_n, we;
	input[3:0] wAddr, rAddr;
	input[31:0] wData;
	output reg[31:0] rData;
	
	reg[31:0] data0; 
	reg[31:0] data1;
	reg[31:0] data2;
	reg[31:0] data3;
	reg[31:0] data4;
	reg[31:0] data5;
	reg[31:0] data6;
	reg[31:0] data7;
	reg[31:0] data8;
	reg[31:0] data9;
	reg[31:0] data10;
	reg[31:0] data11;
	reg[31:0] data12;
	reg[31:0] data13;
	reg[31:0] data14;
	reg[31:0] data15;//16 data
	
	always @ (posedge clk or negedge reset_n)
		begin
			if (reset_n == 1'b0)
				begin
					data0 = 32'h0000_0000;
					data1 = 32'h0000_0000;
					data2 = 32'h0000_0000;
					data3 = 32'h0000_0000;
					data4 = 32'h0000_0000;
					data5 = 32'h0000_0000;
					data6 = 32'h0000_0000;
					data7 = 32'h0000_0000;
					data8 = 32'h0000_0000;
					data9 = 32'h0000_0000;
					data10 = 32'h0000_0000;
					data11 = 32'h0000_0000;
					data12 = 32'h0000_0000;
					data13 = 32'h0000_0000;
					data14 = 32'h0000_0000;
					data15 = 32'h0000_0000; //reset all data
				end 
			
			else if (clk == 1'b1)
				begin
					if (we == 1'b1) //write
						begin
							case(wAddr)
								4'b0000 : data0 = wData;
								4'b0001 : data1 = wData;
								4'b0010 : data2 = wData;
								4'b0011 : data3 = wData;
								4'b0100 : data4 = wData;
								4'b0101 : data5 = wData;
								4'b0110 : data6 = wData;
								4'b0111 : data7 = wData;
								4'b1000 : data8 = wData;
								4'b1001 : data9 = wData;
								4'b1010 : data10 = wData;
								4'b1011 : data11 = wData;
								4'b1100 : data12 = wData;
								4'b1101 : data13 = wData;
								4'b1110 : data14 = wData;
								4'b1111 : data15 = wData;
							endcase 
						end
						
					else if (we == 1'b0) //read
						begin
							case(rAddr)
								4'b0000 : rData = data0;
								4'b0001 : rData = data1;
								4'b0010 : rData = data2;
								4'b0011 : rData = data3;
								4'b0100 : rData = data4;
								4'b0101 : rData = data5;
								4'b0110 : rData = data6;
								4'b0111 : rData = data7;
								4'b1000 : rData = data8;
								4'b1001 : rData = data9;
								4'b1010 : rData = data10;
								4'b1011 : rData = data11;
								4'b1100 : rData = data12;
								4'b1101 : rData = data13;
								4'b1110 : rData = data14;
								4'b1111 : rData = data15;
							endcase 
						end
				end
		end 
endmodule 