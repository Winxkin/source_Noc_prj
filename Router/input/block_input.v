`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HCMUTE
// Engineer: Huan Nguyen Duy
// 
// Create Date:    15:27:40 12/01/2022 
// Design Name: 
// Module Name:    block_input 
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
// check: oke
//////////////////////////////////////////////////////////////////////////////////
module block_input
#(parameter DATA_WIDTH = 8,
  parameter N_REGISTER = 3,
  parameter N_ADD = 2)
(
input [N_ADD-1:0] X_cur,Y_cur,  /*address of router in networt on chip*/
input clk,rst,
input grant, /*check to transfer data from buffer in to switch | grant=1 to send*/
input val,  /*signal request sent package from neighbor router*/
output ret, /*ack for neighbor router know that buffer is full or not*/
input [DATA_WIDTH-1:0]Data_in, /*outside*/
output [DATA_WIDTH-1:0]Data_out,
output [N_REGISTER-1:0] register /*notify for switch to determined the destination of package */ /*->Roud robin*/
    );
/*define wire*/
wire write_wire, read_wire;
wire empty_wire,full_wire; 
wire [DATA_WIDTH-1:0]Data_bus;
/*connect block module*/
input_flow_control IFC(.val(val),.full(full_wire),.ret(ret),.write(write_wire));

FIFO_Buffer BUFFER(.Data_in(Data_in),
							.clk(clk),.rst(rst),
							.write(write_wire),.read(read_wire),
							.empty(empty_wire),.full(full_wire),
							.Data_out(Data_bus));

input_controler RC(.X_cur(X_cur),.Y_cur(Y_cur),
							.Data_in(Data_bus),.Data_out(Data_out),
							.clk(clk),.rst(rst),
							.register(register),.read(read_wire),
							.empty(empty_wire),.grant(grant));

endmodule
