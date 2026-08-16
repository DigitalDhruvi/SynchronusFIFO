# UVM Synchronous FIFO Verification

## Overview

This project implements and verifies a **Synchronous FIFO (First-In First-Out)** using **SystemVerilog and UVM**.

The project focuses on developing a structured UVM verification environment for a FIFO and practicing transaction generation, stimulus driving, monitoring, checking, and functional coverage.

---

## DUT — Synchronous FIFO

The FIFO supports:

* Write operation
* Read operation
* Simultaneous read and write
* Full status detection
* Empty status detection
* Data input and output

### Interface Signals

| Signal     | Description           |
| ---------- | --------------------- |
| `clk`      | Clock                 |
| `rst_n`    | Active-low reset      |
| `w_en`     | Write enable          |
| `r_en`     | Read enable           |
| `data_in`  | FIFO input data       |
| `data_out` | FIFO output data      |
| `full`     | FIFO full indication  |
| `empty`    | FIFO empty indication |

---

## UVM Testbench Architecture

```text
tb_top
   |
   +-- FIFO DUT
   |
   +-- fifo_if
   |
   +-- fifo_package
          |
          +-- fifo_environment
                 |
                 +-- fifo_agent
                 |      |
                 |      +-- fifo_sequencer
                 |      +-- fifo_driver
                 |      +-- fifo_monitor
                 |
                 +-- fifo_scoreboard
                 |
                 +-- fifo_subscriber
                        |
                        +-- Functional Coverage
```

The testbench uses a virtual interface to connect the UVM components to the FIFO interface.

---

## UVM Components

The verification environment contains:

* Transaction 
* Sequencer
* Driver
* Monitor
* Agent
* Scoreboard
* Subscriber
* Environment
* Tests

The `fifo_subscriber` is used to collect functional coverage.

---

## Sequence Structure

The project uses a base sequence from which the FIFO-specific sequences are derived.

```text
fifo_base_sequence
        |
        +-- fifo_wr_sequence
        |
        +-- fifo_rd_sequence
        |
        +-- wr_rd_sequence
```

### Sequences

* `fifo_base_sequence.sv`
* `fifo_wr_sequence.sv`
* `fifo_rd_sequence.sv`
* `wr_rd_sequence.sv`

The sequences generate different FIFO operating scenarios.

---

## Tests

The project contains the following tests:

* `write_test`
* `read_test`
* `wr_rd_test`
* `final_test`

The default run executes the final test, while individual tests can be selected from the terminal using plusargs.

---

# Running the Project

All commands below are executed from the `run_file` directory.

## Run the Complete Testbench

```bash
qverilog top.sv
```

## Run Write Test

```bash
qverilog top.sv +write_test
```

## Run Read Test

```bash
qverilog top.sv +read_test
```

## Run Write + Read Test

```bash
qverilog top.sv +wr_rd_test
```

---

# Functional Coverage

Functional coverage is implemented using the `fifo_subscriber`.

The coverage model contains the following coverpoints:

* Write enable
* Read enable
* Data input
* FIFO full
* FIFO empty

### Cross Coverage

The following crosses are implemented:

* Read/write combinations
* Write/full combinations
* Read/empty combinations
* Complete FIFO operational scenarios

An ignore bin is used for the impossible FIFO state where the FIFO is simultaneously full and empty.

---

# Coverage

Coverage was collected using QuestaSim.

## Run Final Test With Coverage

```bash
qverilog -coverage top.sv
```

## Run Write Test With Coverage

```bash
qverilog -coverage top.sv +write_test
```

## Run Read Test With Coverage

```bash
qverilog -coverage top.sv +read_test
```

## Run Write + Read Test With Coverage

```bash
qverilog -coverage top.sv +wr_rd_test
```

---

## Generate Coverage Report

A detailed coverage report can be generated in the terminal using:

```bash
vcover report -details cov_0.ucdb
```

---

## Generate HTML Coverage Report

```bash
vcover report -details -html -output covhtmlreport cov_0.ucdb
```

This generates an HTML coverage report inside the `covhtmlreport` directory.

---

## Open HTML Coverage Report

```bash
firefox covhtmlreport/index.html
```

The HTML report provides coverage summaries, coverpoints, crosses, bins, and coverage details.

---

# Coverage Result

The functional coverage achieved during testing was:

**100.00%**

### Coverpoints

| Coverage Item | Result |
| ------------- | -----: |
| Write Enable  |   100% |
| Read Enable   |   100% |
| Data Input    |   100% |
| FIFO Full     |   100% |
| FIFO Empty    |   100% |

### Cross Coverage

| Cross                      | Result |
| -------------------------- | -----: |
| Read/Write                 |   100% |
| Write/Full                 |   100% |
| Read/Empty                 |   100% |
| Complete Operational Cross |   100% |

The overall covergroup coverage was **100.00%**.

The remaining uncovered scenario in the complete operational cross was the case where the FIFO is **full while both write and read are enabled**.

---

# Project Structure

```text
UVM_TB
└──code/
    ├── fifo_dut.sv
    ├── fifo_interface.sv
    ├── fifo_package.sv
    │
    ├── transaction.sv
    └── fifo_test
    │   ├── fifo_base_sequence.sv
    │   ├── fifo_wr_sequence.sv
    │   ├── fifo_rd_sequence.sv
    │   └──  wr_rd_sequence.sv
    │
    ├── fifo_sequencer.sv
    ├── fifo_driver.sv
    ├── fifo_monitor.sv
    ├── fifo_agent.sv
    ├── fifo_scoreboard.sv
    ├── fifo_subscriber.sv
    ├── fifo_environment.sv
    │
    └── fifo_test
    │   ├── base_test.sv
    │   ├── write_test.sv
    │   ├── read_test.sv
    │   ├── wr_rd_test.sv
    │   ├── final_test.sv
    │
    └── top.sv
└── output/
    ├── coverage_details.txt
    ├── read_test.txt
    ├── write_test.txt
    ├── wr_rd_test.txt
    ├── waveform.jpeg
    └── covhtmlreport/
        ├── index.html
        ├── coverage_details.txt
        └── coverage.jpeg
└── README.md
        
```

---

# Tools Used

* **SystemVerilog**
* **UVM 1.1d**
* **QuestaSim 2024.2**
* **Functional Coverage**
* **WLF Waveform**
* **Firefox** for HTML coverage reports

---

## Author

**Dhruvi Agrawal**
