# Elevator System Verilog Project
## Overview
This project draws on Verilog to implement a simple elevator system consisting of the elevator module to fulfill the floor request, manage door control, and change the current state based on the door state. It includes:
- **Elevator Module**: The module processes floor requests, organizes the state transitions, and operates the door.
- **Testbench**: This tool creates a facsimile of various scenarios in order to check the operation of the elevator module.
**Note**: This code is a sample, not a complete industrial application. Its performance and security might need to be improved or refined according to the specific real-world usage of the elevator.
## Features
- **Floor Request Handling**: Elevator processes the requests and moves the lift to different floors as per the request command.
- **State Management**: In fact, the functionality provides three states: idle, moving, and stop, getting inputs, and output and do the proper necessary functions.
- **Door Control**: By using 2 sensors, one E.O switch, and a door motor, an effective elevator door control is achieved that involves the opening of the elevator door when the elevator stops and the closing of the door when the elevator moves.
- **Simulation Testbench**: Provides a range of test cases that are used for the validation of machine functionality by using order combinations of the elevator module and test vectors.
## Modules
  ### Elevator
  - **Inputs**:
    - `clk`: Serves as a clock signal
    - `reset`: A signal used to reset the system
    - `r_f`: Floor request (5-bit input for floor requests)
  - **Outputs**:
    - `t_f`: Targeted floor (5-bit output)
  - `state_out`: Current state (3-bit output)
   - `door`: Door control signal (1 for open, 0 for closed)
    ### Testbench (tb_elevator)
  - **Clock Generation**: It produces a clock period of 10ns for the simulation.
  - **Stimulus Generation**: It is running a set of different tests to check the system functionality, which is the expected behavior.
  - **Output Monitoring**: Visualization of the actual state, floor, and door status during the simulation.
## Simulation
To launch the `elevator_tb` testbench for the simulation, a user operates the aforementioned strokes.
- Single floor requests
- Multiple floor requests
- Continuous requests, while movement
