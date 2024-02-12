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
 * The project top module.
 */

`timescale 1 ns / 1 ps

module top_vga (
    input  logic clk,
    input  logic rst,
    output logic vs,
    output logic hs,
    output logic [3:0] r,
    output logic [3:0] g,
    output logic [3:0] b

);

    vga_if draw_rect_if();
    vga_if draw_bg_if();
    vga_if timing_if();
/**
 * Local variables and signals
 */

// VGA signals from timing
wire [10:0] vcount_tim, hcount_tim;
wire vsync_tim, hsync_tim;
wire vblnk_tim, hblnk_tim;

// VGA signals from background
wire [10:0] vcount_bg, hcount_bg;
wire vsync_bg, hsync_bg;
wire vblnk_bg, hblnk_bg;
wire [11:0] rgb_bg;

// VGA signals from draw
wire [10:0] vcount_dg, hcount_dg;
wire vsync_dg, hsync_dg;
wire vblnk_dg, hblnk_dg;
wire [11:0] rgb_out;

/**
 * Signals assignments
 */

assign vs = draw_rect_if.vsync;
assign hs = draw_rect_if.hsync;
assign {r,g,b} = draw_rect_if.rgb;


/**
 * Submodules instances
 */

vga_timing u_vga_timing (
     .pclk (clk),
     .rst,

    .out(timing_if)
);

draw_bg u_draw_bg (
    .clk (clk),
    .rst,
    .in(timing_if),
    .out(draw_bg_if)
);

draw_rect u_rect_ (
    .clk (clk),
    .rst,

    .in(draw_bg_if),
    .out(draw_rect_if)
);


endmodule
