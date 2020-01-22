`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2019 03:23:02 PM
// Design Name: 
// Module Name: fsm_init
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


module fsm_init #(parameter long_delay = 100) (input clk, rst, en, output reg fin,
				output sclk, sdout, output reg res, vdd, vbat);
			
`include "screens.vh"	
reg [8:0] cmd; reg [3:0] cnt_cmd;
localparam nbcmd = 16;
localparam [8:0] list_cmd [0: nbcmd - 1] = '{9'h100, 9'h0AE, 9'h102, 9'h103, 9'h08D, 9'h014, 9'h0D9, 9'h0F1,
                                             9'h104, 9'h081, 9'h00F, 9'h0A1, 9'h0C8, 9'h0DA, 9'h020, 9'h0AF};
reg [7:0] ms;
				
typedef enum {idle, decision, power, wait_pre, delay, clear, spi, done} fsmstat_e;
fsmstat_e current, next;

reg delay_en, delay_fin, spi_en, spi_fin;

delay #(.mod(100_000), .nbits(8)) df(.clk(clk), .rst(rst), .en(delay_en), .delay_ms(ms), .fin(delay_fin));
spi #(.bits(8)) sf(.clk(clk), .rst(rst), .en(spi_en), .data2trans(cmd[7:0]), .sclk(sclk), .mosi(sdout), .fin(spi_fin));

//rejestr stanu
always @(posedge clk, posedge rst)
    if (rst) current <= idle;
    else current <= next;

always @* begin
    next = idle; 
    delay_en = 1'b0;
    fin = 1'b0;
    spi_en = 1'b0;
    case (current)
        idle: next = en ? decision : idle;
        decision: if(cmd[8]) next = power;
                  else next = spi;
        power: next = wait_pre;
        wait_pre: if(cmd == 9'h103) next = clear;
                  else next = delay;
        delay: begin
                  delay_en = 1'b1;
                  if (delay_fin) next = clear;
                  else next = delay;
               end
        clear: if (cnt_cmd == nbcmd - 1) next = done;
               else next = idle;
        spi: begin
                spi_en = 1'b1;
                if(spi_fin) next = clear;
                else next = spi;
             end
        done: if (~en) next = idle;
              else begin
                      next = done;
                      fin = 1'b1;
                   end           
    endcase
end

always @(posedge clk, posedge rst) begin
    if (rst) vdd <= 1'b1; vbat <= 1'b1; res <= 1'b1;
    case (cmd)
         9'h100: vdd <= 1'b0;
         9'h102: res <= 1'b0;
         9'h103: res <= 1'b1;
         9'h104: vbat <= 1'b0;
    endcase
end

always @(posedge clk, posedge rst) begin
    if (rst) ms <= 8'd0;
    case (cmd)
         9'h100: ms <= 8'd1;
         9'h102: ms <= 8'd1;
         9'h104: ms <= long_delay;  //8'd100;
    endcase
end

always @(posedge clk, posedge rst)
    if (rst) cnt_cmd <= 4'b0;
    else if(current == clear) cnt_cmd <= cnt_cmd + 1'b1;

always @(posedge clk, posedge rst)
    if (rst) cmd <= 9'b0;
    else if ((current == idle) & en) cmd <= list_cmd[cnt_cmd];

    
endmodule
