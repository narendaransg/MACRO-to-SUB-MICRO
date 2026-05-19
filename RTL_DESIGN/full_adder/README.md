# FULL ADDER

Implementation and exploration of a 1-bit Full Adder using different RTL abstraction methodologies in Verilog/SystemVerilog.

This folder explores:
- higher abstraction RTL modeling
- arithmetic inference
- hierarchical hardware design
- Full Adder implementation using Half Adders
- carry equation optimization

---

# Repository Structure

```text
.
|-- fulladder_higherabs.v
|-- fulladder_usingha.v
|-- images
|   |-- fa using ha diagram.png
|   |-- fa using ha.png
|   `-- full adder higher abstraction.png
`-- tb.sv
```

---

# Overview

A Full Adder performs binary addition of:

- two input bits
- one carry input

and produces:

- sum output
- carry output

---

# Truth Table

| A | B | Cin | Sum | Cout |
|---|---|---|---|---|
| 0 | 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 1 | 0 |
| 0 | 1 | 0 | 1 | 0 |
| 0 | 1 | 1 | 0 | 1 |
| 1 | 0 | 0 | 1 | 0 |
| 1 | 0 | 1 | 0 | 1 |
| 1 | 1 | 0 | 0 | 1 |
| 1 | 1 | 1 | 1 | 1 |

---

# Boolean Equations

## Sum

```text
Sum = A ⊕ B ⊕ Cin
```

---

## Carry

Canonical SOP form:

```text
Cout = AB + ACin + BCin
```

Optimized carry form:

```text
Cout = AB + Cin(A ⊕ B)
```

---

# Carry K-Map Simplification

```text
            BC
         00 01 11 10
       +----------------
A = 0  |  0   0   1   0
A = 1  |  0   1   1   1
```

From K-Map grouping:

```text
Cout = AB + ACin + BCin
```

Alternative optimized grouping:

```text
Cout = AB + Cin(A ⊕ B)
```

---

# 1. Higher Abstraction Dataflow Model

## File

```text
fulladder_higherabs.v
```

---

## Concept

This implementation uses arithmetic inference:

```verilog
in1 + in2 + cin
```

with:

```verilog
assign
```

Instead of explicitly describing:
- XOR gates
- AND gates
- OR gates

the synthesizer automatically infers the required hardware.

---

## Characteristics

- higher abstraction RTL
- compact implementation
- arithmetic inference
- synthesis-friendly
- commonly used in RTL design

---

## Example

```verilog
assign {cout, sum} = in1 + in2 + cin;
```

---

## Simulation

![Higher Abstraction Full Adder](images/full%20adder%20higher%20abstraction.png)

---

# Behavioral Modeling Concept

Behavioral modeling describes circuit functionality using procedural constructs.

Common constructs:

```text
always
always_comb
initial
if
case
for
while
```

Example:

```systemverilog
module full_adder(
    input logic in1,
    input logic in2,
    input logic cin,
    output logic sum,
    output logic cout
);

always_comb begin
    {cout, sum} = in1 + in2 + cin;
end

endmodule
```

---

# 2. Full Adder Using Half Adders

## File

```text
fulladder_usingha.v
```

---

## Concept

A Full Adder can be constructed hierarchically using:

- two Half Adders
- one OR gate

---

## Architecture

```text
First Half Adder:
A + B
    ↓
Partial Sum + Carry

Second Half Adder:
Partial Sum + Cin
    ↓
Final Sum + Carry

Final Carry:
OR of both carry outputs
```

---

# Structural Diagram

![Full Adder Using Half Adders](images/fa%20using%20ha%20diagram.png)

---

# Simulation

![Full Adder Using Half Adders Simulation](images/fa%20using%20ha.png)

---

# Testbench

## File

```text
tb.sv
```

The testbench verifies:
- all possible input combinations
- carry propagation
- sum correctness

Input sequence:

```text
000
001
010
011
100
101
110
111
```

---

# Learning Objectives

This project introduces:

- Full Adder architecture
- arithmetic inference
- higher abstraction RTL
- hierarchical design
- Half Adder reuse
- carry logic optimization
- combinational circuit verification
- SystemVerilog testbench basics

---

# Key Concepts Covered

- Dataflow Modeling
- Behavioral Modeling
- Structural Design
- Arithmetic RTL Inference
- Hierarchical Module Design
- Carry Simplification
- K-Map Optimization
- RTL Verification

---

# Status

## Completed

- higher abstraction Full Adder
- Full Adder using Half Adders
- simulation verification
- carry equation simplification

## Future Extensions

- gate-level Full Adder
- switch-level Full Adder
- ripple carry adder
- carry look-ahead adder
- ALU integration
- synthesis analysis
