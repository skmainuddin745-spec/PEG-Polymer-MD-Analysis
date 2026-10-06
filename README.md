# PEG-Coated Urea  -  Molecular Dynamics Density Analysis

> **VMD analysis script and frame-wise density output from molecular dynamics of urea with polyethylene glycol (PEG-400, PEG-600, PEG-2000), part of a combined simulation-and-experiment study of PEG-coated slow-release urea.**

---

## Scientific Background

Polyethylene glycol coatings slow the release of urea fertiliser. The study this repository belongs to asks how PEG chain length changes the coating: how strongly PEG and urea hydrogen-bond to each other, how that competes with urea-urea interactions, and how the result shows up in measured properties.

The simulation work was held against experiment rather than reported on its own: hydrogen-bond counts and radial distribution functions from the trajectories were compared with FT-IR (with principal component analysis), ¹H NMR, DSC and SEM on the same materials.

## Relation to the manuscript

The study is submitted to *Langmuir* (manuscript ID la-2026-049546, August 2026): Uddin, Whitaker, Mainuddin, Mondal, Olawuyi, Frias, Casco Hidalgo, Mills, Chakma and Halim, *Mechanistic Insights into Urea-PEG Coating: Effect of Polymer Chain Length Revealed by Experiments and Molecular Dynamics Simulations*.

The production simulations reported in the submission were run in **Desmond with the OPLS-AA 2005 force field** and PME electrostatics: a 1:1 model system of 40 urea and 40 PEG molecules, simulated in the gas phase for 500 ns (NVT, 298 K, 1 fs time step). Several force fields were tested before the production runs were settled; those screening runs, the production inputs and the trajectories are **not** included in this repository.

---

## What is in this repository

| File | Description |
|------|-------------|
| `Density.tcl` | VMD Tcl script that computes, frame by frame, the mass density of the whole system and of the PEG and urea components inside a fixed cubic box (9 nm per side, set at the top of the script) |
| `density_framewise.dat` | Example output of the script |
| `2nd_density_framewise.dat`, `500th_density_framewise.dat`, `700th_density_framewise.dat`, `1000_density_framewise.dat` | Output of the script for single frames taken at different points of a trajectory, used as a simple check that the density had stopped drifting |

Each `.dat` file has the columns `Frame`, `Volume (Å³)`, `System density (g/cm³)`, `PEG density (g/cm³)` and `Urea density (g/cm³)`.

---

## Usage

```tcl
# In the VMD Tk console, with the structure and (optionally) the trajectory loaded:
mol new output.gro type gro
mol addfile traj.xtc type xtc waitfor all
source Density.tcl
```

Set `x_nm`, `y_nm` and `z_nm` at the top of `Density.tcl` to the box dimensions of your own system before running it.

---

## Tools

- **VMD**  -  trajectory handling and the Tcl analysis script
- **Desmond / OPLS-AA 2005**  -  production simulations reported in the manuscript (inputs not included here)

---

*Molecular Dynamics · Polymer Coatings · VMD · PEG · Urea*
