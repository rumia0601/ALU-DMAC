`timescale 1ns/100ps

module tb_DMAC;
	reg clk, reset_n, m_grant;
	reg[31:0] m_din;
	reg s_sel, s_wr;
	reg[15:0] s_address;
	reg[31:0] s_din;
	wire m_req;
	wire m_wr;
	wire[15:0] m_address;
	wire[31:0] m_dout;
	wire[31:0] s_dout;
	wire s_interrupt;
	
	DMAC_Top DMAC_TOP1(clk, reset_n, m_grant, m_din, s_sel, s_wr, s_address, s_din, m_req, m_wr, m_address, m_dout, s_dout, s_interrupt);

	always
		begin
			#5; clk = ~clk; //cycle of clk is 10ns
		end
		
	//DMAC = 0000 - 001F
	//ALU = 0100 - 011F
	//OPERAND = 0200 - 023F
	//INSTRUCTION = 0300 - 033F
	//RESULT = 0400 - 043F
		
	//OPERATION_START = 0000
	//INTERRUPT = 0001
	//INTERRUPT_ENABLE = 0002
	//SOURCE_ADDRESS = 0003
	//DESTINATION_ADDRESS = 0004
	//DATA_SIZE = 0005
	//DESCRIPTOR_SIZE = 0006
	//DESCRIPTOR_PUSH = 0007
	//OPERATION_MODE = 0008
	//DMA_STATUS = 0009
		
	initial
		begin
			#4; clk = 1'b0; reset_n = 1'b1; m_grant = 1'b0; m_din = 32'h0000_0000; s_sel = 1'b0; s_wr = 1'b0; s_address = 16'h0000; s_din = 32'h0000_0000; #10;
			reset_n = 1'b0; #10; reset_n = 1'b1; #10; //reset
			
			s_sel = 1'b1; s_wr = 1'b1; s_address = 16'h0003; s_din = 16'h0200; #10; s_wr = 1'b0; #10;
			//write source_address to DMAC
			s_wr = 1'b1; s_address = 16'h0004; s_din = 16'h0300; #10; s_wr = 1'b0; #10;
			//write destination_address to DMAC
			s_wr = 1'b1; s_address = 16'h0005; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write data_size to DMAC
			s_wr = 1'b1; s_address = 16'h0006; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write descriptor_push to DMAC
			//and push 3 data into fifo
			//1
			
			s_sel = 1'b1; s_wr = 1'b1; s_address = 16'h0003; s_din = 16'h0204; #10; s_wr = 1'b0; #10;
			//write source_address to DMAC
			s_wr = 1'b1; s_address = 16'h0004; s_din = 16'h0304; #10; s_wr = 1'b0; #10;
			//write destination_address to DMAC
			s_wr = 1'b1; s_address = 16'h0005; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write data_size to DMAC
			s_wr = 1'b1; s_address = 16'h0006; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write descriptor_push to DMAC
			//and push 3 data into fifo
			//2
			
			s_sel = 1'b1; s_wr = 1'b1; s_address = 16'h0003; s_din = 16'h0208; #10; s_wr = 1'b0; #10;
			//write source_address to DMAC
			s_wr = 1'b1; s_address = 16'h0004; s_din = 16'h0308; #10; s_wr = 1'b0; #10;
			//write destination_address to DMAC
			s_wr = 1'b1; s_address = 16'h0005; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write data_size to DMAC
			s_wr = 1'b1; s_address = 16'h0006; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write descriptor_push to DMAC
			//and push 3 data into fifo
			//3
			
			s_sel = 1'b1; s_wr = 1'b1; s_address = 16'h0003; s_din = 16'h020C; #10; s_wr = 1'b0; #10;
			//write source_address to DMAC
			s_wr = 1'b1; s_address = 16'h0004; s_din = 16'h030C; #10; s_wr = 1'b0; #10;
			//write destination_address to DMAC
			s_wr = 1'b1; s_address = 16'h0005; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write data_size to DMAC
			s_wr = 1'b1; s_address = 16'h0006; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write descriptor_push to DMAC
			//and push 3 data into fifo
			//4
			
			s_sel = 1'b1; s_wr = 1'b1; s_address = 16'h0003; s_din = 16'h0210; #10; s_wr = 1'b0; #10;
			//write source_address to DMAC
			s_wr = 1'b1; s_address = 16'h0004; s_din = 16'h0310; #10; s_wr = 1'b0; #10;
			//write destination_address to DMAC
			s_wr = 1'b1; s_address = 16'h0005; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write data_size to DMAC
			s_wr = 1'b1; s_address = 16'h0006; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write descriptor_push to DMAC
			//and push 3 data into fifo
			//5
			
			s_sel = 1'b1; s_wr = 1'b1; s_address = 16'h0003; s_din = 16'h0214; #10; s_wr = 1'b0; #10;
			//write source_address to DMAC
			s_wr = 1'b1; s_address = 16'h0004; s_din = 16'h0314; #10; s_wr = 1'b0; #10;
			//write destination_address to DMAC
			s_wr = 1'b1; s_address = 16'h0005; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write data_size to DMAC
			s_wr = 1'b1; s_address = 16'h0006; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write descriptor_push to DMAC
			//and push 3 data into fifo
			//6
			
			s_sel = 1'b1; s_wr = 1'b1; s_address = 16'h0003; s_din = 16'h0218; #10; s_wr = 1'b0; #10;
			//write source_address to DMAC
			s_wr = 1'b1; s_address = 16'h0004; s_din = 16'h0318; #10; s_wr = 1'b0; #10;
			//write destination_address to DMAC
			s_wr = 1'b1; s_address = 16'h0005; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write data_size to DMAC
			s_wr = 1'b1; s_address = 16'h0006; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write descriptor_push to DMAC
			//and push 3 data into fifo
			//7
			
			s_sel = 1'b1; s_wr = 1'b1; s_address = 16'h0003; s_din = 16'h021C; #10; s_wr = 1'b0; #10;
			//write source_address to DMAC
			s_wr = 1'b1; s_address = 16'h0004; s_din = 16'h031C; #10; s_wr = 1'b0; #10;
			//write destination_address to DMAC
			s_wr = 1'b1; s_address = 16'h0005; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write data_size to DMAC
			s_wr = 1'b1; s_address = 16'h0006; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write descriptor_push to DMAC
			//and push 3 data into fifo
			//8
			
			s_sel = 1'b1; s_wr = 1'b1; s_address = 16'h0003; s_din = 16'h0200; #10; s_wr = 1'b0; #10;
			//write source_address to DMAC
			s_wr = 1'b1; s_address = 16'h0004; s_din = 16'h0300; #10; s_wr = 1'b0; #10;
			//write destination_address to DMAC
			s_wr = 1'b1; s_address = 16'h0005; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write data_size to DMAC
			s_wr = 1'b1; s_address = 16'h0006; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write descriptor_push to DMAC
			//and push 3 data into fifo
			//9
			
			s_sel = 1'b1; s_wr = 1'b1; s_address = 16'h0003; s_din = 16'h0204; #10; s_wr = 1'b0; #10;
			//write source_address to DMAC
			s_wr = 1'b1; s_address = 16'h0004; s_din = 16'h0304; #10; s_wr = 1'b0; #10;
			//write destination_address to DMAC
			s_wr = 1'b1; s_address = 16'h0005; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write data_size to DMAC
			s_wr = 1'b1; s_address = 16'h0006; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write descriptor_push to DMAC
			//and push 3 data into fifo
			//10
			
			s_sel = 1'b1; s_wr = 1'b1; s_address = 16'h0003; s_din = 16'h0208; #10; s_wr = 1'b0; #10;
			//write source_address to DMAC
			s_wr = 1'b1; s_address = 16'h0004; s_din = 16'h0308; #10; s_wr = 1'b0; #10;
			//write destination_address to DMAC
			s_wr = 1'b1; s_address = 16'h0005; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write data_size to DMAC
			s_wr = 1'b1; s_address = 16'h0006; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write descriptor_push to DMAC
			//and push 3 data into fifo
			//11
			
			s_sel = 1'b1; s_wr = 1'b1; s_address = 16'h0003; s_din = 16'h020C; #10; s_wr = 1'b0; #10;
			//write source_address to DMAC
			s_wr = 1'b1; s_address = 16'h0004; s_din = 16'h030C; #10; s_wr = 1'b0; #10;
			//write destination_address to DMAC
			s_wr = 1'b1; s_address = 16'h0005; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write data_size to DMAC
			s_wr = 1'b1; s_address = 16'h0006; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write descriptor_push to DMAC
			//and push 3 data into fifo
			//12
			
			s_sel = 1'b1; s_wr = 1'b1; s_address = 16'h0003; s_din = 16'h0210; #10; s_wr = 1'b0; #10;
			//write source_address to DMAC
			s_wr = 1'b1; s_address = 16'h0004; s_din = 16'h0310; #10; s_wr = 1'b0; #10;
			//write destination_address to DMAC
			s_wr = 1'b1; s_address = 16'h0005; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write data_size to DMAC
			s_wr = 1'b1; s_address = 16'h0006; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write descriptor_push to DMAC
			//and push 3 data into fifo
			//13
			
			s_sel = 1'b1; s_wr = 1'b1; s_address = 16'h0003; s_din = 16'h0214; #10; s_wr = 1'b0; #10;
			//write source_address to DMAC
			s_wr = 1'b1; s_address = 16'h0004; s_din = 16'h0314; #10; s_wr = 1'b0; #10;
			//write destination_address to DMAC
			s_wr = 1'b1; s_address = 16'h0005; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write data_size to DMAC
			s_wr = 1'b1; s_address = 16'h0006; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write descriptor_push to DMAC
			//and push 3 data into fifo
			//14
			
			s_sel = 1'b1; s_wr = 1'b1; s_address = 16'h0003; s_din = 16'h0218; #10; s_wr = 1'b0; #10;
			//write source_address to DMAC
			s_wr = 1'b1; s_address = 16'h0004; s_din = 16'h0318; #10; s_wr = 1'b0; #10;
			//write destination_address to DMAC
			s_wr = 1'b1; s_address = 16'h0005; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write data_size to DMAC
			s_wr = 1'b1; s_address = 16'h0006; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write descriptor_push to DMAC
			//and push 3 data into fifo
			//15
			
			s_sel = 1'b1; s_wr = 1'b1; s_address = 16'h0003; s_din = 16'h021C; #10; s_wr = 1'b0; #10;
			//write source_address to DMAC
			s_wr = 1'b1; s_address = 16'h0004; s_din = 16'h031C; #10; s_wr = 1'b0; #10;
			//write destination_address to DMAC
			s_wr = 1'b1; s_address = 16'h0005; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write data_size to DMAC
			s_wr = 1'b1; s_address = 16'h0006; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write descriptor_push to DMAC
			//and push 3 data into fifo
			//16
			
			s_wr = 1'b1; s_address = 16'h0000; s_din = 16'h0001; #10; s_wr = 1'b0; s_sel = 1'b0; #10;
			//write operation_start to DMAC
			//and master begin to work
			
			m_grant = 1'b1;
			m_din = 32'h1234_5678; #200;
			m_din = 32'h9012_3456; #200;
			m_din = 32'h7890_1234; #200;
			m_din = 32'h5678_9012; #200;
			
			m_din = 32'h1111_1111; #200;
			m_din = 32'h2222_2222; #200;
			m_din = 32'h3333_3333; #200;
			m_din = 32'h4444_4444; #200;
			//master read data from bus
			
			//master write data to bus
			
			/*
			#4; clk = 1'b0; reset_n = 1'b1; m_grant = 1'b0; m_din = 32'h0000_0000; s_sel = 1'b0; s_wr = 1'b0; s_address = 16'h0000; s_din = 32'h0000_0000; #10;
			reset_n = 1'b0; #10; reset_n = 1'b1; #10; //reset
			
			s_sel = 1'b1; s_wr = 1'b1; s_address = 16'h0003; s_din = 16'h0200; #10; s_wr = 1'b0; #10;
			//write source_address to DMAC
			s_wr = 1'b1; s_address = 16'h0004; s_din = 16'h0300; #10; s_wr = 1'b0; #10;
			//write destination_address to DMAC
			s_wr = 1'b1; s_address = 16'h0005; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write data_size to DMAC
			s_wr = 1'b1; s_address = 16'h0006; s_din = 16'h0001; #10; s_wr = 1'b0; #10;
			//write descriptor_push to DMAC
			//and push 3 data into fifo
			//1
			
			s_wr = 1'b1; s_address = 16'h0000; s_din = 16'h0001; #10; s_wr = 1'b0; s_sel = 1'b0; #10;
			//write operation_start to DMAC
			//and master begin to work
			
			m_grant = 1'b1;
			m_din = 32'h1234_5678; #200;
			//master read data from bus
			*/
		end
endmodule 