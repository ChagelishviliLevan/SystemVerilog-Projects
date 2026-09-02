`timescale 1ns/1ps

module ALU (
    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic       cin,
    input  logic [2:0] op,
    output logic       cout,
    output logic [7:0] y
);

    always_comb begin 
        y = '0;
        cout = 1'b0;
        case (op) 
            3'b000: begin 
                y = a & b; // AND
                cout = 1'b0;
            end
            3'b001: begin 
                y = a | b; // OR
                cout = 1'b0;
            end
            3'b010: begin 
                y = ~a;    // Complement of a
                cout = 1'b0;
            end
            3'b011: begin 
                y = {cin, a[7:1]}; // Rotate Right with Carry
                cout = a[0];
            end
            3'b100: begin 
                y = {a[6:0], cin}; // Rotate Left with Carry
                cout = a[7];
            end
            3'b101: begin 
                {cout, y} = {1'b0, a} + {1'b0, b} + cin; // Addition with Carry
            end
            3'b110: begin 
                {cout, y} = {1'b0, a} - {1'b0, b} - cin; // Subtraction with Carry 
            end
            3'b111: begin 
                y = b;    // Move
                cout = 1'b0;
            end            
        endcase
    end
endmodule