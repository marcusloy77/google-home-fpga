`timescale 1ns / 1ps

module TEST_clockDividerHB2();

reg clk; 

initial begin 
    clk=0;
    forever #5 clk=~clk; //clock generation with period 10ns (100MHz)
end

wire dclk, beat;
reg reset, enable;

clockDividerHB #(.THRESHOLD(50_000_000), .ON_TIME(20_000)) UUT (.clk(clk),.reset(reset),.enable(enable),.dividedClk(dclk),.beat(beat)); //instantiation of module to test

initial begin
    reset = 1; // assert reset at beginning 
    enable = 0;
    #100 enable = 1;
    #20 reset = 0;
end

endmodule

