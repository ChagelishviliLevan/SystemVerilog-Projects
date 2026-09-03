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

module counter16_tb;

    // DUT I/O
    logic        clk;
    logic        rst;
    logic        inc;
    logic [15:0] Q;

    // Expected/reference model and error counter
    logic [15:0] exp;
    int          errors = 0;
    int          i;

    // 10 ns clock
    initial clk = 1'b0;
    always  #5 clk = ~clk;

    // DUT
    counter16 dut (
        .clk    (clk),
        .rst    (rst),
        .inc    (inc),
        .Q      (Q)
    );

    initial begin
        // ---- Reset ----
        inc     = 1'b0;
        rst = 1'b0;
        exp     = 16'h0000;

        // Hold reset for a couple of cycles
        @(posedge clk);
        @(posedge clk);
        #2 rst = 1'b1;          // deassert reset between edges
        @(posedge clk); #1;         // let flops update

        // After reset Q should be 0
        if (Q !== 16'h0000) begin
            $display("FAIL: post-reset Q=%h exp=0000", Q); errors++;
        end

        // ---- Hold (inc=0) for 2 cycles ----
        repeat (2) begin
        @(posedge clk); 
        #1;
        if (Q !== exp) begin
            $display("FAIL: hold Q=%h exp=%h", Q, exp);
            errors++;
        end
    end

    // ---- Count up with inc=1 for 260 cycles ----
    inc = 1'b1;
    for (i = 0; i < 260; i++)
    begin
        @(posedge clk);
        exp = exp + 16'd1;       // reference model
        #1;                      // allow DUT to update
        if (Q !== exp) begin
            $display("FAIL: count i=%0d Q=%h exp=%h", i, Q, exp); errors++;
        end
    end

    // Sanity: at this point we crossed 0x00FF -> 0x0100
    // and should be at 0x0104 (from 0 + 260)
    // ---- Hold again (inc=0) for 5 cycles ----
    inc = 1'b0;
    repeat (5)
    begin
        @(posedge clk);
        #1;
        if (Q !== exp) begin
            $display("FAIL: hold(after count) Q=%h exp=%h", Q, exp);
            errors++;
        end
    end

    // ---- Summary ----
    if (errors == 0)
        $display("TEST PASSED");
    else
        $display("TEST FAILED -- %0d mismatches", errors);
        $finish;
    end
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, counter16_tb);
    end
endmodule