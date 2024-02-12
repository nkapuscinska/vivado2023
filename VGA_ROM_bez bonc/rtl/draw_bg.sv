/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Draw background.
 */


`timescale 1 ns / 1 ps

module draw_bg (
    input  logic clk,
    input  logic rst,

    vga_if.in in,
    vga_if.out out
);

import vga_pkg::*;


/**
 * Local variables and signals
 */

logic [11:0] rgb_nxt;


/**
 * Internal logic
 */

always_ff @(posedge clk) begin : bg_ff_blk
    if (rst) begin
        out.vcount <= '0;
        out.vsync <= '0;
        out.vblnk <= '0;
        out.hcount <= '0;
        out.hsync <= '0;
        out.hblnk <= '0;
        out.rgb   <= '0;
    end else begin
        out.vcount <= in.vcount;
        out.vsync <= in.vsync;
        out.vblnk <= in.vblnk;
        out.hcount <= in.hcount;
        out.hsync  <= in.hsync;
        out.hblnk  <= in.hblnk;
        out.rgb    <= rgb_nxt;
    end
end

always_comb begin : bg_comb_blk
    if (in.vblnk || in.hblnk) begin             // Blanking region:
        rgb_nxt = 12'h0_0_0;                    // - make it it black.
    end                              // Active region:
        //my logo 
    else if (((50<in.hcount)&&(in.hcount<100)&&(50<in.vcount)&&(in.vcount<550))||((100<in.vcount)&&(in.vcount<550)&&(300<=in.hcount)&&(in.hcount<350))) begin //N
        rgb_nxt = 12'he_b_b;
      end
  
      else if ((100<=in.hcount)&&(in.hcount<300)&&(100<in.vcount)&&(in.vcount<150))begin //N
        rgb_nxt = 12'he_b_b;
  
      end
      else if ((400<in.hcount)&&(in.hcount<450)&&(50<in.vcount)&&(in.vcount<550))begin //K
        rgb_nxt = 12'he_b_b;
      end
      else if((450<=in.hcount)&&(in.hcount<600)&&(225<=in.vcount)&&(in.vcount<275))begin//K
        rgb_nxt = 12'he_b_b;
      end
      //skos
      else if((450<=in.hcount)&&(in.hcount<=700)&&(200<=in.vcount)&&(in.vcount<=550))begin
        if(((in.hcount)<= (in.vcount+200))&&((in.hcount)>=(in.vcount+150)))begin
          rgb_nxt = 12'he_b_b;
        end
        else  rgb_nxt = 12'h4_4_4;  
      end
      
      else begin  
          if (in.vcount == 0)                     // - top edge:
          rgb_nxt = 12'hf_f_0;                // - - make a yellow line.
      else if (in.vcount == VER_PIXELS - 1)   // - bottom edge:
          rgb_nxt = 12'hf_0_0;                // - - make a red line.
      else if (in.hcount == 0)                // - left edge:
          rgb_nxt = 12'h0_f_0;                // - - make a green line.
      else if (in.hcount == HOR_PIXELS - 1)   // - right edge:
          rgb_nxt = 12'h0_0_f;                // - - make a blue line.
      else rgb_nxt = 12'h4_4_4; 
      
    end
    
  end

        

endmodule
