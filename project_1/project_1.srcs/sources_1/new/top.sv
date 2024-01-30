`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.01.2023 23:17:17
// Design Name: 
// Module Name: artix7_bcd
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module artix7_bcd(
    input [7:0] sw,
    output [6:0] seg,
    output [3:0] an
    );
    
 bcd2sseq u_bcd2sseg
    (
    .a(sw[0]),
    .b(sw[1]),
    .c(sw[2]),
    .d(sw[3]),
    .sseg_a(seg[0]),
    .sseg_b(seg[1]),
    .sseg_c(seg[2]),
    .sseg_d(seg[3]),
    .sseg_e(seg[4]),
    .sseg_f(seg[5]),
    .sseg_g(seg[6])
    );
endmodule
