`timescale 1ns / 1ps

module nightlight_FSM(

    input wire nightMain, // main switch
    input wire night, //night time input
    input wire mode, // switch for which mode its in - off is security, on is nightlight
    input wire bt1, // motion
    input wire clk,
    output wire nightlight //output led

    );
    
    //2 modes - night light if dark, turn on for 10 secs
    // - sec - if dark & motion
    
    wire clkdown;
    heartbeat #(.TOPCOUNT(100_000_000)) beat (.clk(clk),.beat(clkdown)); // 1 second clock
    
    
    parameter CONTROL=2'd0,SEC=2'd1, NIGHT=2'd2;
    reg [1:0] state, nextstate;
    reg on;
    reg timeupNight;
    reg motSec;
    reg [3:0] countNight;
    reg [3:0] countSec;
    
    always@(posedge clk)begin
        state <=nextstate;
        //night state output logic
        if (state == NIGHT)begin
            
            //resetting other state values
            countSec <= 0;
            motSec <= 0;
        
            //main loop function, 10 seconds of light
            if (night & clkdown & ~timeupNight)begin
                on <= 1;
                countNight = countNight + 1;
                if (countNight == 10) timeupNight = 1;
            end
            //reseting variables if daytime
            if(~night)begin
                timeupNight <= 0;
                countNight <= 0;
                on <= 0;
            end
            //reseting variables
            if(timeupNight)begin
               countNight <= 0;
               on = 0;
               end
        end

        if (state == CONTROL)begin
            if(nightMain) on <= 1;
            else on <= 0;
        end
        
        if(state == SEC)begin
        //reseting variables
            countNight <=0;
            timeupNight <= 0;
            
            //Security mode: Only turn on when it is both night and there is motion detected. Turn off after 5 seconds.
            
            if(bt1 & night) begin
                motSec <= 1;
                countSec <= 0;   
            end
            
            if (~night)begin
                motSec <= 0;
                countSec <= 0;
                on <= 0;
            end
            
            if (night & motSec & clkdown) begin
                on <= 1;
                countSec = countSec + 1;
                if (countSec == 5)begin
                    motSec <= 0;
                    on <= 0;
                end
            end
        end
    end
    
    //mode movement
    always@(*)begin
        case(state)
            CONTROL:begin
                if (nightMain) nextstate = CONTROL;
                else if(mode) nextstate = NIGHT;
                else nextstate = SEC;
            end
            
            NIGHT:begin
                if (nightMain) nextstate = CONTROL;
                else if(mode) nextstate = NIGHT;
                else nextstate = CONTROL;
            end
            SEC:begin
                if (nightMain) nextstate = CONTROL;
                else if(mode) nextstate = CONTROL;
                else nextstate = SEC;
            end
            default: nextstate = CONTROL;
        endcase
   end
   

    assign nightlight = on;
    //one light settings - on and off when inter/exit room
    
    //night light that 
    
endmodule
