// File: vga_timing.sv
// This is the vga timing design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.



localparam start = 0;

localparam H_Tot_time = 1056 ;
localparam H_Blank_time = 800 ;
localparam H_Sync_start = 840 ; //porch end
localparam H_Back_time = 968 ;

////////////////////////////////////////
// localparam H_Tot_time = 1056 ;
// localparam H_Blank_time = 800 ;
// localparam H_Sync_start = 840 ; //porch end
// localparam H_Back_time = 968 ;
/////////////////////////////////////////

localparam V_Tot_time = 628 ;
localparam V_Blank_time = 600 ;
localparam V_Sync_start = 601 ; //porch end
localparam V_Back_time =  605;




module vga_timing (
  output logic [10:0] vcount,
  output logic vsync,
  output logic vblnk,
  output logic [10:0] hcount,
  output logic hsync,
  output logic hblnk,
  input  logic pclk

  );

  logic hblnk_nxt;
  logic vblnk_nxt;
  logic vsync_nxt;
  logic hsync_nxt;
  logic end_of_line;

  
  vga_h_counter hc (
    .pclk(pclk),
    .hcount(hcount),
    .end_of_line(end_of_line)

  );

  vga_v_counter vc(
    .pclk(pclk),
    .end_of_line(end_of_line),
    .vcount(vcount)

  );

  always_ff @( posedge pclk ) begin 
    vblnk <= vblnk_nxt;
    vsync <= vsync_nxt;
    hblnk <= hblnk_nxt;
    hsync <= hsync_nxt;
  end

  always_comb begin : comb_vblnk
    if((vcount >= V_Blank_time)&&(vcount <= V_Tot_time)) begin
      vblnk_nxt = '1;
      
    end
    else begin
      vblnk_nxt = '0;
    end
  end

  always_comb begin : comb_hblnk
    if((hcount >= H_Blank_time)&&(hcount < H_Tot_time-1)) begin
      hblnk_nxt = '1;
      
    end
    else begin
      hblnk_nxt = '0;

    end
    
  end

  always_comb begin : comb_vsync
    if ((vcount>= V_Sync_start)&&(vcount< V_Back_time)) begin
      vsync_nxt = '1;

    end
    else begin
      vsync_nxt = '0;

    end
    
  end

  always_comb begin : comb_hsync
    if ((hcount>= H_Sync_start)&&(hcount< H_Back_time)) begin
      hsync_nxt = '1;

    end
    else begin
      hsync_nxt = '0;

    end
    
  end


endmodule
