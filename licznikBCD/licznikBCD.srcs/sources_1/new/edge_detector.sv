`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2020 01:51:44 PM
// Design Name: 
// Module Name: edge_detector
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


module edge_detector(
    input clk,
    input rst,
    input a,
    output en
    );
    
    reg [1:0] tmp;
    
    always @(posedge clk, posedge rst)
        begin
            if (rst)
                tmp <= 2'b00;
            else
                begin
                    tmp[1] <= a;
                    tmp[0] <= tmp[1];
                end
        end
    
    assign en = tmp[1] & ~tmp[0];
    
endmodule