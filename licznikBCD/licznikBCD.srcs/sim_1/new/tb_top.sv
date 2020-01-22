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


module tb_top(
    );

    reg clk, rst, gen, inputA, inputB;
    wire sclk, sdout, dco, vdd, vbat, res;
    wire gsr = glbl.GSR;

    device uut (.clk(clk), .rst(rst), .inputA(inputA), .inputB(inputB), .gen(gen), .sclk(sclk), 
        .sdout(sdout), .dco(dco), .vdd(vdd), .vbat(vbat), .res(res));

    initial begin
        gen = 1'b0;
        clk = 0;
        @(negedge gsr);
        forever #5 clk = ~clk;
    end

    
    initial begin
        rst = 1'b1;
        @(negedge gsr);
        #5 rst = 1'b0;
    end
    
    //always @(negedge clk) gen = {$random} % 2; // for generator testing
    initial begin
        inputA = 1;
        inputB = 1;
        @(negedge gsr);
        forever #10000000 begin
            
            inputA = 0;
            inputB = 1;
            #20 inputB = 0;
            #1 inputB = 1;
            #1 inputB = 0;
                        
            #20 inputA = 1;
            #1 inputA = 0;
            #1 inputA = 1;
            
            #20 inputB = 1;
            #1 inputB = 0;
            #1 inputB = 1;
            
            #20 inputA = 0;
            #1 inputA = 1;
            #1 inputA = 0;
            
            #20 inputB = 0;
            #1 inputB = 1;
            #1 inputB = 0;
            
            #20 inputA = 1;
            #1 inputA = 0;
            #1 inputA = 1;
            
            #20 inputB = 1;
            #20 inputA = 0;
        
        end
         
    end
        
    
    
    
    
endmodule
