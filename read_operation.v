module read_operation (Addr, Data, from_reg0, from_reg1, from_reg2, from_reg3, from_reg4, from_reg5, from_reg6, from_reg7);
	input[31:0] from_reg0, from_reg1, from_reg2, from_reg3, from_reg4, from_reg5, from_reg6, from_reg7;
	input[2:0] Addr;
	output[31:0] Data;
	
	_8_to_1_MUX _8_to_1_MUX_1(from_reg0,from_reg1,from_reg2,from_reg3,from_reg4,from_reg5,from_reg6,from_reg7,Addr,Data);
	//data will be only one from_reg value depending on Addr
	
endmodule 