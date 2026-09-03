`timescale 1ns/1ps

module register (
    input  logic       clk,
    input  logic       rst, 
    input  logic       load,
    input  logic       inc,
    input  logic       rotate_right,
    input  logic [7:0] D,
    output logic [7:0] Q
);

    always_ff @(posedge clk or negedge rst) 
    begin
        if (!rst)
            Q <= 8'b0;
        else if (load) 
            Q <= D;
        else if (inc)
            Q <= Q + 1'b1;
        else if (rotate_right == 1)
            Q <= {Q[0], Q[7:1]};
        else
            Q <= Q;
    end
endmodule