`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HCMUTE
// Engineer: Huan Nguyen Duy
// 
// Create Date:    14:32:46 11/27/2022 
// Design Name: 
// Module Name:    input_flow_control 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: using flow control data from packet (top module: Input Channel Module)
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// Check : Not yet
//////////////////////////////////////////////////////////////////////////////////
module input_flow_control
(input val,full,
 output ret,write
 );

	
assign write = (full == 0 && val == 1)? 1'b1 : 1'b0;
assign ret = full;
endmodule
