# Carry Look-Ahead Adder

This folder contains Verilog/SystemVerilog implementations of a **Carry Look-Ahead Adder (CLA)** and a **CLA-based Adder/Subtractor**.

A Carry Look-Ahead Adder improves speed by calculating carry signals directly using generate and propagate logic instead of waiting for carry to ripple through each bit.

---

## Repository Structure

```text
.
|-- CLA_16bit_heir.v
|-- CLA_4bit_AdderSub.v
|-- CarryLookAheadAdder_parameteried.v
|-- images
|   |-- CLA 16 bit heir.png
|   |-- CLA 16 bit heir_submodule.png
|   |-- CLA adder_sub.png
|   |-- CLA adder_sub_graph.png
|   `-- carry look ahead parameterised.png
|-- tb.sv
|-- tb_16bit.sv
`-- tb_4bit_addersub.sv
```

---

## Core Concept

Carry Look-Ahead logic uses two main signals:

```verilog
G = A & B;   // Generate
P = A ^ B;   // Propagate
```

The next carry is calculated as:

```verilog
Cnext = G | (P & Cin);
```

This makes CLA faster than a Ripple Carry Adder because carry values are computed using direct logic equations.

---

## Method 1: Parameterized Carry Look-Ahead Adder

### File

```text
CarryLookAheadAdder_parameteried.v
```

This implementation uses a parameterized width:

```verilog
module CarryLookAheadAdder #(parameter WIDTH = 4)(...);
```

It can be reused for different sizes such as:

```text
4-bit CLA
8-bit CLA
16-bit CLA
```

### Simulation

![Parameterized CLA Simulation](images/carry%20look%20ahead%20parameterised.png)

---

## Method 2: Hierarchical 16-bit CLA

### File

```text
CLA_16bit_heir.v
```

This method builds a 16-bit CLA using four 4-bit CLA blocks.

```text
CLA_16bit
 ├── CLA4_bit for bits [3:0]
 ├── CLA4_bit for bits [7:4]
 ├── CLA4_bit for bits [11:8]
 └── CLA4_bit for bits [15:12]
```

This is closer to real digital design practice because large adders are usually built using smaller reusable blocks.

### Simulation

![16-bit CLA Simulation](images/CLA%2016%20bit%20heir.png)

### Submodule View

![16-bit CLA Submodule](images/CLA%2016%20bit%20heir_submodule.png)

---

## Method 3: CLA Adder/Subtractor

### File

```text
CLA_4bit_AdderSub.v
```

This implementation extends CLA logic to support both addition and subtraction.

| CTRL | Operation |
|---|---|
| 0 | Addition |
| 1 | Subtraction |

For subtraction, the design uses 2's complement logic:

```text
A - B = A + (~B) + 1
```

So `B` is conditionally inverted using `CTRL`, and `CTRL` is also used as the initial carry input.

```verilog
Bctrl = B ^ {WIDTH{CTRL}};
Cin   = CTRL;
```

### Simulation

![CLA Adder/Subtractor Simulation](images/CLA%20adder_sub.png)

### Waveform

![CLA Adder/Subtractor Waveform](images/CLA%20adder_sub_graph.png)

---

## Example Calculation

For 16-bit addition:

```text
A = AAAA = 1010 1010 1010 1010
B = 5555 = 0101 0101 0101 0101
Cin = 1
```

Binary addition:

```text
  1010 1010 1010 1010
+ 0101 0101 0101 0101
+ 0000 0000 0000 0001
-----------------------
1 0000 0000 0000 0000
```

Result:

```text
S    = 0000
Cout = 1
```

Decimal verification:

```text
43690 + 21845 + 1 = 65536
```

---

## Testbenches

| Testbench | Purpose |
|---|---|
| `tb.sv` | Tests parameterized CLA |
| `tb_16bit.sv` | Tests hierarchical 16-bit CLA |
| `tb_4bit_addersub.sv` | Tests CLA adder/subtractor |

---

## Key Learning Points

- CLA is faster than Ripple Carry Adder because carry is calculated directly.
- Generate signal tells when a bit position creates a carry.
- Propagate signal tells when a bit position passes a carry.
- Parameterized RTL makes the design reusable.
- Hierarchical design allows larger circuits to be built from smaller modules.
- CLA logic can also be extended to perform subtraction using 2's complement.

---

## Future Extensions

- 8-bit and 32-bit CLA
- signed overflow detection
- comparison with Ripple Carry Adder delay
- CLA-based ALU
- synthesis and timing analysis
- physical design exploration
