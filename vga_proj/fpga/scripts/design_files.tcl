#Specify design files

# Specify .xdc files location             -- EDIT
read_xdc {
    constraints/vga_example.xdc
}

# Specify verilog design files location   -- EDIT
read_verilog -sv {
    rtl/vga_example_basys3.sv
    ../rtl/vga_example.sv
    ../rtl/vga_timing.sv
    ../rtl/vga_h_counter.sv
    ../rtl/vga_v_counter.sv
    
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

