/**
 *  Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Testbench for vga_timing module.
 */

`timescale 1 ns / 1 ps

module vga_timing_tb;

import vga_pkg::*;


/**
 *  Local parameters
 */

localparam CLK_PERIOD = 25;     // 40 MHz


/**
 * Local variables and signals
 */

logic clk;
logic rst;

wire [10:0] vcount, hcount;
wire        vsync,  hsync;
wire        vblnk,  hblnk;


/**
 * Clock generation
 */

initial begin
    clk = 1'b0;
    forever #(CLK_PERIOD/2) clk = ~clk;
end


/**
 * Reset generation
 */

initial begin
                       //rst = 1'b0;
    //#(1.25*CLK_PERIOD) rst = 1'b1;
                       rst = 1'b1;
    #(2.00*CLK_PERIOD) rst = 1'b0;
end


/**
 * Dut placement
 */

vga_timing dut(
    .pclk(clk),
    .rst,
    .vcount,
    .vsync,
    .vblnk,
    .hcount,
    .hsync,
    .hblnk
);

/**
 * Tasks and functions
 */

 // Here you can declare tasks with immediate assertions (assert).


/**
 * Assertions
 */

// Here you can declare concurrent assertions (assert property).

 assert property (@(posedge clk) disable iff(rst)((hcount >=0)&&(hcount<=H_Tot_time)) )
    else $error ("hcount over range: %d", hcount);

 assert property (@(posedge clk) disable iff(rst)((vcount >=0)&&(vcount<=V_Tot_time)) )
    else $error ("vcount over range: %d", vcount);

assert property (@(posedge hblnk)((hcount == H_Blank_time-1)))
    else $error ("Horizontal blank not in time: %d", hcount);

assert property (@(posedge vblnk)((vcount == V_Blank_time)))
    else $error ("Vertical blank not in time: %d", vcount);

assert property (@(posedge vsync)((vcount == V_Sync_start)) )
    else $error ("vsync not in time: %d", vcount);

assert property (@(posedge hsync)((hcount == H_Sync_start-1)) )
    else $error ("hsync not in time: %d", hcount);

/**
 * Main test
 */

initial begin
    //@(posedge rst);
    @(negedge rst);

    wait (vsync == 1'b0);
    @(negedge vsync)
    @(negedge vsync)

    $finish;
end

endmodule
