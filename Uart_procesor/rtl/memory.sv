module memory(
    input logic clk, rst,
    input logic en,
    input logic [7:0] in_data,
    output logic [7:0] addr,
    output logic [15:0] data,
    output logic out_en
   );

 
   enum logic {GET_MSB_BYTE, GET_LSB_BYTE} fsm_state, fsm_state_nxt;

   logic [7:0] addr_nxt;
   logic [15:0] data_nxt;
   logic [7:0] MSB_byte_store, MSB_byte_store_nxt;
   logic en_nxt;


   always_ff @(posedge clk) begin : fsm_state_blk
      if(rst) begin
         fsm_state <= GET_MSB_BYTE;
      end
      else begin
         fsm_state <= fsm_state_nxt;
      end
   end

   always_comb begin : fsm_state_nxt_blk
      case(fsm_state)
         GET_MSB_BYTE:     fsm_state_nxt = en ? GET_LSB_BYTE : GET_MSB_BYTE;
         GET_LSB_BYTE:     fsm_state_nxt = en ? GET_MSB_BYTE : GET_LSB_BYTE;
         default:          fsm_state_nxt = GET_MSB_BYTE;
      endcase
   end

   always_ff @(posedge clk) begin
      if(rst) begin
         out_en            <=    '0;
         addr          <=    '0;
         data          <=    '0;
         MSB_byte_store    <=    '0;
      end
      else begin 
         out_en            <=    en_nxt;
         addr          <=    addr_nxt;
         data          <=    data_nxt;
         MSB_byte_store    <=    MSB_byte_store_nxt;
      end
   end

   always_comb begin
      case(fsm_state)
         GET_MSB_BYTE:     en_nxt = 1'b0;
         GET_LSB_BYTE:     en_nxt = en ? 1'b1 : 1'b0;

         default:          en_nxt = '0;
      endcase
   end

   always_comb begin
      case(fsm_state)
         GET_MSB_BYTE:     addr_nxt = addr;
         GET_LSB_BYTE:     addr_nxt = en ? (addr + 1) : addr;

         default:          addr_nxt = '0;
      endcase
   end

   always_comb begin
      case(fsm_state)
         GET_MSB_BYTE:  data_nxt = data;
         GET_LSB_BYTE:  data_nxt = {MSB_byte_store, in_data};

         default:       data_nxt = '0;
      endcase
   end

   always_comb begin
      case(fsm_state)
         GET_MSB_BYTE:  MSB_byte_store_nxt = in_data;
         GET_LSB_BYTE:  MSB_byte_store_nxt = MSB_byte_store;

         default:       MSB_byte_store_nxt = '0;
      endcase
   end
   // -----------------------------------------------


endmodule