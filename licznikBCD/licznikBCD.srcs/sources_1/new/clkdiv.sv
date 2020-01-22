`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2020 03:11:55 PM
// Design Name: 
// Module Name: clkdiv
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


module clkdiv #(parameter div = 50000000)(
    input clk, 
    input rst,
    output reg slow_clk 
    );
    
    localparam N = $clog2(div);
    reg [N-1:0] counter; 
    
    
    always @(posedge clk, posedge rst)
        if(rst)
            counter <= {N{1'b0}}; 
        else 
            if(counter == div)  
                counter <= {N{1'b0}};
            else 
                counter <= counter + 1;
                
    always @(posedge clk, posedge rst)
        if(rst)
            slow_clk <= 1'b0;
        else
            if(counter == {N{1'b0}})
                slow_clk <= ~slow_clk;
                
endmodule
