`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HCMUTE
// Engineer: Huan Nguyen Duy
// 
// Create Date:    20:49:12 11/28/2022 
// Design Name: 
// Module Name:    input_controler 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// check : ok
//////////////////////////////////////////////////////////////////////////////////
module input_controler
#(parameter DATA_WIDTH = 8,
  parameter N_REGISTER = 3,
  parameter N_ADD = 2)
(input [N_ADD-1:0] X_cur,Y_cur,
 input [DATA_WIDTH-1:0] Data_in,
 output reg [DATA_WIDTH-1:0] Data_out,
 input empty,grant,
 input clk,rst,
 output wire read,
 output reg [N_REGISTER-1:0] register
 );
 
reg [N_ADD-1:0] x_add_cur,y_add_cur;
reg [DATA_WIDTH-1:0] data_reg;
reg [N_ADD-1:0] x_add_des,y_add_des;
localparam [N_REGISTER-1:0] not_register = 3'b111;
	
always@(posedge clk, posedge rst)
	begin
		if(rst)
			begin
				x_add_cur = X_cur;
				y_add_cur = Y_cur;
				Data_out = 0;
				register = not_register;
			end
		else
			begin
				if(empty == 0)
				begin
					data_reg = Data_in;
					x_add_des = {data_reg[1],data_reg[0]}; //get x_des address
					y_add_des = {data_reg[3],data_reg[2]}; //get y_des address
					Data_out = data_reg;
					/*XY routing*/
					if(x_add_des == x_add_cur)
						begin
							if(y_add_des == y_add_cur)
								register = 3'b000; /*output = local*/
							else
								begin
									if(y_add_des > y_add_cur)
										register = 3'b011; /*output = N top*/
									if(y_add_des < y_add_cur)
										register = 3'b100; /*output = S bottom*/
								end
						end
					else
						begin
							if(x_add_des > x_add_cur)
								register = 3'b001; /*output = E ->*/
							if(x_add_des < x_add_cur)
								register = 3'b010; /*output = W <-*/
						end
				end
				if(empty == 1)
					begin
						Data_out = 0;
						register = not_register;
					end
			end
	end
	
assign read = (rst == 0 && empty == 0 && grant == 1) ? 1'b1 : 1'b0;

endmodule
