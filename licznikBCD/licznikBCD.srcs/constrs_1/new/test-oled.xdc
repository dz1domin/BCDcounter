#set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 33]];
set_property PACKAGE_PIN Y9 [get_ports {clk}];  # "GCLK"
set_property PACKAGE_PIN T18 [get_ports {rst}];  # "BTNU"

set_property PACKAGE_PIN U10  [get_ports {dco}];  # "OLED-DC"
set_property PACKAGE_PIN U9   [get_ports {res}];  # "OLED-RES"
set_property PACKAGE_PIN AB12 [get_ports {sclk}];  # "OLED-SCLK"
set_property PACKAGE_PIN AA12 [get_ports {sdout}];  # "OLED-SDIN"
set_property PACKAGE_PIN U11  [get_ports {vbat}];  # "OLED-VBAT"
set_property PACKAGE_PIN U12  [get_ports {vdd}];  # "OLED-VDD"
set_property PACKAGE_PIN Y11  [get_ports {gen}];  # "JA1"
#set_property PACKAGE_PIN P16 [get_ports {start}];  # "BTNC"
set_property PACKAGE_PIN W7 [get_ports {inputA}];  # "JD1_N"
set_property PACKAGE_PIN V5 [get_ports {inputB}];  # "JD2_P"
set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 34]];
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]];


