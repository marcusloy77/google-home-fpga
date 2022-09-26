`timescale 1ns / 1ps

module Garage_FSM(
    input wire clk,
    input wire btn_main,
    input wire btn_inter,
    output wire [3:0] LEDs
    );
    
    //timer setting
    wire clkdown;
    heartbeat #(.TOPCOUNT(100_000_000)) beat_deb (.clk(clk),.beat(clkdown)); 
    
    //setting up states, variables
    parameter OPEN=3'd0,CLOSE=3'd1,OPENING=3'd2,CLOSING=3'd3, PAUSE_OPEN = 3'd4, PAUSE_CLOSE = 3'd5;
    reg [2:0] state, nextstate;
    reg [3:0] timeLEDs;
    reg [3:0] count;
    
    
    always@(posedge clk)begin
        state <= nextstate;

        //two counting blocks
        if (state == OPENING)begin
            if (clkdown) begin
                count <= count + 1;
            end
        end
        if (state == CLOSING)begin
            if(clkdown) begin
               count <= count - 1;
            end
        end
        
        //time variant garage door output
        if (count < 2) timeLEDs <= 4'b0000;
        if (count >= 2) timeLEDs <= 4'b0001;
        if (count >= 4) timeLEDs <= 4'b0011;
        if (count >= 6) timeLEDs <= 4'b0111;
        if (count >= 8) timeLEDs <= 4'b1111;
    end
    
    
    //state movement implementation
    always@(*)begin
        case(state)
            OPEN:begin
                if (btn_main) nextstate = CLOSING;
                else nextstate = OPEN;
            end
            
            CLOSE:begin
                if(btn_main) nextstate = OPENING;
                else nextstate = CLOSE;
            end
            
            OPENING:begin
                if(count == 8) nextstate = OPEN;
                else begin
                    if (btn_main) nextstate = PAUSE_OPEN;
                    else nextstate = OPENING;
                end
            end
            CLOSING: begin
                if(count == 0) nextstate = CLOSE;
                else begin
                    if (btn_main) nextstate = PAUSE_CLOSE;
                    else if(btn_inter) nextstate = OPENING;
                    else nextstate = CLOSING;
                end
            end
            PAUSE_CLOSE: begin
                if (btn_main) nextstate = OPENING;
                else nextstate = PAUSE_CLOSE;
            end
            PAUSE_OPEN: begin
                if (btn_main) nextstate = CLOSING;
                else nextstate = PAUSE_OPEN;
            end
            default: begin
                nextstate = CLOSE;
                end
        endcase
    end
    assign LEDs = timeLEDs;
    
endmodule
