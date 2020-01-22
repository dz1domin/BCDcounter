`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2019 01:28:54 PM
// Design Name: 
// Module Name: device
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


module device(
        input clk, rst, inputA, inputB, gen, 
        output sclk, sdout, dco, vdd, vbat, res
    );
    localparam DECADES = 4;
    localparam SIZE = $clog2({DECADES{4'd9}});
    reg [SIZE:0] input_number;
    reg [DECADES * 4 - 1: 0] ready_output_number;
    wire enA, slow_clk, filteredA, filteredB, enGen;

    oled_top top(.clk(clk), .rst(rst), .sclk(sclk), .sdout(sdout), .vdd(vdd), .vbat(vbat), .res(res), .number(ready_output_number), .dco(dco));
        
    edge_detector e_A(.clk(clk), .rst(rst), .a(filteredA), .en(enA));
    edge_detector e_gen(.clk(clk), .rst(rst), .a(gen), .en(enGen));
    
    clkdiv#(.div(100000)) div(.clk(clk), .rst(rst), .slow_clk(slow_clk));

    filter fA(.clk(slow_clk), .rst(rst), .cx(inputA), .y(filteredA));
    filter fB(.clk(slow_clk), .rst(rst), .cx(inputB), .y(filteredB));
    


    licznikBCD#(.decades(DECADES)) licznik(.clk(clk), .rst(rst), .signal(enA), .up(~filteredB), .generator(enGen), .cout(ready_output_number));
    
endmodule
