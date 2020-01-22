`timescale 1ns / 1ps


module oled_top #(parameter long_delay = 100, reg [11:0] d4 = 12'd4000, reg [11:0] d1 = 12'd1000, parameter decades = 4) (
    input clk, rst, wire [15:0] number,
    output sclk, sdout, dco, vdd, vbat, res);
    `include "screens.vh"
    wire init_done, sclk_init, en_init, sdout_init, oper_done, sclk_oper, dc_oper, en_oper, sdout_oper;
    wire screen_ready;
    
    //reg [4 * decades - 1: 0] input_number;
    reg [4 * decades - 1: 0] temp_number;
    
    
    fsm_init #(.long_delay(long_delay)) finit(.clk(clk), .rst(rst), .en(en_init), .fin(init_done),
            .sclk(sclk_init), .sdout(sdout_init), .res(res), .vdd(vdd), .vbat(vbat));
            
          
    fsm_oper #(.del4s(d4), .del1s(d1)) foper(.clk(clk), .rst(rst), .en(en_oper), .sdo(sdout_oper), .sclk(sclk_oper), .number(number),
            .fin(oper_done), .dc(dc_oper));
    

    typedef enum {idle, hold, done, oper} fsmstat_e;
    fsmstat_e current, next;
    
    
    
    always @(posedge clk, posedge rst)
        if (rst)
            current <= idle; 
        else 
            current <= next;
        
    always @* begin
            next = idle;
            case (current)
                idle: next = hold;
                hold: next = init_done ? oper : hold;
                oper: next = oper_done ? done : oper;
                done: next = idle;
            endcase
        end

    assign sdout = (current == hold) ? sdout_init : sdout_oper;
    assign sclk = (current == hold) ? sclk_init : sclk_oper;
    assign dco = (current == hold) ? 1'b0 :  dc_oper;
    assign en_init = 1;
    assign en_oper = (current == oper);
        
endmodule
