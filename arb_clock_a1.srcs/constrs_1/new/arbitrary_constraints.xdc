#Garage Door LEDs
set_property PACKAGE_PIN U16 [get_ports {LEDs[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {LEDs[0]}]
set_property PACKAGE_PIN E19 [get_ports {LEDs[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {LEDs[1]}]
set_property PACKAGE_PIN U19 [get_ports {LEDs[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {LEDs[2]}]
set_property PACKAGE_PIN V19 [get_ports {LEDs[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {LEDs[3]}]

#Garage Door Buttons
set_property PACKAGE_PIN W19 [get_ports btn_main]
set_property IOSTANDARD LVCMOS33 [get_ports btn_main]
set_property PACKAGE_PIN T18 [get_ports btn_inter]
set_property IOSTANDARD LVCMOS33 [get_ports btn_inter]

#Universal Clk
set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVCMOS33} [get_ports clk]
create_clock -period 10.00 [get_ports clk]


#Bathroom Light Puts
set_property PACKAGE_PIN T17 [get_ports motion]
set_property IOSTANDARD LVCMOS33 [get_ports motion]
set_property PACKAGE_PIN W13 [get_ports bathMain]
set_property IOSTANDARD LVCMOS33 [get_ports bathMain]
set_property PACKAGE_PIN V14 [get_ports blight]
set_property IOSTANDARD LVCMOS33 [get_ports blight]


#Night Light Puts
set_property PACKAGE_PIN U17 [get_ports bt1]
set_property IOSTANDARD LVCMOS33 [get_ports bt1]
set_property PACKAGE_PIN V2 [get_ports nightMain]
set_property IOSTANDARD LVCMOS33 [get_ports nightMain]
set_property PACKAGE_PIN V13 [get_ports nightlight]
set_property IOSTANDARD LVCMOS33 [get_ports nightlight]
set_property PACKAGE_PIN V17 [get_ports mode]
set_property IOSTANDARD LVCMOS33 [get_ports mode]
set_property PACKAGE_PIN V16 [get_ports night]
set_property IOSTANDARD LVCMOS33 [get_ports night]






#Temperature Switches
set_property PACKAGE_PIN R2 [get_ports {switches[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {switches[0]}]
set_property PACKAGE_PIN T1 [get_ports {switches[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {switches[1]}]
set_property PACKAGE_PIN U1 [get_ports {switches[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {switches[2]}]
set_property PACKAGE_PIN W2 [get_ports on]
	set_property IOSTANDARD LVCMOS33 [get_ports on]


#Seven-Segment LED Display
set_property PACKAGE_PIN W7 [get_ports {LED_out[6]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[6]}]
set_property PACKAGE_PIN W6 [get_ports {LED_out[5]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[5]}]
set_property PACKAGE_PIN U8 [get_ports {LED_out[4]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[4]}]
set_property PACKAGE_PIN V8 [get_ports {LED_out[3]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[3]}]
set_property PACKAGE_PIN U5 [get_ports {LED_out[2]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[2]}]
set_property PACKAGE_PIN V5 [get_ports {LED_out[1]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[1]}]
set_property PACKAGE_PIN U7 [get_ports {LED_out[0]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[0]}]
set_property PACKAGE_PIN U2 [get_ports {Anode_Activate[0]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {Anode_Activate[0]}]
set_property PACKAGE_PIN U4 [get_ports {Anode_Activate[1]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {Anode_Activate[1]}]
set_property PACKAGE_PIN V4 [get_ports {Anode_Activate[2]}]               
   set_property IOSTANDARD LVCMOS33 [get_ports {Anode_Activate[2]}]
set_property PACKAGE_PIN W4 [get_ports {Anode_Activate[3]}]          
   set_property IOSTANDARD LVCMOS33 [get_ports {Anode_Activate[3]}]