Learning about electronics...
* refrence: https://forums.raspberrypi.com/viewtopic.php?f=44&t=216304
* the signal called GPIO17 is made available on GPIO connector pin 11
* Always disconnect the power supply before starting any wiring work. 
* Never wire any pin directly to any other
* Never use a voltage greater than 3.3V or less than 0V in a circuit connected to an I/O pin
* RPI Zero W?
* LED breakouts?
* LED lights can go in _3.3V_ and out to _ground_   
    * positive goes to 3.3 negative goes to ground
    * for LEDs the shorter lead goes to the negative side and longer lead is positive
    * there will also be a notch on the negative side
* considering series wiring since it seems simpler?
    * Maintains a constant current through all panels
    * if one panel fails, they all fail
    * Voltage drop across the circuit can affect the brightness and performance of the last panels in the series
    * LED panels are connected in a linear sequence
    * The positive terminal of the power source connects to the positive terminal of the first panel
    * The negative terminal of the first panel connects to the positive terminal of the second panel, and so on
    * The negative terminal of the last panel connects back to the negative terminal of the power source
    * https://www.vst-lighting.com/led-panel-wiring-diagrams
* resisotrs, connectors, and power supply managers ??
* resistors "soak up" the difference in voltage between the LED voltage and the output voltage of the GPIO pin
* import `gpiozero` comes pre-installed on all pi devices
* use pinout diagrams
* pin numbers on breadboard
    * [1, 3, 5, 7, ...] for positive
    * [2, 4, 6, 8, ...] for negative
    * both positive and negative pins can be mapped to [3.3V, 5V, 0v, GPIO_...]
    * use the apped GPIO values in program and positive and negative + GPIO irl
    * can use `GPIO.setmode(GPIO.BOARD)` to refer to values in the code with their positive and negative pin values
* **voltage differences by color**
    * Blue and white LEDs work in a different way, require 2.6-2.7V, and are very bright even at 2mA
    * red LEDs require about 1.87V @ 2mA, while yellow and green LEDs about 1.95V @ 3mA
* The voltage that develops across the open contacts is what the GPIO input detects as a "high" or "low"
* Therefore the safest thing to do is have the sense current coming directly from the +3.3V supply through a 3300 ohm resistor, and a 330 ohm resistor in series with the GPIO pin
* remeber to run `GPIO.cleanup()` when done runnning program
* might need jumpers for some lines to bridge the gaps
* resistors might be needed to ensure everything is a consisten brightness
* confirm or deny: Note that GPIO0 and GPIO1 should not be used for anything other than HAT identification and GPIO2 and GPIO3 have pull-up resistors fitted on-board
* All Raspberry Pi models come with 40 GPIO pins on the main board
    * good news is that all models use the same numbering and the same pinout

* **need to use multiple I2C ports**
    * I2c multiplexing or use a rasberyyi pi that has multiple I2C buses
    * either buy a multiplexer or setup a second i2c port in the rasberry pi software
        * I2C multiplexer `TCA9548A`
        * ideally buy I2C device that can have it's address changed
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
    * 192 stops 16 GPIO pins per board is 12 total boards
        * evenly distributed across 2 I2C ports and the pi's GPIO pins
        * one hardward I2C one software

* special GPIO pin for dimming control




**Supplies**
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
 * metal or dnf backing?
 * something to poke holes in hard backing for LEDs to poke through
 * `MCP23017` I2C MCGPIO breakout board
    * https://cdn-learn.adafruit.com/downloads/pdf/mcp230xx-gpio-expander-on-the-raspberry-pi.pdf
 

