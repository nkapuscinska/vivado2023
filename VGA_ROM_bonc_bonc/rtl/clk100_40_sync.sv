`timescale 1 ns / 1 ps

module clk100_40_sync (
    input logic [11:0]xpos,
    input logic [11:0]ypos,
    input logic left,
    input logic clk40,
    output logic [11:0]xpos_s,
    output logic [11:0]ypos_s,
    output logic left_s
);

always_ff @(posedge clk40) begin
    xpos_s <= xpos;
    ypos_s <= ypos;
    left_s <= left;

end

endmodule