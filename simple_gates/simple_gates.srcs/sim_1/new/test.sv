`timescale 1ns / 1ps

localparam FREQ = 1_000_000_000;

module test();

    wire [3:0] t_sw;
    wire [1:0] t_led;
    wire clk;
    
    
    clk_gen #(.FREQ(FREQ)) u_clk_gen (.clk(clk));
    
    
    top u_top
    (
        .sw(t_sw),
        .led(t_led)
    );
    
    tpg u_tpg
    (
       .sw(t_sw),
       .clk(clk)
    );
    
    monitor u_monitor
    (
        .led(t_led),
        .sw(t_sw),
        .clk(clk)
    );
endmodule
