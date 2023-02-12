`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:27:22 12/04/2022 
// Design Name: 
// Module Name:    switch 
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
module switch
#(parameter N_BIT_SEL = 3,
  parameter N_REGISTER = 3,
  parameter DATA_WIDTH = 8)
(input [DATA_WIDTH-1:0] In_L, In_N, In_E, In_W, In_S,
 output [DATA_WIDTH-1:0] Out_L, Out_N, Out_E, Out_W, Out_S,
 input clk, rst,
 input [N_REGISTER-1:0] request_L, request_N, request_E, request_S, request_W,
 output grant_L,grant_N,grant_E,grant_S,grant_W,
 input full_L, full_N, full_E, full_S, full_W /*notify from Output controler is buffer out has full*/
    );

wire [N_BIT_SEL-1:0] select_L, select_N, select_E, select_S, select_W;

crossbar ST (.In_L(In_L),.In_N(In_N),.In_E(In_E),.In_W(In_W),.In_S(In_S),
					.Out_L(Out_L),.Out_N(Out_N),.Out_E(Out_E),.Out_W(Out_W),.Out_S(Out_S),
					.Select_L(select_L),.Select_N(select_N),.Select_E(select_E),.Select_S(select_S),.Select_W(select_W));
					

switch_atriber SA (.clk(clk),.rst(rst),
							.select_L(select_L),.select_N(select_N),.select_E(select_E),.select_S(select_S),.select_W(select_W),
							.request_L(request_L),.request_N(request_N),.request_E(request_E),.request_S(request_S),.request_W(request_W),
							.grant_L(grant_L),.grant_N(grant_N),.grant_E(grant_E),.grant_S(grant_S),.grant_W(grant_W),
							.full_L(full_L),.full_N(full_N),.full_E(full_E),.full_S(full_S),.full_W(full_W));


endmodule
