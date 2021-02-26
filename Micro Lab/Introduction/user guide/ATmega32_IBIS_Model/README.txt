Atmel Microcontroller IBIS models
=================================
The IBIS (I/O Buffer Information Specification) is an international standard for the
electrical specification of chip drivers and receivers. It provides a standard for
recording parameters like driver output impedance, rise/fall time, and input loading.
Note that there are different libraries for each AVR family of microcontrollers.
The files can be found on http://www.atmel.com.


Model Generation
----------------
Models made up to and including September 2008 were made with s2ibis2 v2.1 and
with the temperature range -55/27/125 degrees Celsius.
Models made from October 2008 and onwards were made with s2ibis3 v2.1 and
with the temperature range -40/27/145 degrees Celsius.


Naming convention
-----------------
IBIS development software requires the name of the IBIS model to be in DOS8.3 format,
all lowercase. The resulting file names may be somewhat cryptic.

A guide to their interpretation follows.
A complete overview is also provided as an Excel sheet, "avr_ibis.xls".

Example:

  ATmega169 @ 3.3V (10%) in TQFP64.

    m1693t64.ibs
    ||  |||
    ||  |||Number of package pins. This can be 1-2 figures long.
    ||  ||  Note! A 100-pin package is "00", 208 is "08", i.e. the
    ||  ||  leading zero is NOT deleted in this case.
    ||  ||
    ||  ||Type of package: t = TQFP
    ||  |                  m = MLF
    ||  |                  p = PDIP
    ||  |                  s = SOIC
    ||  |                  o = SOP
    ||  |                  w = SOT
    ||  |                  l = PLCC
    ||  |                  c = CTBGA
    ||  |                  g = TLLGA
    ||  |
    ||  |Supply voltage: 2 = 1.8V/2.0V/2.2V
    ||                   3 = 3.0V/3.3V/3.6V 
    ||                   5 = 4.5V/5.0V/5.5V
    ||
    ||Microcontroller number. This can be 1-3 figures long.
    |  Note! Check device numbers >3 figures long below !
    |  See Excel sheet for complete overview.
    |
    |  X.ref:(ATmega) 16U2  = 16u
    |        (ATmega) 128A  = 28a
    |        (ATmega) 1280  = 280
    |        (ATmega) 1281  = 281
    |        (ATmega) 1284  = 284
    |        (ATmega) 2560  = 560
    |        (ATmega) 2561  = 561
    |        (ATmega) 3250  = 250
    |        (ATmega) 6450  = 450
    |        (ATmega) 3290  = 290
    |        (ATmega) 6490  = 490
    |        (ATmega) 8515  = 851
    |        (ATmega) 8535  = 853
    |
    |        (ATtiny) 2313  = 23
    |        (ATtiny) 2313A = 23a
    |        (ATtiny) 261A  = 26a 
    |        (ATtiny) 4313  = 43
    |        (ATtiny) 461A  = 46a 
    |        (ATtiny) 861A  = 86a 
    |
    |        (AT32AP) 7000  = 700
    |        (AT32AP) 7001  = 700
    |        (AT32AP) 7002  = 700
    |        (AT32AP) 7200  = 720
    |
    |
    |Microcontroller family: m = ATmega
                             n = ATmega
                             t = ATtiny
                             x = ATxmega
                             u = AT32UC
                             a = AT32AP
                             c = C51


Rise/Fall curves - 50/2000 ohm load
-----------------------------------
These models contain Rise/Fall curves for both 50 ohms and 2000 ohms load.
While the 50 ohm curves are indeed recommended by the IBIS standard
(to be included if load >100 ohms) and give valuable information about
output impedance, some will report errors at 2 volts and 50 ohms if run
through a utility like IBISCHK. Note that this is not due to an error in the model, 
but operation outside the drive capability of the circuit.


picoPower AVR models
--------------------
Microcontrollers with picoPower technology use the same I/O pads as standard
megaAVR. Use the corresponding megaAVR models for picoPower devices.
Thus the model for ATmega169P is the same as for ATmega169.

In ATmega48P/88P/168P/328P - PORTB pin 7 is slightly different from the one
used in ATmega48/88/168. Pin PB7 in ATmega48P/88P/168P/328P is modeled as
pin XTAL2 in the ATmega1281.


"A" devices
-----------
Some (but far from all!) products have had their IOs replaced during production optimization,
thus the model for ATmega16A is not equivalent with the model for ATmega16. Models for both
variants are available.


ATmega16U2 USB device
---------------------
The DM/DP USB pins are only specified with 3.3V and thus that data is used also for the
IBIS model. It is only included in the circuit model for 3.3V, the 2.0V and 5.0V are
set to "NC". Please also note that temperatures used are -40/25/85 degree Celsius,
which gives a discrepancy in the maxtemp case where all other IO are +145C.


Xmega models
------------
The GPIO of Xmega family is very versatile and can be programmed in a variety
of ways. To keep the number of models down to a realistic number the pad has
been characterized in its basic configuration, i.e.:
No Pulldown/Pullup/Bus-Keeper
No Open Drain/Open Source
No Slew-Rate Limitation


AVR32 models
------------
AVR32 parts contain a number of dedicated analog and semi-analog pins for
functions like Xtal oscillator, analog IO, ADC and PLL. As the IBIS modeling
standard is defined primarily for digital buffers, these have been left out
of the models (NC). We refer instead to the application notes for optimal
connection of these signals.
Programmable drivers are characterized at their strongest/fastest drive,
no pullup/pulldown or signal conditioning.


Additional information
----------------------
NB! There has been a change in model name for these devices:

ATtiny26B -> ATtiny261
ATtiny46  -> ATtiny461
ATtiny86  -> ATtiny861

=======================================
Atmel Norway, October 2009, Lars Snith
