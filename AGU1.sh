#!/bin/bash 
Iteration=1
Job=AGU${Iteration}

for i in 1 4
do

#SBATCH -J ${Job}
#SBATCH --time=30:00:00 
#SBATCH -N
#SBATCH --ntasks-per-node 1
#SBATCH -o ${Job}.out
#SBATCH --qos janus-long

#For loop to run through all three control files.
#*_0c_control.txt has no constraints
#*_1c_control.txt has one constraints
#*_4c_control.txt has four constraints

# Select control file to run 
FILEBASE="${Job}_${i}c"
mkdir ${FILEBASE}_Out
#-C E has been removed because "E" is the default and could have an effect on the 0 constraint run.

# Command line for Borg MOEA
echo Scenario with ${i} constraints begun

for seed in {1..5}
do
(./borg.exe -v 8 -o 6 -c ${i} -R ${FILEBASE}_Out/${FILEBASE}_runtime_s${seed}.txt \
-F 5000 -f ${FILEBASE}_Out/${FILEBASE}_s${seed}.txt -l 0,0,0,0.1,0,0,0,0 -u 1,1,1,0.4,3,3,3,3 \
-e 0.0003,0.002,0.01,0.002,0.003,0.001 -n 10000 \
-s ${seed} \
-- ./lrgvForMOEAFramework -m std-io -b ${FILEBASE} \
-c combined -r 5000) &

#check to see which have begun
echo Seed ${seed} has begun

done
done

wait
 
#EOF
