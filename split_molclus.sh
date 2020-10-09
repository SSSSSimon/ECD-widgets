#!/bin/bash

# split optimization task to multiple part
# $1=number of partition
# $2=total number of geoms
# $3=iprog

ngeoms_per_partition=$[ $2 / $1 ]
remainder=$[ $2 % $1 ]

for ((i=1;i<=$1;i++))
do
mkdir $i
cp "molclus" $i
cp "template.mop" $i
cp "traj.xyz" $i
cp "settings.ini" $i
cp "template.inp" $i
cp "template.gjf" $i
done

for ((i=1;i<=$[ $1 - 1 ];i++))
do
echo "  iprog= ${3}  // The computational code to invoke. 1: Gaussian, 2: MOPAC, 3: ORCA, 4: xtb, 5: Open Babel
  ngeom= $[ $ngeoms_per_partition * $[ $i - 1 ] + 1 ]-$[ $ngeoms_per_partition * $i]  // Geometries in traj.xyz to be considered. 0: All, n: First n. You can also use e.g. 2,5-8,12-14 to customize range
  itask= 0  // Type of task. 0: Optimization, 1: Single point energy, 2: frequency, 3: Optimization with frequency, -1: Composite method (only for Gaussian, e.g. CBS-QB3)
  ibkout= 2  // When backup output file. 0: Never, 1: All, 2: Successful tasks, 3: Failed tasks
  distmax= 999  // If distance between any two atoms is larger than this (Angstrom), the geometry will be skipped
  ipause= 0  // When pause molclus. 1: Optimization didn't converge (For Gaussian and ORCA), 2: After each cycle, 0: Never pause
  freeze= 0  // Index of atoms to be freezed during optimization, e.g. 2,4-8,13-14. If no atom is to be freezed, this parameter should be set to 0
--- Below for Gaussian ---
  gaussian_path= \"g09\"  // Command for invoking Gaussian
  igaucontinue= 0  // 1: If optimization exceeded the upper number of steps, continue to optimize the last geometry using template2.gjf  0: Don't continue
  energyterm= \"HF=\" // For itask= 0 or 1, set label for extracting electron energy from archive part of output file, e.g. HF=, MP2=, CCSD(T)=. For itask= -1, set label for extracting thermodynamic quantity, e.g. \"G4 Free Energy=\" means G4 free energy will be extracted (need to write double quotes!). For itask= 2 or 3, this parameter does not need to be set because free energy is always extracted (however, if template_SP.gjf is presented, this parameter also determines loading which energy from high-level single point task).
  ibkchk= 0  // The same as ibkout, but for .chk file
--- Below for ORCA ---
  orca_path= \"/home/visitor/orca/orca\"  // Command for invoking ORCA
  ibkgbw= 0  // The same as ibkout, but for .gbw file
  ibktrj= 0  // 1: Backup optimization trajectory (*_trj.xyz) with step number in the file name, 0: Don't backup
  mpioption= none  // Special MPI option for running ORCA. e.g. --allow-run-as-root. If no option is needed, this option should be set to \"none\"
--- Below for MOPAC ---
  mopac_path= \"/home/visitor/MOPAC2016/MOPAC2016.exe\"  // Command for invoking MOPAC
--- Below for xtb ---
  xtb_arg= \"--gfn 1 --chrg 0 --uhf 0\"  // Additional arguments for xtb, e.g. \"vtight --gfn 1 --gbsa h2o --chrg 0\" (don't write task keywords such as \"--opt\" here)
--- Below for Open Babel ---
  obabel_FF= MMFF94  // Force field employed by Open Babel, available: MMFF94,   Ghemical, UFF, GAFF
  obabel_param= \"--steps 2500\" // Additional arguments for Open Babel. Hint: For large system, \"--log\" could be added to monitor minimization process
lastfile= traj.xyz" > "${i}/settings.ini"
done
echo "  iprog= ${3}  // The computational code to invoke. 1: Gaussian, 2: MOPAC, 3: ORCA, 4: xtb, 5: Open Babel
  ngeom= $[ $ngeoms_per_partition * $[ $i - 1 ] + 1 ]-$[ $ngeoms_per_partition * $i + $remainder]  // Geometries in traj.xyz to be considered. 0: All, n: First n. You can also use e.g. 2,5-8,12-14 to customize range
  itask= 0  // Type of task. 0: Optimization, 1: Single point energy, 2: frequency, 3: Optimization with frequency, -1: Composite method (only for Gaussian, e.g. CBS-QB3)
  ibkout= 2  // When backup output file. 0: Never, 1: All, 2: Successful tasks, 3: Failed tasks
  distmax= 999  // If distance between any two atoms is larger than this (Angstrom), the geometry will be skipped
  ipause= 0  // When pause molclus. 1: Optimization didn't converge (For Gaussian and ORCA), 2: After each cycle, 0: Never pause
  freeze= 0  // Index of atoms to be freezed during optimization, e.g. 2,4-8,13-14. If no atom is to be freezed, this parameter should be set to 0
--- Below for Gaussian ---
  gaussian_path= \"g09\"  // Command for invoking Gaussian
  igaucontinue= 0  // 1: If optimization exceeded the upper number of steps, continue to optimize the last geometry using template2.gjf  0: Don't continue
  energyterm= \"HF=\" // For itask= 0 or 1, set label for extracting electron energy from archive part of output file, e.g. HF=, MP2=, CCSD(T)=. For itask= -1, set label for extracting thermodynamic quantity, e.g. \"G4 Free Energy=\" means G4 free energy will be extracted (need to write double quotes!). For itask= 2 or 3, this parameter does not need to be set because free energy is always extracted (however, if template_SP.gjf is presented, this parameter also determines loading which energy from high-level single point task).
  ibkchk= 0  // The same as ibkout, but for .chk file
--- Below for ORCA ---
  orca_path= \"/home/visitor/orca/orca\"  // Command for invoking ORCA
  ibkgbw= 0  // The same as ibkout, but for .gbw file
  ibktrj= 0  // 1: Backup optimization trajectory (*_trj.xyz) with step number in the file name, 0: Don't backup
  mpioption= none  // Special MPI option for running ORCA. e.g. --allow-run-as-root. If no option is needed, this option should be set to \"none\"
--- Below for MOPAC ---
  mopac_path= \"/home/visitor/MOPAC2016/MOPAC2016.exe\"  // Command for invoking MOPAC
--- Below for xtb ---
  xtb_arg= \"--gfn 1 --chrg 0 --uhf 0\"  // Additional arguments for xtb, e.g. \"vtight --gfn 1 --gbsa h2o --chrg 0\" (don't write task keywords such as \"--opt\" here)
--- Below for Open Babel ---
  obabel_FF= MMFF94  // Force field employed by Open Babel, available: MMFF94,   Ghemical, UFF, GAFF
  obabel_param= \"--steps 2500\" // Additional arguments for Open Babel. Hint: For large system, \"--log\" could be added to monitor minimization process
lastfile= traj.xyz" > "${1}/settings.ini"

