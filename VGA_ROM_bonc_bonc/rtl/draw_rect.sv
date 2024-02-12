`timescale 1 ns / 1 ps

module draw_rect (
    input  logic clk,
    input  logic rst,
    input  logic [11:0] xpos,
    input  logic [11:0] ypos,
    input  logic [11:0] rgb_pixel,
    output logic [11:0] pixel_addr,

    vga_if.in in,
    vga_if.out out
);

import vga_pkg::*;

localparam width = 48; //szerokosc
localparam length = 64; //dlugosc
// localparam color = 12'h0_b_a; //color


logic [11:0] rgb_nxt;
logic [10:0]re2_vcount;
logic re2_vsync;
logic re2_vblnk;
logic [10:0]re2_hcount;
logic re2_hsync;
logic re2_hblnk;
logic [11:0]re2_rgb;
logic [10:0]re_vcount;
logic re_vsync;
logic re_vblnk;
logic [10:0]re_hcount;
logic re_hsync;
logic re_hblnk;
logic [11:0]re_rgb;


/**
 * Internal logic
 */
always_ff @(posedge clk) begin
    if (rst) begin
        re_vcount <= '0;
        re_vsync  <= '0;
        re_vblnk  <= '0;
        re_hcount <= '0;
        re_hsync  <= '0;
        re_hblnk  <= '0;
        re_rgb    <= '0;
    end
    else begin
    re_vcount <= in.vcount;
    re_vsync  <= in.vsync;
    re_vblnk  <= in.vblnk;
    re_hcount <= in.hcount;
    re_hsync  <= in.hsync;
    re_hblnk  <= in.hblnk;
    re_rgb    <= in.rgb;
    end
end

always_ff @(posedge clk) begin
    if (rst) begin
        re2_vcount <= '0;
        re2_vsync  <= '0;
        re2_vblnk  <= '0;
        re2_hcount <= '0;
        re2_hsync  <= '0;
        re2_hblnk  <= '0;
        re2_rgb    <= '0;
    end 
    else begin
    re2_vcount <= re_vcount;
    re2_vsync  <= re_vsync;
    re2_vblnk  <= re_vblnk;
    re2_hcount <= re_hcount;
    re2_hsync  <= re_hsync;
    re2_hblnk  <= re_hblnk;
    re2_rgb    <= re_rgb;
    end
end

always_ff @(posedge clk) begin : rect_ff_blk
    if (rst) begin
        out.vcount <= '0;
        out.vsync  <= '0;
        out.vblnk  <= '0;
        out.hcount <= '0;
        out.hsync  <= '0;
        out.hblnk  <= '0;
        out.rgb    <= '0;
        pixel_addr <= '0;
    end 
    else begin
        out.vcount <= re2_vcount;
        out.vsync  <= re2_vsync;
        out.vblnk  <= re2_vblnk;
        out.hcount <= re2_hcount;
        out.hsync  <= re2_hsync;
        out.hblnk  <= re2_hblnk;
        out.rgb    <= rgb_nxt;
        pixel_addr <= {6'(in.vcount-ypos),6'(in.hcount - xpos)};
    end
end

always_comb begin : rect_comb_blk                             
      if ((re2_vcount >= ypos)  &&  (re2_hcount >= xpos)  &&  (re2_vcount < (ypos+length))  &&  (re2_hcount < (xpos + width)))  begin               
          rgb_nxt = rgb_pixel; 
      end                            
      else begin
        rgb_nxt = re2_rgb;
      end

  end

        

endmodule