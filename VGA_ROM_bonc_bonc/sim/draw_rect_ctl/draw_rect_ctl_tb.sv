`timescale 1 ns / 1 ps

module draw_rect_ctl_tb;


/**
 *  Local parameters
 */
localparam CLK100_PERIOD = 10_000_000;     // 100Hz


/**
 * Local variables and signals
 */

logic clk, rst;
logic left;
logic [11:0]xpos, ypos;
logic [11:0]xpos_ctl, ypos_ctl;


/**
 * Clock generation
 */

initial begin
    clk = 1'b0;
    forever #(CLK100_PERIOD/2) clk = ~clk;
end

/**
 * Submodules instances
 */

draw_rect_ctl u_draw_rect_ctl(
    .clk50hz(clk),
    .rst,
    .xpos,
    .ypos,
    .left,
    .xpos_ctl,
    .ypos_ctl

);


/**
 * Main test
 */

initial begin
    rst = 1'b0;
    left = 1'b0;
    xpos = 100;
    ypos = 0;
    # 30_000_000 rst = 1'b1;
    # 30_000_000 rst = 1'b0;
    # 100_000_000 left = 1'b1;
    # 30_000_000 left = 1'b0;
    # 2_000_000_000;
    # 2_000_000_000;
    # 2_000_000_000;
    # 2_000_000_000;
    # 2_000_000_000;
    # 2_000_000_000;
    # 2_000_000_000;
    # 2_000_000_000;
    # 2_000_000_000;
    # 2_000_000_000;
    // End the simulation.
    $display("Simulation is over, check the waveforms.");
    $finish;
end

endmodule
