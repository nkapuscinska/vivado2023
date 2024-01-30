`timescale 1ns / 1ps


module top(
    input wire [3:0] sw,
    output wire [1:0] led
    );
    or_gate u_our_gate
    (
        .a(sw[1]),
        .b(sw[0]),
        .y(led[0])  
    );
    
    and_gate u_and_gate
    (
        .a(sw[3]),
        .b(sw[2]),
        .y(led[1])
    );
endmodule
