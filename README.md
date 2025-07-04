# Custom-Verilog-Processor

A custom-built 16-bit processor designed using Verilog HDL. The processor supports arithmetic, logical, memory, and control flow operations with a RISC-style instruction set. This project demonstrates core concepts of CPU design including FSM-based control, instruction decoding, ALU design, memory interfacing, and condition flags.

---

## 🧠 Features

- 32 general-purpose registers (`GPR[0]` to `GPR[31]`)
- 16-entry instruction memory (`inst_mem`)
- 16-entry data memory (`data_mem`)
- ALU operations:
  - Arithmetic: `ADD`, `SUB`, `MUL`
  - Logical: `AND`, `OR`, `XOR`, `XNOR`, `NAND`, `NOR`, `NOT`
- Data transfer:
  - Move between GPRs, SGPR, and memory
  - Load/store from external `din` and to `dout`
- Control flow:
  - Unconditional and conditional jumps (`JUMP`, `JCARRY`, `JZERO`, etc.)
- FSM-based control unit with 6 states
- Condition flags: `Zero`, `Sign`, `Carry`, `Overflow`
- Support for immediate mode or register mode operations

---

## 📁 File Structure

.
├── top.v # Main Verilog module for the processor
├── inst_data.mem # Instruction memory file (binary format)
├── Makefile # (Optional) Compilation or simulation setup
└── README.md # Project documentation

---

## 🧾 Instruction Format

Each instruction is 32 bits:

[31:27] opcode | [26:22] rdst | [21:17] rsrc1 | [16] imm_mode | [15:11] rsrc2 | [15:0] imm_data


Supports both immediate and register mode addressing based on `imm_mode`.

---

## 🚀 How It Works

1. FSM cycles through: `idle → fetch → decode/execute → delay → next → halt check`
2. Instructions are fetched from `inst_mem` sequentially using a program counter.
3. Each instruction is decoded, executed, and relevant flags (`carry`, `zero`, etc.) are updated.
4. Based on flag and instruction, PC is either incremented or updated (jump).
5. Output (if any) is written to `dout`, data is read from `din`.

---

## 🛠️ Usage

### 📦 Simulation

You can simulate the design using tools like:
- ModelSim / Questa
- Vivado (Xilinx)
- Icarus Verilog + GTKWave

### 💬 Load Instructions

Write your instruction set in binary into the `inst_data.mem` file. Example format:

00001xxxxxxxxxxxxxxxxxxxxxxxxxxxxx
00010xxxxxxxxxxxxxxxxxxxxxxxxxxxxx
...


Each line represents a 32-bit instruction.

---

## 🧑‍💻 Author

**Aditya Padamwar**

If you use or modify this processor, feel free to fork the repo and contribute!

---

## 📜 License

This project is released under the MIT License. Feel free to use it for educational or commercial purposes with attribution.
