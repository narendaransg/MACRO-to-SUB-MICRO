# N-Bit Ripple Carry Adder/Subtractor

This folder contains RTL implementations of an **N-bit Ripple Carry Adder/Subtractor (RCA/RCS)** using Verilog/SystemVerilog.

The design performs both addition and subtraction using a single control signal.

---

## Operation

| CTRL | Operation | Expression |
|---|---|---|
| 0 | Addition | `A + B` |
| 1 | Subtraction | `A + (~B) + 1` |

For subtraction, the design uses **2's complement arithmetic**.

```text
A - B = A + (~B) + 1
```

Here, `CTRL` controls whether `B` is used directly or inverted.

---

## Repository Structure

```text
.
|-- N_bit_RCAS.v
|-- N_bit_RCAS_eff.v
|-- N_bit_RCAS_opt.v
|-- full_adder.v
|-- images
|   |-- 4 bit RCA_S simulation.png
|   |-- 4 bit RCA_S simulation_eff.png
|   |-- 4 bit RCA_S simulation_graph.png
|   |-- 4 bit RCA_S simulation_graph_eff.png
|   |-- 4 bit RCA_S simulation_graph_opt.png
|   |-- 4 bit RCA_S simulation_opt.png
|   |-- 4 bit RCA_S simulation_opt_2.png
|   `-- 4 bit RCA_S.png
|-- tb.sv
`-- tb_opt.sv
```

---

## Design Idea

The same ripple carry adder can be used for both addition and subtraction.

For every bit of `B`:

```text
B_modified = B ^ CTRL
```

So:

| CTRL | B Modified | Meaning |
|---|---|---|
| 0 | `B` | Addition |
| 1 | `~B` | Subtraction |

The `CTRL` signal is also used as the initial carry input.

```text
Cin = CTRL
```

Therefore:

```text
CTRL = 0  →  A + B + 0
CTRL = 1  →  A + ~B + 1
```

---

## Block Diagram

![4-bit RCA/RCS](images/4%20bit%20RCA_S.png)

---

## Method 1: Basic Ripple Carry Adder/Subtractor

### File

```text
N_bit_RCAS.v
```

This implementation uses:
- full adder stages
- XOR logic for modifying `B`
- ripple carry propagation
- generate block for repeated full adder instances

---

## Carry Flow

```text
CTRL    → initial carry input
cout[0] → carry from bit 0
cout[1] → carry from bit 1
cout[2] → carry from bit 2
cout[3] → final carry from bit 3
```

For subtraction:

```text
Cout = 1 → No borrow
Cout = 0 → Borrow occurred
```

---

## Method 2: Optimized Scalable Implementation

### File

```text
N_bit_RCAS_opt.v
```

This version uses a dedicated carry vector.

```text
carry[0] → input carry to bit 0
carry[1] → carry from bit 0 to bit 1
carry[2] → carry from bit 1 to bit 2
carry[3] → carry from bit 2 to bit 3
carry[4] → final carry out
```

This method is cleaner because the carry chain is represented explicitly.

---

## Method 3: Arithmetic Expression Based Implementation

### File

```text
N_bit_RCAS_eff.v
```

This is the compact RTL implementation.

```verilog
assign {cout, sum} = a + (b ^ {WIDTH{ctrl}}) + ctrl;
```

This single expression performs both addition and subtraction.

| CTRL | Expression |
|---|---|
| 0 | `a + b` |
| 1 | `a + (~b) + 1` |

This is concise and synthesis-friendly.

---

## Important RTL Techniques Used

| Technique | Used | Purpose |
|---|---|---|
| Bit masking | Yes | Used for `B ^ CTRL` logic |
| Vectors | Yes | Used instead of separate wires |
| Generate blocks | Yes | Used for scalable WIDTH-based design |
| Full adder chaining | Yes | Used for ripple carry propagation |
| Arithmetic inference | Yes | Used in efficient implementation |
| Dynamic programming / graphs / trees | No | Not required for this basic design |

---

## Sample Simulation Results

```text
CTRL=0: A = 0001, B = 0000 --> S = 0001, Cout = 0
CTRL=0: A = 0010, B = 0100 --> S = 0110, Cout = 0
CTRL=0: A = 1011, B = 0110 --> S = 0001, Cout = 1

CTRL=1: A = 0001, B = 0000 --> S = 0001, Cout = 1
CTRL=1: A = 0010, B = 0100 --> S = 1110, Cout = 0
CTRL=1: A = 1011, B = 0110 --> S = 0101, Cout = 1
CTRL=1: A = 0101, B = 0011 --> S = 0010, Cout = 1
```

---

## Simulation Outputs

### Basic RCA/RCS Simulation

![Basic Simulation](images/4%20bit%20RCA_S%20simulation.png)

### Basic RCA/RCS Waveform

![Basic Waveform](images/4%20bit%20RCA_S%20simulation_graph.png)

### Efficient Arithmetic Expression Simulation

![Efficient Simulation](images/4%20bit%20RCA_S%20simulation_eff.png)

### Efficient Arithmetic Expression Waveform

![Efficient Waveform](images/4%20bit%20RCA_S%20simulation_graph_eff.png)

### Optimized Carry Vector Simulation

![Optimized Simulation](images/4%20bit%20RCA_S%20simulation_opt.png)

### Optimized Carry Vector Simulation 2

![Optimized Simulation 2](images/4%20bit%20RCA_S%20simulation_opt_2.png)

### Optimized Carry Vector Waveform

![Optimized Waveform](images/4%20bit%20RCA_S%20simulation_graph_opt.png)

---

## Testbench

### Files

```text
tb.sv
tb_opt.sv
```

The testbenches verify:
- addition operation
- subtraction operation
- carry propagation
- borrow behavior
- multiple 4-bit input combinations

---

## Key Learning Points

- A subtractor can be built using an adder and 2's complement logic.
- `CTRL` selects between addition and subtraction.
- XOR masking is useful for conditional inversion.
- Generate blocks make the design scalable.
- Carry vectors make ripple carry logic cleaner.
- Arithmetic-expression RTL is compact and synthesis-friendly.

---

## Future Extensions

- signed addition/subtraction
- overflow detection
- carry look-ahead adder/subtractor
- ALU integration
- synthesis analysis
- timing comparison between implementations
