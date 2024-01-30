`timescale 1ns / 1ps

module monitor(
     input wire clk,
     input wire [1:0] led,
     input wire [3:0] sw
     );

     logic [1:0] led_exp;
     int no_of_cases = 16;
     int no_of_errors = 0;
    
     assign led_exp = {&sw[3:2], |sw[1:0]}; // model referencyjny DUT
     
     always @(posedge clk) begin // logika porównawcza
        if (led != led_exp) begin
            no_of_errors+=1;
            $display("%t: Case FAILED for sw=0x%h, led=0x%h, but should be 0x%h", $realtime, sw, led, led_exp);
        end
        
        if (sw == 4'b1111) begin
            if (no_of_errors == 0) begin
                $display("%t: All %0d test cases PASSED", $realtime, no_of_cases);
            end
            else begin
                $display("%t: %0d out of %0d test cases FAILED", $realtime, no_of_errors, no_of_cases);  
            end
            
            $display("%t: Finished test", $realtime);
            $stop;
        end
    end

endmodule