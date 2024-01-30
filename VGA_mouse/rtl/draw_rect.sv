`timescale 1 ns / 1 ps

module draw_rect (
    input  logic clk,
    input  logic rst,
    input  logic [11:0] xpos,
    input  logic [11:0] ypos,

    vga_if.in in,
    vga_if.out out
);

import vga_pkg::*;

localparam width = 100; //szerokosc
localparam length = 100; //dlugosc
localparam color = 12'h0_b_a; //color


logic [11:0] rgb_nxt;


/**
 * Internal logic
 */

always_ff @(posedge clk) begin : bg_ff_blk
    if (rst) begin
        out.vcount <= '0;
        out.vsync  <= '0;
        out.vblnk  <= '0;
        out.hcount <= '0;
        out.hsync  <= '0;
        out.hblnk  <= '0;
        out.rgb    <= '0;
    end else begin
        out.vcount <= in.vcount;
        out.vsync  <= in.vsync;
        out.vblnk  <= in.vblnk;
        out.hcount <= in.hcount;
        out.hsync  <= in.hsync;
        out.hblnk  <= in.hblnk;
        out.rgb    <= rgb_nxt;
    end
end

always_comb begin : rect_comb_blk                             
      if ((in.vcount >= ypos)  &&  (in.hcount >= xpos)  &&  (in.vcount < (ypos+length))  &&  (in.hcount < (xpos + width)))  begin               
          rgb_nxt = color; 
      end                            
      else begin
        rgb_nxt = in.rgb;
      end

  end

        

endmodule