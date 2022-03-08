module Register_file(clk, reset_n, wAddr, wData, we, rAddr, rData);
	input clk, reset_n, we;
	input[2:0] wAddr, rAddr;
	input[31:0] wData;
	output[31:0] rData;
	
	wire[7:0] to_reg;
	wire[31:0] from_reg[7:0]; //bus of bus (256 bits)
	
	write_operation write_operation_1(wAddr,we,to_reg); //determine which register to write
	register32_8 register32_8_1(clk,reset_n,to_reg,wData,from_reg[0],from_reg[1],from_reg[2],from_reg[3],from_reg[4],from_reg[5],from_reg[6],from_reg[7]); //write and read register
	read_operation read_operation_1(rAddr,rData,from_reg[0],from_reg[1],from_reg[2],from_reg[3],from_reg[4],from_reg[5],from_reg[6],from_reg[7]); //determine which register to read
endmodule 