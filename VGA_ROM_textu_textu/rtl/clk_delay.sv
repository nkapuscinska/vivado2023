`timescale 1 ns / 1 ps

module clk_delay(
    input logic rst,
    input logic clk,
    output logic clk50hz
);

logic [19:0]q_nxt;
logic [19:0]q;
logic clk50hz_nxt;

always_comb begin
    if(q==100_000) begin
        q_nxt = 0;
        clk50hz_nxt = ~clk50hz;

    end
    else begin

        q_nxt = q+1;
        clk50hz_nxt = clk50hz;
    end

end

always_ff @(posedge clk) begin
    if(rst) begin
        q <= 0;
        clk50hz <=0;
        
    end
    else begin
        q <= q_nxt;
        clk50hz <= clk50hz_nxt;
    end
    
end

endmodule