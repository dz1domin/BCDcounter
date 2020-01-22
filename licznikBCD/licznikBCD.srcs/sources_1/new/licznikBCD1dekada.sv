`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2019 02:16:57 PM
// Design Name: 
// Module Name: licznikBCD1dekada
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


module licznikBCD1dekada
    (
        input clk, rst, wire signal, up,
        output reg ovl, output reg[3:0] out
    );
    
    always@(posedge clk, posedge rst)
    if(rst)
        out <= 4'b0;
    else if(signal && up)
        out <= (out == 4'd9) ? 4'b0 : out + 1'b1;
    else if(signal && ~up)
        out <= (out == 4'b0) ? 4'd9 : out - 1'b1;
            
    always@(posedge clk, posedge rst)
    if(rst)
        ovl <= 1'b0;
    else if(up)
        ovl <= (out == 4'd9) ? 1'b1 : 1'b0;
    else if(~up)
        ovl <= (out == 4'b0) ? 1'd1 : 1'b0;
   
endmodule

// to ponizej dziala dla generatora
//module licznikBCD1dekada
//    (
//        input clk, rst, wire [1:0] signal,
//        output reg ovl, output reg[3:0] out
//    );
    
//    always@(posedge clk, posedge rst)
//    if(rst)
//        out <= 4'b0;
//    else if(signal[1])
//        out <= (out == 4'd9) ? 4'b0 : out + 1'b1;
////    else if(signal[0])
////        out <= (out == 4'b0) ? 4'd9 : out - 1'b1;
            
//    always@(posedge clk, posedge rst)
//    if(rst)
//        ovl <= 1'b0;
//    else
//        ovl <= (out == 4'd9) ? 1'b1 : 1'b0;
   
//endmodule
