`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HCMUTE
// Engineer: Huan Nguyen Duy
// 
// Create Date:    15:58:12 12/18/2022 
// Design Name: 
// Module Name:    output_controler 
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
//
//////////////////////////////////////////////////////////////////////////////////
module output_controller
#(parameter DATA_WIDTH = 8)
(

input ret, /*mapping with full signal from neghbour router*/
output full_ret, /*passing the ret signal from block input to SW*/ 
input [DATA_WIDTH-1:0] Data_in,
output [DATA_WIDTH-1:0] Data_out,
output val /*notify for OFC that are not data at input | free = 1 => Having not data*/
 );

assign Data_out = Data_in;
assign val = (ret == 0 && Data_in!= 0) ? 1'b1 : 1'b0; /*mapping to val*/
assign full_ret = ret;
endmodule
