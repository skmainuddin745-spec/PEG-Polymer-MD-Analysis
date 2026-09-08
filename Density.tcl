# density_framewise.tcl
# -------------------------------
# Usage in VMD:
#   mol new output.gro type gro
#   mol addfile traj.xtc type xtc waitfor all    ;# optional
#   source density_framewise.tcl

# ── User parameters ──
set molid     [molinfo top]      ;# or replace “top” with your mol ID
set x_nm      9.0                ;# box length from output.gro (nm)
set y_nm      9.0
set z_nm      9.0
set da_to_g   1.660539e-24       ;# Da → g
set A3_to_cm3 1.0e-24            ;# Å³ → cm³

# ── Precompute volume ──
set x_A  [expr {$x_nm * 10.0}]
set y_A  [expr {$y_nm * 10.0}]
set z_A  [expr {$z_nm * 10.0}]
set volume_A3  [expr {$x_A * $y_A * $z_A}]
set volume_cm3 [expr {$volume_A3 * $A3_to_cm3}]

# ── Frame count ──
set num_frames [molinfo $molid get numframes]

# ── Open output file ──
set outFile [open "density_framewise.dat" w]
puts $outFile "# Frame   Volume(Å^3)   System_Density(g/cm^3)   PEG4_Density(g/cm^3)   Urea_Density(g/cm^3)"

# ── Helper proc to sum masses ──
proc sum_mass {sel} {
    set mlist [$sel get mass]
    set total 0.0
    foreach m $mlist { set total [expr {$total + $m}] }
    return $total
}

# ── Loop over frames ──
for { set f 0 } { $f < $num_frames } { incr f } {
    # select all, peg4, and urea at frame f
    set sel_all  [atomselect $molid "all"        frame $f]
    set sel_peg  [atomselect $molid "resname peg4" frame $f]
    set sel_urea [atomselect $molid "resname urea" frame $f]

    # total system density
    set m_sys   [sum_mass $sel_all]
    set rho_sys [expr {($m_sys * $da_to_g) / $volume_cm3}]

    # PEG4 density
    set m_peg   [sum_mass $sel_peg]
    set rho_peg [expr {($m_peg * $da_to_g) / $volume_cm3}]

    # Urea density
    set m_urea  [sum_mass $sel_urea]
    set rho_urea [expr {($m_urea * $da_to_g) / $volume_cm3}]

    # write results
    puts $outFile "$f   $volume_A3   $rho_sys   $rho_peg   $rho_urea"

    # cleanup
    $sel_all delete
    $sel_peg delete
    $sel_urea delete
}

close $outFile
puts "Framewise density data saved to density_framewise.dat"
