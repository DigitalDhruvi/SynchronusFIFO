# SynchronusFIFO
The goal is to design and implement a synchronous FIFO buffer that efficiently manages data transfer between different parts of a system, ensuring smooth data flow and avoiding overflow or underflow conditions.

A FIFO (First-In-First-Out) is a type of data buffer that manages data flow between different parts of a
system, ensuring that data is read in the order it was written. It is used to handle data rate mismatches and
synchronize data transfer between different clock domains. In this project, the FIFO is implemented using
Verilog, with three different methods to handle the conditions for full and empty states.

The synchronous FIFO operates by writing data into a buffer and reading it out in the same order. The key
components of the FIFO are the read pointer (r_ptr), write pointer (w_ptr), and a buffer array (fifo) to store
the data. The pointers are used to manage the positions for writing and reading data.
When two modules operate at the same frequency but have a phase difference in their clock signals, direct
data transfer can lead to timing issues. These issues can cause data corruption or loss. A synchronous FIFO
effectively manages these phase differences, ensuring reliable data transfer between the modules.

Method 1: Uses pointer comparison with an intentional empty slot.
Method 2: Utilizes an extra bit in pointers to differentiate full/empty based on MSB.
Method 3: Employs a counter to track the number of items.
