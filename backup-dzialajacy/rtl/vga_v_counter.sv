`timescale 1 ns / 1 ps

// counts vertical position (pionowo), its depends on horizontal counter

module vga_v_counter(

    input logic pclk,
    input logic end_of_line,
    output logic [10:0] vcount
    

);
    logic [10:0] vcount_nxt = '0;

    always_ff @( posedge pclk ) begin : v_count_blk
        vcount <= vcount_nxt;
        
    end

    always_comb begin : v_count_nxt_blk
        if(end_of_line)begin
            if (vcount == 627) begin
                vcount_nxt = 0;
            end
            else begin
                vcount_nxt = vcount+1;   
            end
            
            
        end
        else begin
            vcount_nxt = vcount;
            
        end
        
    end


endmodule