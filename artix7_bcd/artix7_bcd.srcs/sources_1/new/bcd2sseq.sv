`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.01.2023 23:37:49
// Design Name: 
// Module Name: bcd2sseq
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


module bcd2sseq(
    input a,
    input b,
    input c,
    input d,
    output sseg_a,
    output sseg_b,
    output sseg_c,
    output sseg_d,
    output sseg_e,
    output sseg_f,
    output sseg_g
    );
    
    assign sseg_a = a+c+b*d+(~b)*(~d);
    assign sseg_b = (~b)+(~c)*(~d)+c*d;
    assign sseg_c = b+(~c)+d;
    assign sseg_d = a+(~b)*(~d)+(~b)*c+c*(~d)+b*d*(~a);
    assign sseg_e = (~b)*(~d)+c*(~d);
    assign sseg_f = a+b*(~c)+b*(~d)+(~c)*(~d);
    assign sseg_g = a+b*(~c)+(~b)*c+c*(~d);
    
endmodule
