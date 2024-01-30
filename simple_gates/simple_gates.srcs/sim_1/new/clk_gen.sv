`timescale 1ns / 1ps
module clk_gen
 #(
 parameter FREQ=1_000_000_000
 )
 (
 output logic clk
 );

 static realtime tper = 1_000_000_000/FREQ; // ns
 initial begin
 clk = 0;
 end
 always begin
 #(0.5*tper) clk = 0;
 #(0.5*tper) clk = 1;
 end
endmodule