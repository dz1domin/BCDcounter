`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2020 03:05:55 PM
// Design Name: 
// Module Name: debounce
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module filter #(parameter N=3) (input clk, rst, cx, 
		output reg y);

reg [N:0] q;

always @(posedge clk, posedge rst)
	if (rst)
		begin q <= {(N+1){1'b0}}; y <= 1'b0; end
	else begin
		case(q[N:1])
			{N{1'b1}}: y <= 1'b1;
			{N{1'b0}}: y <= 1'b0;
			default: ;
		endcase
		q <= {q[N-1:0], cx};
	end
 
endmodule
