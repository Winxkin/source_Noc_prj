`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HCMUTE
// Engineer: Huan Nguyen Duy
// 
// Create Date:    13:28:15 11/27/2022 
// Design Name: 
// Module Name:    FIFO_Buffer 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: FIFO buffer is stored packet (Top module:  Input Channel Module)
//
// Dependencies: 
// 
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// Check : Oke
//////////////////////////////////////////////////////////////////////////////////
module FIFO_Buffer
#(parameter DATA_WIDTH = 8,
  parameter ADD_BIT = 2) /*2^ADD_BIT = 4 => FIFO[3:0]*/
(input [DATA_WIDTH-1:0] Data_in,
 input clk, rst, write, read,
 output [DATA_WIDTH-1:0] Data_out,
 output empty, full
 );
 
 reg [DATA_WIDTH-1:0] fifo[2**ADD_BIT-1:0]; 
 reg [ADD_BIT-1:0] rd_ptr_reg, rd_ptr_next, rd_ptr_succ;
 reg [ADD_BIT-1:0] wr_ptr_reg, wr_ptr_next, wr_ptr_succ;
 reg full_reg, full_next, empty_reg, empty_next;
 wire wr_en;
 
 
 always@(posedge clk)
	begin
		if(wr_en)
			fifo[wr_ptr_reg] <= Data_in;	
	end
		
//assign output data
assign Data_out = fifo[rd_ptr_reg];
//check buffer not full
assign wr_en = write & (~full_reg);

//fifo control logic
//register for read and write pointers
always@(posedge clk, posedge rst)
	begin
		if(rst)
			begin
				rd_ptr_reg <= 0;
				wr_ptr_reg <= 0;
				full_reg <= 1'b0;
				empty_reg <= 1'b1;
			end
		else
			begin
				rd_ptr_reg <= rd_ptr_next;
				wr_ptr_reg <= wr_ptr_next;
				full_reg <= full_next;
				empty_reg <= empty_next;
			end

	end
	
//next state logic for read and write pointers
always @*
	begin
	
		// successive pointer values
		rd_ptr_succ = rd_ptr_reg + 1;
		wr_ptr_succ = wr_ptr_reg + 1;
		//default: keep old value
		wr_ptr_next = wr_ptr_reg;
		rd_ptr_next = rd_ptr_reg;
		full_next = full_reg;
		empty_next = empty_reg;
		
		case({write,read})
			2'b01: //read
				if(~empty_reg) //not empty
					begin
						rd_ptr_next = rd_ptr_succ;
						full_next = 1'b0;
						if(rd_ptr_succ == wr_ptr_reg)
							empty_next = 1'b1;
					end
			2'b10: //write
				if(~full_reg) // not full
					begin
						wr_ptr_next = wr_ptr_succ;
						empty_next = 1'b0;
						if(wr_ptr_succ == rd_ptr_reg)
							full_next = 1'b1;
					end
			2'b11: //read and write
				begin 
					rd_ptr_next = rd_ptr_succ;
					wr_ptr_next = wr_ptr_succ;
				end
		endcase
	end

//output
assign full = full_reg;
assign empty = empty_reg;

endmodule
