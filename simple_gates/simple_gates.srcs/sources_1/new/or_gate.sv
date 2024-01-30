`timescale 1ns / 1ps


module or_gate(
    input logic a,
    input logic b,
    output logic y
    );
    
    always_comb y = a | b;
    
endmodule
