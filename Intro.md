# Introduction #

The Hydra project is an effort to create an Arduino-compatible controller for reef aquaria.

# Guidelines #

Hardware development strives to follow these guidelines:

  * Incorporate functionality desirable for controlling and monitoring a typical home reef aquarium
  * Allow for expanding the hardware and software to incorporate additional functionality
  * Keep the hardware "simple" enough that a novice electronics hobbyist would be comfortable with assembly (i.e. no small-pitch high pin count SMT parts).
  * Maintain shield compatibility with official Arduinos, i.e. the Duemilanove.
  * Preserve GPIO pins - use I2C or other busses where possible

# Included Functionality #

The current design of the Hydra includes hardware to support the following functions:

  * Monitoring pH through a stable amplifier circuit
  * Driving an LCD via I2C
  * Absolute timekeeping via an onboard RTC
  * Additional I/O, memory, and processing power via a second AVR acting as an I2C slave (Hence the "Hydra" name, implying multiple heads)
  * Ethernet connectivity, allowing for remote control and/or notification of alarm conditions

Simple I/O functionality - sensing float switches, reading temperatures, etc. - will be implemented via GPIO pins and/or 1-Wire or I2C slave devices separate from the main PCB. In addition, a relay module will be developed separately from the main PCB to control 120v AC devices.

# Project Status #

The current status of the project is very early development. We have prototyped much of the functionality via off-the-shelf Arduinos, breadboards, etc. The first round of PCBs have been ordered and "real" testing will begin soon. If you are interested in helping, please contact the project owner.

The svn repository is being used to store development versions of the hardware and software for this project. When a stable release has been developed, it will be posted on the downloads page.

Currently, the following hardware components exist. To see development versions of the files, click on the "Source" tab above, click "Browse" in the toolbar at the top, then expand "trunk" and "hardware" in the tree on the left.

  * hydra: The design files for the main hydra PCB
  * ELN\_shield: The design files for an Arduino-compatible (and hence hydra-compatible) shield allowing control for ELN-60-48-P LED drivers, or any other LED driver that can accept a 10v PWM signal. The shield has it's own 10v regulator onboard, which means the raw input voltage to the Arduino must be above about 10.5v. The ELN shield design is complete and tested. Please feel free to use it if you need a way to control ELN HP LED drivers with an Arduino. Although designed for the P type of ELN, it has been reported successful for the D type, as well.
  * DC\_UPS: The design files for a small, NiCd battery-based uninterruptible power supply. The goal is to provide a hydra controller with several hours of battery power if it's main power source (typically a wall wart) loses power. Hence, the hydra will be able to sound alarms, monitor conditions, take corrective actions, etc. in the event of a mains power failure.