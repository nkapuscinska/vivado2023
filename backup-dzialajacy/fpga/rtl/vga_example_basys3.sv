`timescale 1 ns / 1 ps

module vga_example_basys3 (
    input  logic clk,
    output logic vs,
    output logic hs,
    output logic [3:0] r,
    output logic [3:0] g,
    output logic [3:0] b,
    output logic pclk_mirror
);

    vga_example vga_example (
        .clk,
        .vs,
        .hs,
        .r,
        .g,
        .b,
        .pclk_mirror
    );

endmodule
