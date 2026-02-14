# Learning about electronics
* https://forums.raspberrypi.com/viewtopic.php?f=44&t=216304
* the signal called GPIO17 is made available on GPIO connector pin 11
* _**Always**_ disconnect the power supply before starting any wiring work. 
* _**Never**_ wire any pin directly to any other
* _**Never**_ use a voltage greater than 3.3V or less than 0V in a circuit connected to an I/O pin
* LED breakouts?
* LED lights can go in _3.3V_ and out to _ground_   
    * positive goes to 3.3 _negative_ goes to _ground_
    * for LEDs the _shorter_ lead goes to the _negative_ side and longer lead is positive
    * there will also be a notch on the negative side
---
### considering _series wiring or daisy chaining_ since it seems simpler?
* Maintains a constant current through all panels
* if one panel fails, they all fail
* Voltage drop across the circuit can affect the brightness and performance of the last panels in the series
* LED panels are connected in a linear sequence
* The positive terminal of the power source connects to the positive terminal of the first panel
* The negative terminal of the first panel connects to the positive terminal of the second panel, and so on
* The negative terminal of the last panel connects back to the negative terminal of the power source
    * https://www.vst-lighting.com/led-panel-wiring-diagrams
* resistors, connectors, and power supply managers ??
* resistors "soak up" the difference in voltage between the LED voltage and the output voltage of the GPIO pin

---
* `import gpiozero` comes pre-installed on all pi devices
* use _pinout_ diagrams
* pin numbers on breadboard
    * [1, 3, 5, 7, ...] for positive
    * [2, 4, 6, 8, ...] for negative
    * both positive and negative pins can be mapped to [3.3V, 5V, 0v, GPIO_...]
    * use the mapped GPIO values in program and positive and negative + GPIO irl
    * can use `GPIO.setmode(GPIO.BOARD)` to refer to values in the code with their positive and negative pin values
---
### voltage differences by color
* forward voltage varies by color
* _Blue / White / Purple_ LEDs work in a different way, require _2.6-3.4V_, and are very bright even at 2mA
    * 33 blue line stops 
    * 27 brown [white light] line stops
* _Red / Orange / Yellow /Pink_ LEDs require about _1.9-2.2V_ while _green_ LEDs about _1.95-2.2V_
    * 33 red line stops
    * 31 green line stops
    * 3 yellow line stops
    * 22 pink line stops
    * 26 purple line stops
    * 16 orange line stopes
* The voltage that develops across the open contacts is what the GPIO input detects as a "high" or "low"
* make sure power supply has 20% more capacity than max load
* The safest thing to do is have the sense current coming directly from the +3.3V supply through a 3300 ohm resistor, and a 330 ohm resistor in series with the GPIO pin
* remeber to run `GPIO.cleanup()` when done runnning program
* might need jumpers for some lines to bridge the gaps
* resistors might be needed to ensure everything is a consisten brightness
* Note that GPIO0 and GPIO1 should not be used for anything other than HAT identification and GPIO2 and GPIO3 have pull-up resistors fitted on-board
* All Raspberry Pi models come with 40 GPIO pins on the main board
    * good news is that all models use the same numbering and the same pinout
---
### need to use multiple I2C ports
* I2C multiplexing required~~or use a rasberyyi pi that has multiple I2C buses~~
* buy an I2C multiplexer and setup a second i2c port in the rasberry pi software
    * I2C multiplexer `TCA9548A`
    * ~~ideally buy I2C device that can have it's address changed~~
        * check products documentation, product guide, or datasheet for this info
        * i think multiplexers are required
    * https://learn.adafruit.com/working-with-multiple-i2c-devices/overview
    * software requires to unused GPI pins [SDA and SCL]
    * `sudo nano /boot/config.txt` 
    * `dtoverlay=ic2-gpio,bus=3,i2c_gpio_sda=17,i2c_gpio_sda=27`s number 
    * lowest bus must be 3 if adding multiple start with `bus=4` then `bus=3`
    * `i2cdetect -1`
    * software or hardware I2C bus can handle 8 boards
        * each board needs to have a unique address
        * if they share the same address a multiplexer is required
        * I2C requires pull up resistors
* 192 stops 
* 16 GPIO pins per `MCP23017` I2C breakout boards
    * 12 total `MCP23017` boards
* 1 I2C multiplexer `TCA9548A`
    * _each_ `TCA9548A` multiplexer channel can handle 8 `MCP23017` breakout boards
    * 2 `MCP23017` breakout boards per each channel of 8 in `TCA9548A` multiplexer  boards
        * required to use different address per `MCP23017`
* one _hardware_ I2C one _software_ I2C
    * I2C `MCP23017`
* evenly distribute GPIO pins across 2 I2C `MCP23017` ports and the pi's GPIO pins
* each `MCP23017` breakout has 3 pins A0, A1, A2
    * each pin can be connected to GND (0) or 3.3V
    * we set the channel by setting the binary number mapped to A0, A1, A2
        * Ex. A0 = A1 = A2 = GND is 000
        * Ex. A0=3.3V, A1 = A2 = GND is 001
        * repeat above for all 6 channels
    * each `MCP` will controll 16 LEDs
    * when connecting multiple `MCP23017`
        * Channel 0: `MCP` at 0X20 and `MCP` at 0x21
        * Channel 1: `MCP` at 0X20 and `MCP` at 0x21 because 
        * `TCA9548A` multiplexer isolates channels so it doesnt error
---
* resistor formula 
    * $R = \frac{V_{supply}-V_{F}}{I}$
    * $V_{supply}$ of 5.0V
    * $V_F$ is LED forward voltage
    * $I$ is LED current
* power in the resistor
    * $P_R = I^2 * R$
* special GPIO pin for dimming control



---
### Supplies
 * multimeter
 * breadboard
 * jumper cables [male to male, female to male]
 * resistors at least 100 oms
 * rasberry pi zero w
 * wires...
 * wire wrapping tool
 * wire cutters
 * wire strippers
 * heat shrink tubing?
 * voltage tester
 * cta map
 * metal or mdf backing?
 * something to poke holes in hard backing for LEDs to poke through
 * `MCP23017` I2C MCGPIO breakout board
    * https://cdn-learn.adafruit.com/downloads/pdf/mcp230xx-gpio-expander-on-the-raspberry-pi.pdf
* I2C multiplexer `TCA9548A`
* resistors
    * a variety at 100-400 oms
* 5V 3A power supply
* 1 $0.1\mu F$ per MCP minimum
