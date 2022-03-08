`timescale 1ns/100ps

module tb_fifo;
	reg clk, reset_n, rd_en, wr_en;
	reg[31:0] d_in;
	wire[31:0] d_out;
	wire full, empty, wr_ack, wr_err, rd_ack, rd_err;
	wire[4:0] data_count;
	
	fifo_16 fifo_16_1(clk, reset_n, rd_en, wr_en, d_in, d_out, full, empty, wr_ack, wr_err, rd_ack, rd_err, data_count);
	
	always
		begin
			#5; clk = ~clk; //cycle of clk is 10ns
		end
	
	initial
		begin
			#4; clk = 0; reset_n = 1; rd_en = 0; wr_en = 0; d_in = 0; #10;
			reset_n = 0; #10; reset_n = 1; #10; //resetted
			
			rd_en = 1; wr_en = 0; #10; //read but nothing is writted (read error)
			rd_en = 0; wr_en = 1; d_in = 10000000; #10;
			d_in = 20000000; #10;
			d_in = 30000000; #10;
			d_in = 40000000; #10; //write 4 values (count = 4)
			rd_en = 1; wr_en = 0; #20;
			//#100; //read 2 values (count = 2)
			rd_en = 0; wr_en = 1; d_in = 50000000; #10;
			d_in = 60000000; #10;
			d_in = 70000000; #10;
			d_in = 80000000; #10; //write 4 values (count = 6)
			rd_en = 1; wr_en = 0; #20;
			//#100; //read 2 values (count = 4)
			rd_en = 0; wr_en = 1; d_in = 90000000; #10;
			d_in = 100000000; #10;
			d_in = 110000000; #10;
			d_in = 120000000; #10; //write 4 values (count = 8)
			
			rd_en = 0; wr_en = 1; d_in = 10000000; #10;
			d_in = 20000000; #10;
			d_in = 30000000; #10;
			d_in = 40000000; #10; //write 4 values (count = 12)
			rd_en = 1; wr_en = 0; #20;
			//#100; //read 2 values (count = 10)
			rd_en = 0; wr_en = 1; d_in = 50000000; #10;
			d_in = 60000000; #10;
			d_in = 70000000; #10;
			d_in = 80000000; #10; //write 4 values (count = 14)
			rd_en = 1; wr_en = 0; #20;
			//#100; //read 2 values (count = 2)
			rd_en = 0; wr_en = 1; d_in = 90000000; #10;
			d_in = 100000000; #10;
			d_in = 110000000; #10;
			d_in = 120000000; #10; //write 4 values (count = 16)
			
			d_in = 130000000; #10; //write but everything is writted (write error)
		end 
endmodule 