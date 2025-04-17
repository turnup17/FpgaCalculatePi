# FPGA-Based Pi Calculator using Machin's Formula

This project implements a Pi (π) calculator on an FPGA using **SystemVerilog**, based on **Machin's formula** and supporting **multiple-precision arithmetic**.

## 📐 Overview

- Pi is calculated using **Machin's formula**:
  
  \[
  \frac{\pi}{4} = 4 \cdot \arctan\left(\frac{1}{5}\right) - \arctan\left(\frac{1}{239}\right)
  \]

- The implementation is written entirely in **SystemVerilog**.
- The calculator is capable of computing **up to 50 digits of Pi**.

## 🧮 Multiple-Precision Arithmetic

To support 50 digits, the system uses multiple-precision arithmetic with the following format:

- Each **16-bit block** represents a number in the range **0 to 9999**.
- A single number is represented using **16 such blocks**, i.e., 16 × 4 decimal digits = **64 decimal digits** max.
- Internal operations (addition, subtraction, multiplication, division) are performed on these 16-bit units.

## 🔧 Features

- Written in pure SystemVerilog for FPGA implementation
- Accurate Pi calculation up to 50 decimal places
- Modularized design for multiple-precision math operations

## 🗂️ Directory Structure

