`timescale 1 ns / 1 ps

module draw_rect_ctl (
    input logic clk50hz,
    input  logic left,
    input logic rst,
    output logic [11:0]xpos_ctl,
    output logic [11:0]ypos_ctl,
    input logic [11:0]xpos,
    input logic [11:0]ypos
);

localparam speed = 1;

logic [11:0]y_bonc;
logic [11:0]ypos_ctl_nxt;
logic [11:0]xpos_ctl_nxt;
logic [11:0]y_bonc_nxt;

enum int unsigned {stay = 0, save = 1, none = 2, bonc_down = 3, bonc_up = 4} state, next_state;

always_comb begin: next_state_logic
    case(state)
        stay: begin
            next_state = stay;

        end
        save: begin
            if(ypos_ctl >= 536) begin
                next_state = stay;
            end
            else begin
                next_state = bonc_down;
            end
        end
           
        none: begin
            if(left) begin
                next_state = save;
            end
            else begin
                next_state = none;
            end
        end
        
        bonc_down: begin
            if(ypos_ctl >= 536)begin
                next_state = bonc_up;
            end
            else begin
                next_state = bonc_down;
            end
        end
        
        bonc_up: begin
            if(ypos_ctl == (600-(y_bonc>>1))|| y_bonc < 152) begin
                next_state = save;
            end

            else begin
                next_state = bonc_up;
            end
        end
        default: begin
            next_state = none;
        end


    endcase
end
always_comb begin
    case(state)
        stay: begin
            ypos_ctl_nxt = 536;
            xpos_ctl_nxt = xpos_ctl;
            y_bonc_nxt = y_bonc;
        end
        save: begin
        y_bonc_nxt = 600-ypos_ctl;
        xpos_ctl_nxt = xpos_ctl;
        
        ypos_ctl_nxt = ypos_ctl;
        end

        none: begin
        xpos_ctl_nxt = xpos;
        ypos_ctl_nxt = ypos;

        y_bonc_nxt = y_bonc;
       
        end

        bonc_down: begin
        ypos_ctl_nxt = ypos_ctl + speed;
        xpos_ctl_nxt = xpos_ctl;

        y_bonc_nxt = y_bonc;
        
        end

        bonc_up: begin
        ypos_ctl_nxt = ypos_ctl - speed;
        xpos_ctl_nxt = xpos_ctl;

        y_bonc_nxt = y_bonc;
        end

        default: begin
        xpos_ctl_nxt = xpos_ctl;
        ypos_ctl_nxt = ypos_ctl;

        y_bonc_nxt = y_bonc;

        end

    endcase
end

always_ff @(posedge clk50hz , posedge rst) begin
    if(rst)begin
        xpos_ctl <=  0;
        ypos_ctl <= 0;
        y_bonc <= 0;


    end
    else begin
        xpos_ctl <= xpos_ctl_nxt;
        ypos_ctl <= ypos_ctl_nxt;
        y_bonc <= y_bonc_nxt;

    end

end
always_ff @(posedge clk50hz , posedge rst) begin
    if(rst)begin
        state <= none;
    end
    else begin
        state <= next_state;
    end
end

endmodule