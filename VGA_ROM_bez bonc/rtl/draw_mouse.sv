`timescale 1 ns / 1 ps

module draw_mouse(

    input wire [11:0]xpos,
    input wire [11:0]ypos,
    input wire clk40,
    vga_if.in in,
    vga_if.out out,
    input rst

);

always_ff @(posedge clk40) begin
    out.hblnk <= in.hblnk;
    out.vblnk <= in.vblnk;
    out.vsync <= in.vsync;
    out.hsync <= in.hsync;
    out.hcount <= in.hcount;
    out.vcount <= in.vcount;

end

vga_if in_mouse_if();
vga_if out_mouse_if();


MouseDisplay u_mouse_display(
    .pixel_clk(clk40),
    .xpos(xpos),
    .ypos(ypos),
    .hcount(in.hcount),
    .vcount(in.vcount),
    .blank(in.vblnk|in.hblnk),
    .rgb_in(in.rgb),
    .enable_mouse_display_out(),
    .rgb_out(out.rgb)


);

endmodule