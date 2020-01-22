`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2019 02:19:43 PM
// Design Name: 
// Module Name: tb_top
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


module tb_clkdiv(
    );

    reg clk, rst, slow_clk;
    wire gsr = glbl.GSR;

    localparam DIV = 1000;

    clkdiv#(.div(DIV)) uut(.clk(clk), .rst(rst), .slow_clk(slow_clk)); 
    

    initial begin
        clk = 0;
        @(negedge gsr);
        forever #5 clk = ~clk;
    end
    
    initial begin
        rst = 1'b1;
        @(negedge gsr);
        #5 rst = 1'b0;
    end
    
    
    
endmodule
