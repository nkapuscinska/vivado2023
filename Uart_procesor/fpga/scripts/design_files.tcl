#Specify design files

# Specify .xdc files location             -- EDIT
read_xdc {
    constraints/uart.xdc
}

# Specify verilog design files location   -- EDIT
read_verilog -sv {
    rtl/uart_basys3.sv
    ../rtl/top.sv
    ../rtl/adder.v
    ../rtl/alu.v
    ../rtl/branch_ctl.v
    ../rtl/control_unit.v
    ../rtl/decode.v
    ../rtl/flopenr.v
    ../rtl/flopr.v
    ../rtl/imem.v
    ../rtl/memory.sv
    ../rtl/micro_test.v
    ../rtl/micro.v
    ../rtl/regfile.v
    ../rtl/mux2.v
    ../rtl/debounce.v
    ../rtl/disp_hex_mux.v
    ../rtl/fifo.v
    ../rtl/flag_buf.v
    ../rtl/mod_m_counter.v
    ../rtl/uart_rx.v
    ../rtl/uart_tx.v
    ../rtl/uart.v
    
}

# Specify vhdl design files location      -- EDIT
#read_vhdl {
#    rtl/MouseCtl.vhd    
#    rtl/MouseDisplay.vhd
#}

# Specify files for memory initialization -- EDIT
#read_mem {
#    rtl/image_rom.data
#}

