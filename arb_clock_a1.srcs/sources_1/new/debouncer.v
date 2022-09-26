module debouncer (
input wire switchIn,
input wire clk,
output wire debounceout);

wire clkdown;

heartbeat #(.TOPCOUNT(10_000_00)) beat_deb (.clk(clk),.beat(clkdown));
heartbeat #(.TOPCOUNT(200_000_00)) beat_deb2 (.clk(clk),.beat(clkdown2));  //added to make debouncer more robust for buttons
    
reg [2:0] pipeline;
    
    always @(posedge clk) begin
        if(clkdown) begin
         pipeline[0]<=switchIn;
         pipeline[1]<=pipeline[0];
         pipeline[2]<=pipeline[1];
         end    
    end

assign debounceout=(&pipeline && clkdown2);
endmodule
