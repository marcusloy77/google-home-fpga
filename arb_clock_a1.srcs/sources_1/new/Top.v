`timescale 1ns / 1ps
module Top(
    input wire clk,  
    input wire btn_main,
    input wire btn_inter,
    output wire [3:0] LEDs,
    
    
    input reset,
    input wire [2:0] switches,
    input wire on,
    output wire [3:0] Anode_Activate, // anode signals of the 7-segment LED display
    output wire [6:0] LED_out,
    
    input wire bathMain,
    input wire motion,
    output wire blight,
    
    input wire nightMain, // main switch
    input wire night, //night time input
    input wire mode, // switch for which mode its in - off is security, on is nightlight
    input wire bt1, // motion
    output wire nightlight //output led
    
    );
    
    wire deb_main;
    wire deb_bath;
    debouncer debl (.switchIn(btn_main),.clk(clk),.debounceout(deb_main));
    Garage_FSM gar(.clk(clk), .btn_main(deb_main), .btn_inter(btn_inter), .LEDs(LEDs));
    
    Seven_segment_LED_Display_Controller tem(.clk(clk), .reset(reset),.switches(switches),.on(on), .Anode_Activate(Anode_Activate), .LED_out(LED_out));
    
    debouncer debl2 (.switchIn(motion),.clk(clk),.debounceout(deb_bath));
    bathroomLight_FSM bath(.bathMain(bathMain), .clk(clk), .motion(deb_bath), .blight(blight));
    
    nightlight_FSM nLight(.nightMain(nightMain), .night(night), .mode(mode), .bt1(btl), .clk(clk), .nightlight(nightlight));
    
    
endmodule
