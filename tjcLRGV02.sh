#!/bin/bash 

for i in {1..5}
do

#SBATCH -J tjcLRGV$i 
#SBATCH --time=5:00:00 
#SBATCH -N 5
#SBATCH --ntasks-per-node 1
#SBATCH -o tjcLRGV$i.out
#SBATCH --qos janus-long

# Select control file to run 
FILEBASE="AllDecAll$i" 

# The command shown below is what you need to complete a single seed, with Seed 1 shown here.
# You can add additional commands by enclosing them in "()" and separating by "&".  I ran a test and found that running commands in this way yeilded the same results as separate scripts (for multiple seeds).
	
(./borg.exe -v 8 -o 6 -c 4 -C E -R ${FILEBASE}_runtime_s1.txt \
-F 5000 -f ${FILEBASE}_s1.txt -l 0,0,0,0.1,0,0,0,0 -u 1,1,1,0.4,3,3,3,3 \
-e 0.0003,0.002,0.01,0.002,0.003,0.001 -n 1000 \
-s 1 \
-- ./lrgvForMOEAFramework -m std-io -b ${FILEBASE} \
-c combined -r 5000) &

#check to see which have begun
echo scenario $i started

done

wait
 
EOF
