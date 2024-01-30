`timescale 1ns / 1ps


module tpg
    (
    input wire clk,
    output logic [3:0] sw
    );
    
   initial begin
        $timeformat(-9, 3, "ns", 10);
        $display("%t: Starting test", $realtime);
        sw = 4'b0000;
   end
     
   always @(negedge clk) sw++; // driver
endmodule
