# Synchronous FIFO Verification using SystemVerilog

## Overview

This project implements a synchronous FIFO (First-In First-Out) in SystemVerilog and verifies its functionality using a custom SystemVerilog testbench. The verification environment consists of a Generator, Driver, Monitor, Environment, and Scoreboard to validate the FIFO read and write operations.

## Features

- Synchronous FIFO RTL
- Modular SystemVerilog verification environment
- Transaction-based stimulus generation
- FIFO read and write operation verification
- Full and Empty status checking
- Automatic output checking using a scoreboard
- PASS/FAIL reporting for transactions

## Project Structure

```
SV_TB/
├── code/
│   ├── interface.sv
│   ├── transaction.sv
│   ├── generator.sv
│   ├── driver.sv
│   ├── monitor.sv
│   ├── scoreboard.sv
│   ├── environment.sv
│   └── top.sv
│
├── output/
│   ├── fifo_waveform.jpeg
│   └── output.txt
│
└── README.md
```

## Verification Flow

```
Generator → Driver → DUT → Monitor → Scoreboard
```

## Tools Used

- SystemVerilog
- QuestaSim
- VS Code
