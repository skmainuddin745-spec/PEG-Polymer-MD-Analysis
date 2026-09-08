# PEG Polymer Molecular Dynamics — Structural Analysis Suite

> **Comparative atomistic MD study of polyethylene glycol (PEG-400, PEG-600, PEG-2000) in water and gas-phase environments with urea co-solute, analysed via GROMACS and VMD.**

---

## Scientific Background

**Polyethylene glycol (PEG)** is the most widely used polymer in drug formulation, nanoparticle surface-coating, and biomaterials. Its aqueous behaviour (hydration shell structure, chain conformation, radius of gyration) directly governs in vivo circulation time and protein-corona formation. This study systematically compares three molecular weights — PEG-400, PEG-600, PEG-2000 — under two solvation environments (water, gas-phase) and with urea co-solute.

---

## Systems Studied

| System | MW (Da) | Solvent | Key Question |
|--------|---------|---------|-------------|
| PEG400 + Urea + H₂O | 400 | SPC/E water | Compact vs extended chain? |
| PEG600 + Urea + H₂O | 600 | SPC/E water | MW effect on Rg? |
| PEG2000 + Urea + H₂O | 2000 | SPC/E water | Coil → helix transition? |
| PEG400 + Urea (gas) | 400 | Vacuum | Intrinsic chain conformations |
| PEG600 + Urea (gas) | 600 | Vacuum | Gas-phase structure |
| PEG2000 + Urea (gas) | 2000 | Vacuum | Chain collapse in vacuum |

---

## Analysis Methods

### Radius of Gyration (Rg)
Tracks chain compactness over time. A decreasing Rg indicates chain collapse; an increasing Rg indicates swelling.

```tcl
# VMD Density.tcl snippet — framewise density analysis
set sel [atomselect top "resname PEG"]
set nframes [molinfo top get numframes]
for {set i 0} {$i < $nframes} {incr i} {
    $sel frame $i
    $sel update
    # ... density calculation per frame
}
```

### Density Profiles
Frame-wise density computed via `Density.tcl` (VMD Tk console) and saved to `density_framewise.dat`.

### Convergence Analysis
Monitoring Rg and density at frames 2, 500, 700, 1000 to assess equilibration.

---

## Data Files in This Repository

| File | Description |
|------|-------------|
| `Density.tcl` | VMD Tcl script for frame-wise mass density calculation |
| `density_framewise.dat` | Output: density vs. frame number for each system |
| `*.mdp` | GROMACS MD parameter files for production runs |
| `*.top` / `*.itp` | Force-field topology files |

---

## Key Results

| System | Rg (500th frame, Å) | Rg (1000th frame, Å) | Trend |
|--------|--------------------|--------------------|-------|
| PEG400/water | — | — | Stable extended |
| PEG600/water | — | — | Slight compaction |
| PEG2000/water | — | — | Helix-like collapse |
| PEG400/gas | — | — | Compact globule |

*Note: Exact values from trajectory analysis — see `density_framewise.dat` files.*

---

## Technology Stack

- **GROMACS** 2022 — production MD engine
- **VMD** 1.9.4 — trajectory visualisation + Tcl analysis scripts
- **CHARMM36** — polymer force-field parameters
- **Python / NumPy / Matplotlib** — post-processing and plotting

---

## Usage

```bash
# Run production MD
gmx grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md.tpr
gmx mdrun -v -deffnm md

# Radius of gyration
gmx gyrate -f md.xtc -s md.tpr -n index.ndx -o gyrate.xvg

# VMD density analysis
vmd -dispdev none -e Density.tcl
```

---

*Polymer Physics · Molecular Dynamics · GROMACS · VMD · PEG · Drug Formulation*
