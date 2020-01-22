`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2019 01:46:32 PM
// Design Name: 
// Module Name: spi
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

module spi #(parameter bits = 8) (input clk, rst, en, input [bits-1:0] data2trans,
             output sclk, fin, output reg mosi);
localparam bcnt = $clog2(bits);

typedef enum {idle, send, hold, done} states_e;
states_e current, next;

reg[bits-1:0] shr;
reg[bcnt:0] dcnt;
reg tmp, sh;
reg[4:0] div;
reg t;

assign last_bit = (dcnt == bits);
assign sh = t & ~sclk;
assign sclk = ~div[4];

//rejestr przesuwny
always @(posedge clk, posedge rst)
        if(rst) shr <= {bits{1'b0}};
        else if(current == idle & en) shr <= data2trans;
        else if(current == send & sh) shr <= {shr[bits-2:0],1'b0};

//generator impulsu sterujacego (dla opadajacego zbocza zegara transmisji)
always @(posedge clk, posedge rst)
        if(rst) mosi <= 1'b0;
        else if(current == send & sh) mosi <= shr[bits-1];
        else if(current == idle & en) mosi <= 1'b1;

//rejestr stanu
always @(posedge clk, posedge rst)
        if (rst) current <= idle; 
        else current <= next;

//logika automatu
always @* begin
            next = idle;
            case (current)
                idle: next = en ? send : idle;
                send: next = last_bit ? hold : send;
                hold: next = done;
                done: if (~en) next = idle;
                      else next = done;
            endcase
        end

//licznik bitow
always @(posedge clk, posedge rst)
    if(rst) dcnt <= {(bits+1){1'b0}};
    else if(current == idle & en) dcnt <= {(bits+1){1'b0}};
    else if(current == send & sh) dcnt <= dcnt + 1;

//generator zezwolenia stanu przesuwnego
always @(posedge clk, posedge rst)
        if (rst) t <= 1'b0; 
        else t <= sclk;

//generator zegara transmisji, dzielnik zegara
always @(posedge clk, posedge rst)
        if (rst) div <= 5'b0; 
        else if(current == send) div <= div + 1;
        else div <= 5'b0;

//generator sygnalu zakonczenia
assign fin = (current == done);

endmodule
