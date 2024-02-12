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
    input  logic pclk,
    input  logic clk100,
    input  logic rst,
    output logic vs,
    output logic hs,
    output logic [3:0] r,
    output logic [3:0] g,
    output logic [3:0] b,

    inout ps2_clk,
    inout ps2_data

);

    vga_if draw_rect_if();
    vga_if draw_bg_if();
    vga_if timing_if();
    vga_if draw_mouse_if();
    logic [11:0]xpos;
    logic [11:0]ypos;
    logic [11:0]xpos_ctl;
    logic [11:0]ypos_ctl;
    logic left;
    logic [11:0]rgb_pixel;
    logic [11:0]pixel_addr;
    logic clk50hz;
    logic [11:0]ypos_s;
    logic [11:0]xpos_s;
    logic left_s;
/**
 * Local variables and signals
 */

// // VGA signals from timing
// wire [10:0] vcount_tim, hcount_tim;
// wire vsync_tim, hsync_tim;
// wire vblnk_tim, hblnk_tim;

// // VGA signals from background
// wire [10:0] vcount_bg, hcount_bg;
// wire vsync_bg, hsync_bg;
// wire vblnk_bg, hblnk_bg;
// wire [11:0] rgb_bg;

// // VGA signals from draw
// wire [10:0] vcount_dg, hcount_dg;
// wire vsync_dg, hsync_dg;
// wire vblnk_dg, hblnk_dg;
// wire [11:0] rgb_out;

/**
 * Signals assignments
 */

assign vs = draw_mouse_if.vsync;
assign hs = draw_mouse_if.hsync;
assign {r,g,b} = draw_mouse_if.rgb;


/**
 * Submodules instances
 */

 MouseCtl u_MouseCtl (
    .ps2_clk(ps2_clk),
    .ps2_data(ps2_data),
    .xpos(xpos),
    .ypos(ypos),
    .left,
    .clk(clk100),
    .rst(rst)

 );

vga_timing u_vga_timing (
     .pclk (pclk),
     .rst,

    .out(timing_if)
);

draw_bg u_draw_bg (
    .clk (pclk),
    .rst,
    .in(timing_if),
    .out(draw_bg_if)
);

draw_mouse u_draw_mouse(
    .xpos(xpos_s),
    .ypos(ypos_s),
    .clk40(pclk),
    .in(draw_rect_if),
    .out(draw_mouse_if)
);

clk100_40_sync u_clk100_40_sync(
    .clk40(pclk),
    .xpos,
    .ypos,
    .left,
    .xpos_s,
    .ypos_s,
    .left_s

);

draw_rect u_rect_ (

    .xpos(xpos_ctl),
    .ypos(ypos_ctl),
    .clk (pclk),
    .rst,
    .rgb_pixel,
    .pixel_addr,

    .in(draw_bg_if),
    .out(draw_rect_if)
);

image_rom image_rom (
    .clk(pclk),
    .rgb(rgb_pixel),
    .address(pixel_addr)
);

clk_delay clk_delay(
    .rst,
    .clk(pclk),
    .clk50hz(clk50hz)

);

draw_rect_ctl u_draw_rect_ctl(
    .clk50hz,
    .rst,
    .left(left),
    .xpos(xpos),
    .ypos(ypos),
    .xpos_ctl(xpos_ctl),
    .ypos_ctl(ypos_ctl)
    );


endmodule
