`timescale 1 ns / 1 ps

module char_rom (
    input   logic  clk,
    input   logic [7:0] char_xy,  
    output  logic [6:0] char_code
);

    localparam text = "The capybara or greater capybara is a giant cavy rodent native to South America";
    
    logic [3:0] x_pos;
    logic [3:0] y_pos;
    logic [7:0] char_code_nxt;

    logic [255:0][7:0] rom = {<<8{text}};

    assign x_pos = char_xy[7:4];
    assign y_pos = char_xy[3:0];
    
    assign char_code_nxt   =  rom[x_pos + y_pos*16][7:0];
    always_ff @(posedge clk) begin : char_code_blk
        char_code <= char_code_nxt[6:0];
    end

endmodule