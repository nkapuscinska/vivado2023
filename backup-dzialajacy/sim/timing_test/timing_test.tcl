# Specify files for test: top_example
    
# Specify verilog design files location   -- EDIT
#read_verilog {
#    ../src/rtl/top_example.v
#}

# Specify vhdl design files location      -- EDIT
#read_vhdl {
#    rtl/MouseCtl.vhd    
#    rtl/MouseDisplay.vhd
#}

# Specify files for memory initialization -- EDIT
#read_mem {
#    rtl/image_rom.data
#}

# Specify simulation files location       -- EDIT
add_files -fileset sim_1 {
    timing_test/timing_test_tb.sv
    ../rtl/vga_example.sv
    ../rtl/vga_timing.sv
    ../rtl/vga_h_counter.sv
    ../rtl/vga_v_counter.sv

}

#set maximum simulation time
update_compile_order -fileset sim_1
set_property -name {xsim.simulate.runtime} -value {1s} -objects [get_filesets sim_1]

