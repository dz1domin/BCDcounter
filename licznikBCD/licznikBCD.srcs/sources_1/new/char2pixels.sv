`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module char2pixels(                  //ascii 8b,cnt_column 3b
    input clk, en, input [10:0] addr, output reg[7:0] data);

reg [7:0] memory [1023:0];

always @ (posedge clk)
    if(en) data <= memory[addr];
    
initial $readmemh("pixel_SSD1306.dat", memory);
    
endmodule
