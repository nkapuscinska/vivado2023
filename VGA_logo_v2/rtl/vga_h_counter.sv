`timescale 1 ns / 1 ps

//horizontal counter counts every impluse of pclk 

import vga_pkg::*;


module vga_h_counter(

    input logic rst,
    input logic pclk,
    output logic [10:0] hcount,
    output logic end_of_line
    
);

logic [10:0] hcount_nxt = '0;

always_ff @( posedge pclk ) begin : h_counter_blk
    if(rst) begin
        hcount <= '0;
    end
    else begin
        hcount <= hcount_nxt;
    end
end

always_comb begin : h_counter_nxt_blk
    if (hcount == H_Tot_time-1) begin
        hcount_nxt = '0;
        end_of_line = '0;
        end_of_line = '1;

    end
    // else if (hcount == H_Tot_time-2) begin
    //     
    //     hcount_nxt = hcount + 1;

    // end

    else begin
        
        hcount_nxt = hcount + 1;
        end_of_line = '0;

    end
end

endmodule