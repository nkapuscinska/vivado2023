// File: vga_timing.sv
// This is the vga timing design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.


import vga_pkg::*;

module vga_timing (

   input  logic pclk,
   input logic rst,
   
   vga_if.out out

  );

  logic hblnk_nxt;
  logic vblnk_nxt;
  logic vsync_nxt;
  logic hsync_nxt;
  logic end_of_line;

  assign out.rgb = 12'b0;

  
  vga_h_counter hc (
    .rst(rst),
    .pclk(pclk),
    .hcount(out.hcount),
    .end_of_line(end_of_line)

  );

  vga_v_counter vc(
    .rst(rst),
    .pclk(pclk),
    .end_of_line(end_of_line),
    .vcount(out.vcount)

  );

  always_ff @( posedge pclk ) begin 
    out.vblnk <= vblnk_nxt;
    out.vsync <= vsync_nxt;
    out.hblnk <= hblnk_nxt;
    out.hsync <= hsync_nxt;
  end

  always_comb begin : comb_vblnk
    if((out.vcount >= V_Blank_time)&&(out.vcount < V_Tot_time-1)) begin
      vblnk_nxt = '1;
      
    end
    else begin
      vblnk_nxt = '0;
    end
  end

  always_comb begin : comb_hblnk
    if((out.hcount >= H_Blank_time-1)&&(out.hcount < H_Tot_time-1)) begin // -1
      hblnk_nxt = '1;
      
    end
    else begin
      hblnk_nxt = '0;

    end
    
  end

  always_comb begin : comb_vsync
    if ((out.vcount >= V_Sync_start)&&(out.vcount< V_Back_time)) begin
      vsync_nxt = '1;

    end
    else begin
      vsync_nxt = '0;

    end
    
  end

  always_comb begin : comb_hsync
    if ((out.hcount >= H_Sync_start-1)&&(out.hcount< H_Back_time-1)) begin
      hsync_nxt = '1;

    end
    else begin
      hsync_nxt = '0;

    end
    
  end


endmodule
