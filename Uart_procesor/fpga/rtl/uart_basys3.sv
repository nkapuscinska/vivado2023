`timescale 1 ns / 1 ps

module uart_basys3 (
    input  logic clk,
    input logic btnC,
    input logic btnU,
    input logic btnD,
    input logic sw,
    input logic RsRx,

    output logic RsTx,
    output logic [3:0]an,
    output logic [6:0]seg,
    output logic led,
    output logic dp
);

    top top (
        .clk,
        .rst(btnC),
        .btnU,
        .btnD,
        .sw,
        .rx(RsRx),
        .tx(RsTx),
        .led,
        .an,
        .seg,
        .dp
    );

endmodule
