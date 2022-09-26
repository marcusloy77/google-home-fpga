`timescale 1ns / 1ps
module Seven_segment_LED_Display_Controller(

    input clk, 
    input reset,
    input wire [2:0] switches,
    input wire on,
    output reg [3:0] Anode_Activate, // anode signals of the 7-segment LED display
    output reg [6:0] LED_out// cathode patterns of the 7-segment LED display
    );
   
   //reg's to make SSD work
    reg [3:0] LED_BCD; 
    wire [1:0] LED_activating_counter;
    reg [1:0] LED;
    wire clkdown;
    wire clkdown2;
    wire clkdown3;
    heartbeat #(.TOPCOUNT(10000)) beat1 (.clk(clk),.beat(clkdown)); // timer to refresh SSD
    heartbeat #(.TOPCOUNT(100_000_000)) beat2 (.clk(clk),.beat(clkdown2)); // timer to add/remove temp - 1sec
    heartbeat #(.TOPCOUNT(200_000_000)) beat3 (.clk(clk),.beat(clkdown3)); // timer for outside temp - 2secs
    reg [2:0] desired_temp;
    reg [2:0] current_temp;
    reg [6:0] tempToBits;
    
    //temp change block
    always@(posedge clk)begin
        //loop once a second through, moving towards desired temp
        desired_temp <= switches;
        if(on)begin
            if((desired_temp > current_temp) && clkdown2) current_temp <= current_temp + 1;
            if((desired_temp < current_temp) && clkdown2) current_temp <= current_temp - 1;
        end
        //loop once every 2 seconds, moving towards outside temp
        if(~on) begin
            if((current_temp > 0) && clkdown3) current_temp <= current_temp - 1;
        end
    end
    
    
    //temp conversion block
    always@(posedge clk)begin
        if(current_temp == 0) tempToBits <= 7'b0000000; 
        if(current_temp == 1) tempToBits <= 7'b0000001; 
        if(current_temp == 2) tempToBits <= 7'b0000010; 
        if(current_temp == 3) tempToBits <= 7'b0000011; 
        if(current_temp == 4) tempToBits <= 7'b0100100; 
        if(current_temp == 5) tempToBits <= 7'b0000101; 
        if(current_temp == 6) tempToBits <= 7'b0000110; 
        if(current_temp == 7) tempToBits <= 7'b0000111; 
    end
    
   
    //block for running through SDD values
    always@(posedge clk)begin
        if(clkdown) begin 
        LED <= LED + 1; 
        if (LED == 4) LED <= 0;
        end
    end
    
    assign LED_activating_counter = LED;
    
    always @(*)
    begin
        case(LED_activating_counter)
        2'b00: begin
            Anode_Activate = 4'b0111; 
            // activate LED1 and Deactivate LED2, LED3, LED4
            LED_BCD = 7'b0000000;
            // the first digit of the 16-bit number
              end
        2'b01: begin
            Anode_Activate = 4'b1011; 
            // activate LED2 and Deactivate LED1, LED3, LED4
            LED_BCD = 7'b0000000;
            // the second digit of the 16-bit number
              end
        2'b10: begin
            Anode_Activate = 4'b1101; 
            // activate LED3 and Deactivate LED2, LED1, LED4
            LED_BCD = 7'b0010010;
            // the third digit of the 16-bit number
                end
        2'b11: begin
            Anode_Activate = 4'b1110; 
            // activate LED4 and Deactivate LED2, LED3, LED1
            LED_BCD = tempToBits; // this is the one we change up to 7
            // the fourth digit of the 16-bit number    
               end
        endcase
    end
    // Output patterns
    always @(*)
    begin
        case(LED_BCD)
        4'b0000: LED_out = 7'b0000001; // "0"     
        4'b0001: LED_out = 7'b1001111; // "1" 
        4'b0010: LED_out = 7'b0010010; // "2" 
        4'b0011: LED_out = 7'b0000110; // "3" 
        4'b0100: LED_out = 7'b1001100; // "4" 
        4'b0101: LED_out = 7'b0100100; // "5"  
        4'b0110: LED_out = 7'b0100000; // "6"  
        4'b0111: LED_out = 7'b0001111; // "7"  
        4'b1000: LED_out = 7'b0000000; // "8"     
        4'b1001: LED_out = 7'b0000100; // "9" 
        default: LED_out = 7'b0000001; // "0"
        endcase
    end
 endmodule