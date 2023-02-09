set_property IOSTANDARD LVCMOS33 [get_ports {leds[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports blue_led]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports enter]
set_property IOSTANDARD LVCMOS33 [get_ports green_led]
set_property IOSTANDARD LVCMOS33 [get_ports red_led]
set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports show]
set_property PACKAGE_PIN D18 [get_ports {leds[3]}]
set_property PACKAGE_PIN G14 [get_ports {leds[2]}]
set_property PACKAGE_PIN M15 [get_ports {leds[1]}]
set_property PACKAGE_PIN M14 [get_ports {leds[0]}]
set_property PACKAGE_PIN T16 [get_ports {switches[3]}]
set_property PACKAGE_PIN W13 [get_ports {switches[2]}]
set_property PACKAGE_PIN P15 [get_ports {switches[1]}]
set_property PACKAGE_PIN G15 [get_ports {switches[0]}]
set_property PACKAGE_PIN M17 [get_ports blue_led]
set_property PACKAGE_PIN P16 [get_ports enter]
set_property PACKAGE_PIN F17 [get_ports green_led]
set_property PACKAGE_PIN V16 [get_ports red_led]
set_property PACKAGE_PIN K18 [get_ports rst]
set_property PACKAGE_PIN K19 [get_ports show]

set_property PACKAGE_PIN K17 [get_ports clk]
create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { clk }];