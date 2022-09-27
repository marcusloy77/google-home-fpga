# google-home-fpga
Basic google home like program for an fpga board - 
Demo here https://drive.google.com/file/d/1MF6ax6UbcpGVxdYXtRhs66dJFEyQxJIg/view?usp=sharing
utilized vivado, 
all of my coded files are in the src folder, sources1, new

including features such as:
a 'garage door sensor', 
a 'sensor light', 
a 'temprature controller' 
and a 'bathroom light' 

- the idea here is all of these are either set off by buttons/sensors, or a timer that I built in, and react by lighting up leds, where wires connecting these devices would replace the leds in a real scenario

My favourite section of code in this project was probably the temperature controller - firstly, it doesn't rely on the button debouncer, which is a tiny bit janky, and secondly, it has a very smooth response time and settings - demo video of all features i linked here
