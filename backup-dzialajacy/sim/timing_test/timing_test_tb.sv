`timescale 1 ns / 1 ps

module timing_test_tb;

logic [10:0] vcount;
logic vsync;
logic vblnk;
logic [10:0] hcount;
logic hsync;
logic hblnk;
logic pclk;
int clk_counter;

vga_timing tested_module
(
  .vcount,
  .vsync,
  .vblnk,
  .hcount,
  .hsync,
  .hblnk,
  .pclk
);

initial begin
  $timeformat(-9, 3, "ns", 8);
  $display("%t: start simulation", $realtime);

  pclk = '0;
  hcount = '0;
  vcount = '0;
end

always begin
 #12.5 pclk = ~pclk;
 
end
  
always @(posedge pclk) begin
  clk_counter++; //liczy cykl zegara

  if (clk_counter == 670000) begin
    $display("end of simultion");
    $stop;
  end


end

endmodule
