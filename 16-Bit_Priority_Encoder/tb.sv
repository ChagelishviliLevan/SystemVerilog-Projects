/*

* Testbench source:
* This testbench was taken/adapted from the course
* "Digital Design with SystemVerilog HDL + Introduction to UVM"
* for learning and verification purposes.
*
* Course:
* https://www.udemy.com/course/digital-design-with-systemverilog-hdl/
*
* The design under test (DUT) was implemented by me as part of my
* SystemVerilog learning projects.
  */
  
`timescale 1ns/1ps

module encoder16_tb;
    logic A0,  A1,  A2,  A3;
    logic A4,  A5,  A6,  A7;
    logic A8,  A9,  A10, A11;
    logic A12, A13, A14, A15;
    logic V;
    logic Q3, Q2, Q1, Q0;

    int error_count = 0;

    encoder16 dut (
        .A0(A0), .A1(A1), .A2(A2), .A3(A3),
        .A4(A4), .A5(A5), .A6(A6), .A7(A7),
        .A8(A8), .A9(A9), .A10(A10), .A11(A11),
        .A12(A12), .A13(A13), .A14(A14), .A15(A15),
        .V(V), 
        .Q3(Q3), .Q2(Q2), .Q1(Q1), .Q0(Q0)
    );

    initial begin
        {A15,A14,A13,A12,A11,A10,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0} = 16'h0000; 
        #5;
        if (V !== 0 || {Q3,Q2,Q1,Q0} !== 4'b0000) 
            error_count++;
        {A15,A14,A13,A12,A11,A10,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0} = 16'h0001; 
        #5;
        if (V !== 1 || {Q3,Q2,Q1,Q0} !== 4'b0000) 
            error_count++;
        {A15,A14,A13,A12,A11,A10,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0} = 16'h0008; 
        #5;
        if (V !== 1 || {Q3,Q2,Q1,Q0} !== 4'b0011) 
            error_count++;
        {A15,A14,A13,A12,A11,A10,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0} = 16'h0010; 
        #5;
        if (V !== 1'b1 || {Q3,Q2,Q1,Q0} !== 4'b0100) 
            error_count++;
        {A15,A14,A13,A12,A11,A10,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0} = 16'h0080; 
        #5;
        if (V !== 1'b1 || {Q3,Q2,Q1,Q0} !== 4'b0111) 
            error_count++;
        {A15,A14,A13,A12,A11,A10,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0} = 16'h0200; 
        #5;
        if (V !== 1 || {Q3,Q2,Q1,Q0} !== 4'b1001) 
            error_count++;
        {A15,A14,A13,A12,A11,A10,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0} = 16'h8000; 
        #5;
        if (V !== 1'b1 || {Q3,Q2,Q1,Q0} !== 4'b1111) 
            error_count++;
        {A15,A14,A13,A12,A11,A10,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0} = 16'h2020; 
        #5;
        if (V !== 1'b1 || {Q3,Q2,Q1,Q0} !== 4'b1101) 
            error_count++;

        if (error_count == 0) $display("TEST PASSED");
        else                  $display("TEST FAILED -- %0d errors", error_count);

        $finish;
    end
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, encoder16_tb);
    end
endmodule