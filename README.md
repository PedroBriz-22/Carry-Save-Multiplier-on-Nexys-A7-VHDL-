
---

## 🧪 Simulation

A full behavioral testbench was used to verify:

- Correct partial-product generation  
- Carry-save reduction correctness  
- Final product output  
- No timing or functional mismatches  

Simulation confirmed all 8×8 test vectors passed successfully.

---

## 🖥️ FPGA Hardware Demo

Operands `a` and `b` were entered using the Nexys A7 onboard switches:

- `SW0–SW7` → operand **a**
- `SW8–SW15` → operand **b**

The resulting **16-bit product** is displayed on:

- LED0–LED7 → lower 8 bits  
- LED8–LED15 → upper 8 bits  

If the LEDs match the expected binary product, the case passes.

---

## 🔢 Hardware Test Cases

The following test cases were demonstrated on hardware:

### **✔️ Case 1**  
**a = 0000_0110 (6)**  
**b = 0001_1011 (27)**  
Product = **0000_1010_0110 (162)**  
All corresponding LEDs illuminated to reflect the binary result.

---

### **✔️ Case 2**  
**a = 1111_1011 (251)**  
**b = 0000_0000 (0)**  
Product = **0000_0000_0000_0000 (0)**  
All LEDs remained OFF, confirming correct zero multiplication.

---

### **✔️ Case 3**  
**a = 1110_0000 (224)**  
**b = 0001_1000 (24)**  
Product = **0011_0110_0000_0000 (5376)**  
LED pattern matched the expected binary result.

---

### **✔️ Case 4**  
**a = 1111_1111 (255)**  
**b = 1111_1111 (255)**  
Product = **1111_1110_0000_0001 (65025)**  
All LEDs matched the full 16-bit output.

---

## ⚙️ Implementation & Timing

Vivado implementation confirmed:

- **0 failing timing endpoints**
- Positive setup/hold slack
- Sufficient timing margin for 100 MHz operation
- Moderate LUT and register usage (well below device limits)

---

## 📈 Resource Utilization (From Vivado Report)

| Resource Type   | Used | Available | Utilization |
|-----------------|------|-----------|-------------|
| Slice LUTs      | 91   | 63,400    | <1%         |
| Slice Registers | 32   | 126,800   | <1%         |
| Bonded IOBs     | 33   | 210       | ~15%        |
| BUFGCTRL        | 1    | 32        | <5%         |

This demonstrates the multiplier is highly resource-efficient and easily scalable.

---

## 🧰 Tools Used
- **Vivado 2025.1**
- **VHDL**
- **Nexys A7 FPGA (Artix-7 100T)**
- Windows 11 development environment

---

## 🎯 Learning Outcomes
This project demonstrates capability in:

- Digital logic design
- RTL hardware architecture
- Structural VHDL coding
- Simulation & waveform debugging
- FPGA synthesis, implementation, and timing closure
- Hardware validation & test procedure design

---

## 👤 Author
**Pedro Brizuela Kury**  
Electrical Engineering — Florida Atlantic University  
Aspiring FPGA / Hardware Design Engineer  

---

## 📎 Future Improvements
- Add 16×16 or 32×32 scalable multiplier version  
- Add pipeline registers for higher clock speeds  
- Implement Booth encoding to reduce partial products  
- Integrate into a simple ALU or processor datapath  

---

If you found this project helpful, feel free to ⭐ the repo!


