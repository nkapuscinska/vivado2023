/**
 * San Jose State University
 * EE178 Lab #4
 * Author: prof. Eric Crabilla
 *
 * Modified by:
 * 2023  AGH University of Science and Technology
 * MTM UEC2
 * Piotr Kaczmarczyk
 *
 * Description:
 * Top level synthesizable module including the project top and all the FPGA-referred modules.
 */

`timescale 1 ns / 1 ps

module top_vga_basys3 (
    input  logic clk,
    input  logic btnC,
    output logic Vsync,
    output logic Hsync,
    output logic [3:0] vgaRed,
    output logic [3:0] vgaGreen,
    output logic [3:0] vgaBlue,
    output logic JA1,

    inout logic PS2Clk,
    inout logic PS2Data
);


/**
 * Local variables and signals
 */

logic clk100;
logic locked;
logic pclk;
logic pclk_mirror;

(* KEEP = "TRUE" *)
(* ASYNC_REG = "TRUE" *)
// For details on synthesis attributes used above, see AMD Xilinx UG 901:
// https://docs.xilinx.com/r/en-US/ug901-vivado-synthesis/Synthesis-Attributes


/**
 * Signals assignments
 */

assign JA1 = pclk_mirror;


/**
 * FPGA submodules placement
 */



// Mirror pclk on a pin for use by the testbench;
// not functionally required for this design to work.

ODDR pclk_oddr (
    .Q(pclk_mirror),
    .C(pclk),
    .CE(1'b1),
    .D1(1'b1),
    .D2(1'b0),
    .R(1'b0),
    .S(1'b0)
);

clk_wiz_0 u_clk_wiz_0 
    (
     // Clock out ports
     .clk(clk),
     .clk40MHz(pclk),
     .clk100MHz(clk100),
     .locked(locked)
    );

/**
 *  Project functional top module
 */

top_vga u_top_vga (
    .pclk(pclk), //tu moze byc blad
    .clk100(clk100),
    .ps2_clk(PS2Clk),
    .ps2_data(PS2Data),
    .rst(btnC),
    .r(vgaRed),
    .g(vgaGreen),
    .b(vgaBlue),
    .hs(Hsync),
    .vs(Vsync)
);

endmodule
