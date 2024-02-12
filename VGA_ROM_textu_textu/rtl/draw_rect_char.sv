`timescale 1 ns / 1 ps

module draw_rect_char (
    input  logic clk,
    input  logic rst,
    input logic [7:0] char_pixel,
    output logic [7:0]char_xy,
    output logic [3:0]char_line,
    vga_if.in in,
    vga_if.out out
);

logic [11:0] rgb_nxt;
logic [10:0]re2_vcount;
logic re2_vsync;
logic re2_vblnk;
logic [10:0]re2_hcount;
logic re2_hsync;
logic re2_hblnk;
logic [11:0]re2_rgb;
logic [10:0]re_vcount;
logic re_vsync;
logic re_vblnk;
logic [10:0]re_hcount;
logic re_hsync;
logic re_hblnk;
logic [11:0]re_rgb;
logic [10:0]re3_vcount;
logic re3_vsync;
logic re3_vblnk;
logic [10:0]re3_hcount;
logic re3_hsync;
logic re3_hblnk;
logic [11:0]re3_rgb;
logic [2:0]pixel;
logic [3:0]char_line_nxt;
logic [7:0]char_xy_nxt;

localparam frame_width = 128;
localparam frame_height = 256;
localparam frame_pos_x = 0;
localparam frame_pos_y = 0;

always_ff @(posedge clk) begin
        re_vcount <= in.vcount;
        re_vsync  <= in.vsync;
        re_vblnk  <= in.vblnk;
        re_hcount <= in.hcount;
        re_hsync  <= in.hsync;
        re_hblnk  <= in.hblnk;
        re_rgb    <= in.rgb;
end


always_ff @(posedge clk) begin
        re2_vcount <= re_vcount;
        re2_vsync  <= re_vsync;
        re2_vblnk  <= re_vblnk;
        re2_hcount <= re_hcount;
        re2_hsync  <= re_hsync;
        re2_hblnk  <= re_hblnk;
        re2_rgb    <= re_rgb;
end
always_ff @(posedge clk) begin
        re3_vcount <= re2_vcount;
        re3_vsync  <= re2_vsync;
        re3_vblnk  <= re2_vblnk;
        re3_hcount <= re2_hcount;
        re3_hsync  <= re2_hsync;
        re3_hblnk  <= re2_hblnk;
        re3_rgb    <= re2_rgb;
end

always_ff @(posedge clk) begin
        out.vcount <= re3_vcount;
        out.vsync  <= re3_vsync;
        out.vblnk  <= re3_vblnk;
        out.hcount <= re3_hcount;
        out.hsync  <= re3_hsync;
        out.hblnk  <= re3_hblnk;

end


always_ff @(posedge clk)begin
    if (rst) begin
        char_line <= '0;
        char_xy <= '0;
    end
    else begin
        char_line <=char_line_nxt;
        char_xy <= char_xy_nxt;
    end
end
    
always_ff @(posedge clk) begin
        out.rgb    <= rgb_nxt;
end

assign char_line_nxt = 4'(re_vcount - frame_pos_y);
assign pixel = 3'(re3_hcount - frame_pos_x);
assign char_xy_nxt = {4'((in.hcount - frame_pos_x)>>3), 4'((in.vcount - frame_pos_y)>>4)};

always_comb begin
    if((re3_hcount >= frame_pos_x)&&(re3_vcount >= frame_pos_y)&&(re3_hcount < frame_width+frame_pos_x)&&(re3_vcount < frame_height+frame_pos_y)) begin
        
        if(char_pixel[7-pixel] == 0) begin
                rgb_nxt  = re3_rgb;
        end
        else begin
            rgb_nxt = 12'h0_0_0;

        end
    end
    else begin
        rgb_nxt = re3_rgb;
    end

end



endmodule