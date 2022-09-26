`timescale 1ns / 1ps

//Module heartbeat generates a single high value of one clock cycle duration every TOPCOUNT clock cycles

module heartbeat #( 
    parameter TOPCOUNT = 100_000_000
)(
    input wire clk,
    output wire beat);

    
    reg [$clog2(TOPCOUNT)-1:0] count; 


always@(posedge clk) begin
    if(count==TOPCOUNT-1) 
        count<=0;
    else 
        count<=count+1;
end

assign beat=(count==TOPCOUNT-1);

endmodule
