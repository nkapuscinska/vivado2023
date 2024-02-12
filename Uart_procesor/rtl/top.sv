`timescale 1 ns / 1 ps

module top(
    input logic clk,
    input logic rst,
    input logic [6:0] sw,
    input logic btnU,
    input logic btnD,
    input logic rx,
    output logic tx,
    output logic led,
    output logic [3:0] an,
    output logic [6:0] seg,
    output logic dp
);


    localparam WIDTH = 16;
    localparam IRAM_ADDR_BITS = 8;

    logic rd_uart;
    logic rx_empty;
    logic [7:0] r_data;
    logic en;
    logic [7:0]addr;
    logic [15:0]data;
    logic [3:0] hex3, hex2, hex1, hex0;
    logic PCenable;
    logic extCtl;
    logic [3:0]monRFSrc;
    logic [WIDTH-1:0]monRFData;
    logic [WIDTH-1:0]monInstr;
    logic [2*IRAM_ADDR_BITS-1:0]monPC;
    logic btnU_db;


    assign monRFSrc     =   sw[5:2];
    assign rd_uart  =   !rx_empty;
    assign PCenable     =   sw[6] ? 1'b1 : btnU_db;      
    assign led          =   monRFData[0];               
  
    debounce btnU_debounce (
        .clk,
        .reset(rst),
        .sw(btnU),
        .db_level(),
        .db_tick(btnU_db)
    );

    debounce btnD_debounce (
        .clk,
        .reset(rst),
        .sw(btnD),
        .db_level(extCtl),
        .db_tick()
    );


    micro  #(
        .WIDTH(WIDTH),
        .IRAM_ADDR_BITS(IRAM_ADDR_BITS)
    )
    u_micro (
        .clk,
        .reset(rst),

        .PCenable,
        .extCtl,
        .monRFSrc,
        .monRFData,
        .monInstr,
        .monPC,

        .iram_wa(addr),
        .iram_din(data),
        .iram_wen(en)
    );

    disp_hex_mux u_disp_hex_mux (
        .clk,
        .reset(rst),
        .hex0,
        .hex1,
        .hex2,
        .hex3,
        .dp_in(4'b1111),
        .an,
        .sseg({dp, seg})
    );

    always_comb begin : display_hex_blk
        case(sw[1:0])
            2'b00:      {hex3, hex2, hex1, hex0} = monRFData;
            2'b01:      {hex3, hex2, hex1, hex0} = monInstr;
            2'b10:      {hex3, hex2, hex1, hex0} = monPC;
            default:    {hex3, hex2, hex1, hex0} = 16'b0;
        endcase
    end

    uart #( .DBIT(8),
            .SB_TICK(16),
            .DVSR(326),
            .DVSR_BIT(9),
            .FIFO_W(2) 
            )
    u_uart (
        .clk,
        .reset(rst),
        .rd_uart,
        .wr_uart(),
        .rx,
        .tx,
        .w_data(),
        .tx_full(),
        .rx_empty,
        .r_data
    );

    memory u_memory(
        .clk,
        .rst,
        .en(rd_uart),
        .in_data(r_data),
        .addr,
        .data,
        .out_en(en)
    );

endmodule