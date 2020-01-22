`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2019 01:52:30 PM
// Design Name: 
// Module Name: delay
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


module delay #(parameter mod = 100000, nbits = 4)(
    input clk,
    input rst,
    input en,
    input [nbits-1:0] delay_ms,
    output fin //reg
    );
    
    localparam n = $clog2(mod);
    
    reg [nbits-1:0] cnt_ms = {nbits{1'b0}};
    reg [n-1:0] cnt1ms = {nbits{1'b0}};
    
    typedef enum {idle, hold, done, fn} fsmstat_e;
    fsmstat_e current, next;
    
    always @(posedge clk, posedge rst)
        if (rst) current <= idle; 
        else current <= next;
        
    always @* begin
            next = idle; //fin = 1'b0;
            case (current)
                idle: next = en ? hold : idle;
                hold: next = (cnt_ms == delay_ms) ? done : hold;
                done: if (~en) next = idle;
                      else begin
                              next = done;
                              //fin = 1'b1;
                           end
            endcase
        end
        
    always @(posedge clk, posedge rst)
        if (rst) cnt_ms <= {nbits{1'b0}};
        else if (current == hold) begin
                                    if (cnt1ms == mod-1)
                                        cnt_ms <= cnt_ms + 1;
                                  end 
             else cnt_ms <= 0;
             
    always @(posedge clk, posedge rst)
                     if (rst) cnt1ms <= {n{1'b0}};
                     else if (current == hold) 
                              if (cnt1ms != mod-1)
                                  cnt1ms <= cnt1ms + 1;
                              else cnt1ms <= {n{1'b0}};
                          else cnt1ms <= {n{1'b0}};
                          
    //alter                      
    assign fin = (current == done);
    
endmodule
