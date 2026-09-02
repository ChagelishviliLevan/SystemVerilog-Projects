# SystemVerilog Projects

This repository documents my journey learning SystemVerilog, digital hardware design and ASIC design. It contains the projects I build as I develop my understanding of how digital circuits work and how to describe and verify them using SystemVerilog.

My long-term goal is to design and implement my own CPU in SystemVerilog and learn how to take a design through an ASIC implementation flow.

## Learning goals

- Design combinational and sequential logic.
- Write modular RTL in SystemVerilog.
- Create testbenches and debug designs using simulation and waveforms.
- Learn about synthesis, timing, and the ASIC design flow.
- Understand computer architecture and apply that knowledge to my own CPU.

## Projects

| Project | Description |
| --- | --- |
| [16-input Priority Encoder](16-Bit_Priority_Encoder/) | A hierarchical priority encoder built from 4-input encoders and multiplexers, with a testbench. |
| [4-bit Ripple-Carry Adder](4-Bit_adder/) | A structural 4-bit adder built from four 1-bit full adders, with a testbench. |

More projects will be added as I learn and progress toward building a CPU.

## Learning resources

These are the courses, books, and websites I use throughout my learning journey.

### Courses

- [Mastering RISC-V in SystemVerilog: From ISA to Working CPU](https://www.udemy.com/course/mastering-risc-v-in-systemverilog-from-isa-to-working-cpu/)
- [Digital Design with SystemVerilog HDL + Introduction to UVM](https://www.udemy.com/course/digital-design-with-systemverilog-hdl/)
- [Crash Course Digital Electronics](https://www.udemy.com/course/crash-course-digital-electronics/) — Digital electronics and robotics, from the fundamentals to building a CPU.

### Books

| Book | Author(s) |
| --- | --- |
| [Digital Design and Computer Architecture](https://www.ddcabook.com/) | David Harris and Sarah L. Harris |
| Inside the Machine: An Illustrated Introduction to Microprocessors and Computer Architecture | Jon Stokes |
| Computer Organization and Design: The Hardware/Software Interface | David A. Patterson and John L. Hennessy |
| Modern Processor Design: Fundamentals of Superscalar Processors | John Paul Shen and Mikko H. Lipasti |
| Logic Design and Verification Using SystemVerilog (Revised) | Donald Thomas |
| Computer Principles and Design in Verilog HDL | Yamin Li |

### Websites

- [Bit Spinner](https://www.bit-spinner.com/)

## Tools

Icarus Verilog for compiling and simulating SystemVerilog designs.
VaporView for inspecting VCD simulation waveforms directly in Visual Studio Code.
Visual Studio Code for writing and managing SystemVerilog source files.
Git and GitHub for version control and documenting my progress.
Running the simulations

The commands below should be executed from the repository root.

16-input priority encoder
cd 16-Bit_Priority_Encoder

iverilog -g2012 -Wall \
  -s encoder16_tb \
  -o encoder_sim \
  16-bit_encoder.sv tb.sv

vvp encoder_sim
code dump.vcd

The testbenches generate dump.vcd. With the VaporView extension installed and configured as the default VCD viewer, code dump.vcd opens the waveform directly in Visual Studio Code.

## About this repository

These are learning projects. I will improve the designs and documentation as my understanding grows.
