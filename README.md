# FPGA-Based Pi Calculator Using Machin's Formula

This project implements a π (Pi) calculator on an FPGA using **SystemVerilog**, based on **Machin's formula** and **multiple-precision arithmetic**.

## 📐 Overview

- Calculates π using **Machin’s formula**:

  \[
  \pi = 16 \cdot \arctan\left(\frac{1}{5}\right) - 4 \cdot \arctan\left(\frac{1}{239}\right)
  \]

- Written entirely in **SystemVerilog**.
- Capable of computing **up to 50 decimal digits** of π.

## 🧮 Multiple-Precision Arithmetic

- Uses **16-bit units**, each representing a number from **0 to 9999**.
- A single number is made up of **16 such units**, i.e., **64 decimal digits** total.
- Basic operations (addition, subtraction, multiplication, division) are implemented for these units.

## 🧪 How It Works

- Each mathematical module (`add_long.sv`, `sub_long.sv`, etc.) handles multi-digit math operations.
- `machin.sv` computes arctangent terms using a series expansion.
- `machintop.sv` assembles everything to compute π based on Machin’s formula.
- `test_fpga_top.sv` and `test_machin.sv` are testbenches for simulation.

## 🛠 Usage

To simulate or synthesize:
- Use tools like **ModelSim**, **Vivado**, or **Quartus**.
- Set `machintop.sv` as the top-level design.
- Run simulations using the provided testbenches.
