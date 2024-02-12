`timescale 1 ns / 1 ps

module uart_basys3 (
    input  logic clk,
    input logic btnC,
    input logic btnU,
    input logic sw,
    input logic RsRx,

    output logic RsTx,
    output logic [1:0]JA,
    output logic [3:0]an,
    output logic [6:0]seg,
    output logic dp
);

    top_uart top_uart (
        .clk,
        .rst(btnC),
        .loopback_enable(sw),
        .btnU,
        .rx(RsRx),
        .tx(RsTx),
        .rx_monitor(JA[0]),
        .tx_monitor(JA[1]),
        .an,
        .seg,
        .dp
    );

endmodule
