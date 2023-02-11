`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:11:53 11/27/2022 
// Design Name: 
// Module Name:    crossbar 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: crossbar 5 port in out for Router 5 port (local, north , east , west, south).
//
//		L(0)	 N(1)
//		
//      W(4)			E(2)
//
//			 	 S(3)
//
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
// Check : OK
//////////////////////////////////////////////////////////////////////////////////
module crossbar
#(parameter DATA_WIDTH = 8,
  parameter N_BIT_SEL = 3)
(input [DATA_WIDTH-1:0] In_L, In_N, In_E, In_W, In_S,
 output reg [DATA_WIDTH-1:0] Out_L, Out_N, Out_E, Out_W, Out_S,
 input[N_BIT_SEL-1:0] Select_L, Select_N,Select_E, Select_W, Select_S
    );


	always@(*)
		begin
				//local port
					case(Select_L)
						3'd0: Out_L = In_L;
						3'd1: Out_L = In_N;
						3'd2: Out_L = In_E;
						3'd3: Out_L = In_S;
						3'd4: Out_L = In_W;
						default: Out_L = 0;
					endcase
				//North port
					case(Select_N)
						3'd0: Out_N = In_L;
						3'd1: Out_N = In_N;
						3'd2: Out_N = In_E;
						3'd3: Out_N = In_S;
						3'd4: Out_N = In_W;
						default: Out_N = 0;
					endcase
				//West port
					case(Select_W)
						3'd0: Out_W = In_L;
						3'd1: Out_W = In_N;
						3'd2: Out_W = In_E;
						3'd3: Out_W = In_S;
						3'd4: Out_W = In_W;
						default: Out_W = 0;
					endcase
				//South port
					case(Select_S)
						3'd0: Out_S = In_L;
						3'd1: Out_S = In_N;
						3'd2: Out_S = In_E;
						3'd3: Out_S = In_S;
						3'd4: Out_S = In_W;
						default: Out_S = 0;
					endcase
				//Ease port
					case(Select_E)
						3'd0: Out_E = In_L;
						3'd1: Out_E = In_N;
						3'd2: Out_E = In_E;
						3'd3: Out_E = In_S;
						3'd4: Out_E = In_W;
						default: Out_E = 0;
					endcase
	
		end

endmodule
