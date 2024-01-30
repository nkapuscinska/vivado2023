`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.01.2023 00:24:25
// Design Name: 
// Module Name: test
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

localparam FREQ = 1_000_000_000;

module test();

    wire [3:0] sw;
    wire [1:0] seg;

    
    
    
    artix7_bcd u_artix7_bcd
    (
        .sw(sw),
        .seg(seg)
        
    );
    
    tpg u_tpg
    (
       .sw(sw)
    );
    
    sseg_x4_monitor u_monitor
    (
        .seg(seg),
        .sw(sw)
    );
endmodule
