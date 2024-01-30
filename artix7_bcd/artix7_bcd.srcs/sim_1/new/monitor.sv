`timescale 1ns / 1ps

module sseg_x4_monitor (
        input  wire  [6:0]  sseg // anode enable (active LOW)
    );

    // bits for segments  gfedcba
    localparam SSEG_0 = 7'b1000000;
    localparam SSEG_1 = 7'b1111001;
    localparam SSEG_2 = 7'b0100100;
    localparam SSEG_3 = 7'b0110000;
    localparam SSEG_4 = 7'b0011001;
    localparam SSEG_5 = 7'b0010010;
    localparam SSEG_6 = 7'b0000010;
    localparam SSEG_7 = 7'b1111000;
    localparam SSEG_8 = 7'b0000000;
    localparam SSEG_9 = 7'b0010000;

    logic [3:0]  char;     // decoded character
    logic [15:0] sseg_tmp; // displayed string (4 characters) - temporary storage

    initial begin
        sseg = 16'hxxxx;
    end

    always_comb begin
        // decoding character
        case(sseg)
            SSEG_0: char  = 4'h0;
            SSEG_1: char  = 4'h1;
            SSEG_2: char  = 4'h2;
            SSEG_3: char  = 4'h3;
            SSEG_4: char  = 4'h4;
            SSEG_5: char  = 4'h5;
            SSEG_6: char  = 4'h6;
            SSEG_7: char  = 4'h7;
            SSEG_8: char  = 4'h8;
            SSEG_9: char  = 4'h9;
            default: char = 4'hx;
        endcase
        
    end

endmodule
