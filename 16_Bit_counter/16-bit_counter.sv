`timescale 1ns/1ps

module counter16 (
    input  logic        clk,
    input  logic        rst,
    input  logic        inc, 
    output logic [15:0] Q
);
    logic [7:0] qL;
    logic [7:0] qH;
    assign Q = {qH, qL};

    logic carry;
    assign carry = inc & (qL == 8'hFF);
    
    register regL(
        .clk(clk),
        .rst(rst), 
        .load(1'b0),
        .inc(inc),
        .rotate_right(1'b0),
        .D(8'b0),
        .Q(qL)
    );

    register regH(
        .clk(clk),
        .rst(rst), 
        .load(1'b0),
        .inc(carry),
        .rotate_right(1'b0),
        .D(8'b0),
        .Q(qH)
    );

endmodule