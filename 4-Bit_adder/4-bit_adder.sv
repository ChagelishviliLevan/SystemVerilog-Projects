
module full_adder (
    input logic a, b, cin,
    output logic cout, sum
);
    always_comb
    begin
        {cout, sum} = a + b + cin;
    end
endmodule

module four_bit_adder (
    input  logic [3:0] a, 
    input  logic [3:0] b,
    output logic cout,
    output logic [3:0] sum 
);

    logic [2:0] cin_ ;

    full_adder add0(
        .a(a[0]), .b(b[0]), .cin(0),
        .cout(cin_[0]), .sum(sum[0])
    );
    full_adder add1(
        .a(a[1]), .b(b[1]), .cin(cin_[0]),
        .cout(cin_[1]), .sum(sum[1])
    );
    full_adder add2(
        .a(a[2]), .b(b[2]), .cin(cin_[1]),
        .cout(cin_[2]), .sum(sum[2])
    );
    full_adder add3(
        .a(a[3]), .b(b[3]), .cin(cin_[2]),
        .cout(cout), .sum(sum[3])
    );    
endmodule