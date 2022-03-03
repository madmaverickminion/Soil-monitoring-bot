
# Soil Monitoring Bot

This repository contains all the work(till task 5) of Soil Monitoring Bot theme(eYRC-2021-22). In this theme a Soil Monitoring bot was build to be deployed on an arena which is an abstraction of actual agricultural field.
The brain of the bot was powered by an FPGA board that controls its sensors, actuators and pick-place mechanism.
                      
### Final Image of the Arena

![](SM%231153_Task3A/SM%231153_Task3A.jpeg)

### Final image of the robot

<img width="407" alt="image" src="https://user-images.githubusercontent.com/88222914/156010775-a73febb8-10d0-45f8-a8ae-cda05bcacfdd.png">

### Hardware Used 
- De0-Nano board
- 600 rpm N20 motors
- L9110s Motor Driver
- 2S Li-ion battery
- Xbee s2c module
- TCS3200 Color sensor
- Level shifter
- Potentiometer
- Electromagnet
- LEDs 


## Challenges and Learnings 

- Building the Soil Monitoring Bot from scratch
- Pick-place mechanism using electromagnet
- Wired and Wireless communication using XBEE 
- 3 channel ADC controller for fetching 12-bit digital value of analog signal from on-board ADC128S022.
- Interfaced TCS3200 colour sensor with De0 nano FPGA board to detect RGB colours.
- PID control algorithm to control the movement of the bot.
- Motor speed variation using PWM. 
- Circuit Designing 
- Learnt powerfull parallel processing capabilities of FPGA 
- Learnt Verilog Hardware Modelling Language.
- Learnt Path Planning Algorithms.
