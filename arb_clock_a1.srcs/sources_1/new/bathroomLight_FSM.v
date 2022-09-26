`timescale 1ns / 1ps

module bathroomLight_FSM(

    input wire bathMain,
    input wire clk,
    input wire motion, // we want this to flip 
    output wire blight
    
    

    );
    
    parameter ON=2'd0,OFF=2'd1;
    reg [1:0] state, nextstate;
    reg personDetected;
    
    always@(posedge clk)begin
        state <= nextstate;
        if(motion) personDetected <= ~(personDetected);
    end
    
    
    
    always@(*)begin
        case(state)
            ON:begin
                if(bathMain || personDetected) nextstate = ON;
                else
                    nextstate = OFF;
                end
            OFF:begin
                if(bathMain || personDetected) nextstate = ON;
                else
                    nextstate = OFF;
                end
             default:begin
                nextstate = OFF;
                end
            endcase
     end
                    
    
    
    assign blight = ~(state);
    
endmodule
