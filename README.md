NAND2Tetris / CPU Project

This repository documents my progression through the Nand2Tetris course and related hardware extensions.
The goal of this project is to better understand how a computer is built from the ground up, starting with simple logic gates and gradually moving toward arithmetic, memory, a CPU, machine language, and a complete computer system.

Projects Included

Project 1 — Boolean Logic

Built fundamental logic gates using NAND as the base building block.
Included chips:
- NOT
- AND
- OR
- XOR
- MUX
- DMUX
- 16-bit logic gates
- Multi-way multiplexers
- Multi-way demultiplexers

Project 2 — Boolean Arithmetic

Built the arithmetic hardware used by the Hack computer.
Included chips:
- Half Adder
- Full Adder
- Add16
- Inc16
- ALU
This project helped connect basic Boolean logic to arithmetic operations and CPU datapaths.

Project 3 — Memory

Built sequential logic and hierarchical memory systems.
Included chips:
- Bit
- Register
- RAM8
- RAM64
- RAM512
- RAM4K
- RAM16K
- Program Counter
This project introduced clocked logic, state, registers, and memory addressing.

Project 4 — Machine Language

Wrote programs directly in Hack assembly language.
Projects include:
- Multiplication program
- Screen fill / keyboard input program
This section helped connect software instructions to the hardware created in earlier projects.

Project 5 — Computer Architecture

Built the major components of the Hack computer.
Included:
- Memory
- CPU
- Complete Computer
This project connected the ALU, registers, program counter, instruction memory, RAM, screen, and keyboard into a working computer architecture.

Project 6 — Assembler

Built an assembler that translates Hack assembly language into 16-bit machine code.
The assembler handles:
- A-instructions
- C-instructions
- Labels
- Variables
- Predefined symbols
- Symbol tables
- Binary instruction generation
SystemVerilog Extension
In addition to the standard Nand2Tetris HDL implementation, I recreated several parts of the architecture in SystemVerilog to gain more experience with industry-standard hardware description languages.
This included:
- Basic logic gates
- 16-bit gates
- Adders
- ALU
- Testbenches
- Simulation and verification using Icarus Verilog
The goal of this extension was to connect the educational Nand2Tetris HDL environment with modern digital design workflows.
Physical Hardware Extension
I also began translating the digital designs into physical hardware.
This included:
- Building transistor-based logic gates on breadboards
- Designing a 4-bit computer trainer
- Creating a KiCad schematic for the trainer
- Using registers, logic gates, multiplexers, an adder, control signals, and LED outputs
The trainer is intended to demonstrate the flow:
Input → Registers → ALU → Multiplexer → Output Register → LEDs

Tools Used
- Nand2Tetris Hardware Simulator
- CPU Emulator
- Hack Assembler tools
- SystemVerilog
- Icarus Verilog
- VS Code
- KiCad
- Breadboard prototyping
- Git and GitHub
Repository Structure
Example organization:
CPU-Project/

├── Project1/

├── Project2/

├── Project3/

├── Project4/

├── Project5/

├── Project6/

├── SystemVerilog_Extension/

├── KiCad/

├── Certification/

└── README.md

Some project folders may also be included as compressed .zip files for submission/archive purposes.

Key Learning Outcomes

Through this project, I gained experience with:
- Boolean logic
- Combinational circuits
- Sequential circuits
- Registers and memory
- ALU design
- Multiplexers
- Program counters
- Machine language
- Assembly
- CPU architecture
- Hardware description languages
- Digital simulation
- Hardware verification
- KiCad schematic design
- Breadboard implementation
