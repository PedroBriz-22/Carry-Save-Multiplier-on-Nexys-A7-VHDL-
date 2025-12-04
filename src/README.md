# Carry-Save Multiplier on Nexys A7 (VHDL)

This project implements an 8×8 carry-save multiplier in VHDL.  
The design was verified through simulation in Vivado and successfully deployed on a Digilent Nexys A7 FPGA.  
Hardware testing was performed using switches to input operands and LEDs to display the resulting product bits.

---

## 📌 Project Overview
A carry-save multiplier is a fast hardware multiplier architecture that reduces delay by avoiding long ripple-carry propagation during partial-product addition.  
Instead, partial sums and carries are accumulated in parallel using full adders, and a final carry-propagate stage completes the multiplication.

This project demonstrates:

- RTL design in **VHDL**
- Hierarchical structural design (full adders, carry-save stages)
- Simulation in **Vivado 2025.1**
- FPGA implementation on a **Nexys A7 (Artix-7 100T)**
- Hardware verification using switches and LEDs
- Timing, utilization, and area reporting

---

## 🧱 Repository Structure


