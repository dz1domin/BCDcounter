`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2019 01:26:30 PM
// Design Name: 
// Module Name: licznikBCD
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


module licznikBCD #(parameter decades=4)
    (
        input clk, rst, wire signal, up, generator,
        output wire [4 * decades - 1:0] cout
    );
    
   wire[decades - 1:0] ovll;
   wire enn[decades:0];
   genvar i;
    
   assign enn[0] = signal | generator;
   
   generate for (i = 0; i < decades; i = i + 1) begin: dekada
       assign enn[i + 1] = ovll[i] & enn[i];
       licznikBCD1dekada licz(.clk(clk), .rst(rst), .signal(enn[i]), .up(up), .ovl(ovll[i]), .out(cout[4 * i + 3:4 * i]));
   end
   endgenerate 
endmodule
