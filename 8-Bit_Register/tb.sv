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

module byte_register_tb;

    // DUT I/O
    logic       clk;
    logic       rst;
    logic       load;
    logic       inc;
    logic       rotate_right;
    logic [7:0] D;
    logic [7:0] Q;

    int errors = 0;
    logic [7:0] prev, exp;

    // Clock: 10ns period
    initial clk = 1'b0;
    always  #5 clk = ~clk;

    // Instantiate DUT
    register dut (
      .clk(clk),
      .rst(rst),
      .load(load),
      .inc(inc),
      .rotate_right(rotate_right),
      .D(D),
      .Q(Q)
    );

    initial begin
        // Defaults
        rst = 1'b1;
        load = 1'b0; 
        inc = 1'b0; 
        rotate_right = 1'b0;
        D = 8'h00;

        // -------- Asynchronous reset (low-active) --------
        #1; 
        rst = 1'b0;                         // assert
        #1;                     
        if (Q !== 8'h00) 
            errors++;
        rst = 1'b1;                         // deassert
        @(negedge clk);             
        if (Q !== 8'h00) 
            errors++;

        // -------- LOAD --------
        D = 8'hA5; 
        load = 1'b1; 
        @(negedge clk); 
        load = 1'b0;
        if (Q !== 8'hA5) 
            errors++;

        // -------- INC --------
        inc = 1'b1; @(negedge clk); 
        inc = 1'b0;
        if (Q !== 8'hA6)                        // 0xA5 + 1 = 0xA6
            errors++;                 

        // -------- ROTATE RIGHT (circular) --------
        prev = Q;
        rotate_right = 1'b1; 
        @(negedge clk); 
        rotate_right = 1'b0;
        exp = {prev[0], prev[7:1]};
        if (Q !== exp) 
            errors++;

        // -------- HOLD (no enables) --------
        prev = Q;
        @(negedge clk);
        if (Q !== prev) 
            errors++;

        // -------- Priority: load over inc --------
        D = 8'h3C; 
        load = 1'b1; 
        inc = 1'b1; 
        @(negedge clk);
        load = 1'b0; inc = 1'b0;
        if (Q !== 8'h3C) 
            errors++;

        // -------- Priority: inc over rotate_right --------
        prev = Q; 
        inc = 1'b1; 
        rotate_right = 1'b1; 
        @(negedge clk);
        inc = 1'b0; 
        rotate_right = 1'b0;
        if (Q !== (prev + 8'd1)) 
            errors++;

        // -------- Async reset mid-cycle (no clock edge needed to clear) --------
        prev = Q; 
        #2; 
        rst = 1'b0; 
        #1;
        if (Q !== 8'h00) 
            errors++;
        rst = 1'b1; 
        @(negedge clk);
        if (Q !== 8'h00) 
            errors++;

        // -------- Summary --------
        if (errors == 0) 
            $display("TEST PASSED");
        else             
            $display("TEST FAILED -- %0d errors", errors);
         $finish;
    end
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, byte_register_tb);
    end
endmodule
