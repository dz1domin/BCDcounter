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


module tb_licznik(
    );

    /*
    module licznikBCD #(parameter decades=4)
        (
            input clk, rst, wire signal, up, generator,
            output wire [4 * decades - 1:0] cout
        );
    */
    localparam DECADES = 4;

    reg clk, rst;
    reg signal, up, generator;
    wire [4 * DECADES - 1:0] cout;
    wire gsr = glbl.GSR;
    
    
    licznikBCD#(.decades(DECADES)) uut(.clk(clk), .rst(rst), .signal(signal), .up(up), .generator(generator), .cout(cout));
    

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
    
    initial generator = 0;
    always @(negedge clk) generator = {$random} % 2;
    
    initial begin
        up = 1;
        @(negedge gsr);
        forever #2000 up = ~up; 
    end
    
    initial signal = 0;
    
endmodule
