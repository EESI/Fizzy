#!/usr/bin/env bash

# run-fizzy-experiments.sh
# Copyright (C) 2014  Gregory Ditzler
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

cores=20
boots=250
nsel=500
DCPATH=''
mkdir outputs/

###############################################################################
###############################################################################
###############################################################################
echo "Running MIM; AG-SEX"
fizzy -l SEX -f MIM -i ${DCPATH}/AmericanGut/AmericanGut-Gut-Sex.biom  \
  -m ${DCPATH}/AmericanGut/AmericanGut-Gut-Sex.txt \
  -o outputs/AmericanGut-Gut-Sex-Results-Fizzy-MIM.txt -n ${nsel} \
  -r outputs/AmericanGut-Gut-Sex-Results-Fizzy-MIM.biom

echo "Running JMI; AG-SEX"
fizzy -l SEX -f JMI -i ${DCPATH}/AmericanGut/AmericanGut-Gut-Sex.biom \
  -m ${DCPATH}/AmericanGut/AmericanGut-Gut-Sex.txt \
  -o outputs/AmericanGut-Gut-Sex-Results-Fizzy-JMI.txt -n ${nsel} \
  -r outputs/AmericanGut-Gut-Sex-Results-Fizzy-JMI.biom

echo "Running NPFS-MIM; AG-SEX"
npfs -l SEX -f MIM -i ${DCPATH}/AmericanGut/AmericanGut-Gut-Sex.biom \
  -m ${DCPATH}/AmericanGut/AmericanGut-Gut-Sex.txt -o tmp.txt \
  -n ${nsel} -c ${cores} -b ${boots} -r outputs/AmericanGut-Gut-Sex-Results-NPFS-MIM.biom

cat tmp.txt | sed -e "s/[a-z]\_\_//g" -e "s/,,//g" -e 's/,\t/\t/g' > outputs/AmericanGut-Gut-Sex-Results-NPFS-MIM.txt
rm tmp.txt


echo "Running NPFS-JMI; AG-SEX"
npfs -l SEX -f JMI -i ${DCPATH}/AmericanGut/AmericanGut-Gut-Sex.biom \
  -m ${DCPATH}/AmericanGut/AmericanGut-Gut-Sex.txt -o tmp.txt -n ${nsel} \
  -c ${cores} -b ${boots} -r outputs/AmericanGut-Gut-Sex-Results-NPFS-JMI.biom

cat tmp.txt | sed -e "s/[a-z]\_\_//g" -e "s/,,//g" -e 's/,\t/\t/g' > outputs/AmericanGut-Gut-Sex-Results-NPFS-JMI.txt
rm tmp.txt


###############################################################################
###############################################################################
###############################################################################
echo "Running MIM; AG-DIET"
fizzy -l DIET_TYPE -f MIM -i ${DCPATH}/AmericanGut/AmericanGut-Gut-Diet-OmniVegan.biom \
  -m ${DCPATH}/AmericanGut/AmericanGut-Gut-Diet-OmniVegan.txt \
  -o outputs/AmericanGut-Gut-Diet-OmniVegan-Results-Fizzy-MIM.txt -n ${nsel} \
  -r outputs/AmericanGut-Gut-Diet-OmniVegan-Results-Fizzy-MIM.biom

echo "Running JMI; AG-DIET"
fizzy -l DIET_TYPE -f JMI -i ${DCPATH}/AmericanGut/AmericanGut-Gut-Diet-OmniVegan.biom \
  -m ${DCPATH}/AmericanGut/AmericanGut-Gut-Diet-OmniVegan.txt \
  -o outputs/AmericanGut-Gut-Diet-OmniVegan-Results-Fizzy-JMI.txt -n ${nsel} \
  -r outputs/AmericanGut-Gut-Diet-OmniVegan-Results-Fizzy-JMI.biom

echo "Running NPFS-MIM; AG-DIET"
npfs -l DIET_TYPE -f MIM \
  -i ${DCPATH}/AmericanGut/AmericanGut-Gut-Diet-OmniVegan.biom \
  -m ${DCPATH}/AmericanGut/AmericanGut-Gut-Diet-OmniVegan.txt -o tmp.txt \
  -n ${nsel} -c ${cores} -b ${boots} -r outputs/AmericanGut-Gut-Diet-OmniVegan-Results-NPFS-MIM.biom

cat tmp.txt | sed -e "s/[a-z]\_\_//g" -e "s/,,//g" -e 's/,\t/\t/g' > outputs/AmericanGut-Gut-Diet-OmniVegan-Results-NPFS-MIM.txt
rm tmp.txt

echo "Running NPFS-JMI; AG-DIET"
npfs -l DIET_TYPE -f JMI \
  -i ${DCPATH}/AmericanGut/AmericanGut-Gut-Diet-OmniVegan.biom \
  -m ${DCPATH}/AmericanGut/AmericanGut-Gut-Diet-OmniVegan.txt -o tmp.txt \
  -n ${nsel} -c ${cores} -b ${boots} -r outputs/AmericanGut-Gut-Diet-OmniVegan-Results-NPFS-JMI.biom

cat tmp.txt | sed -e "s/[a-z]\_\_//g" -e "s/,,//g" -e 's/,\t/\t/g' > outputs/AmericanGut-Gut-Diet-OmniVegan-Results-NPFS-JMI.txt
rm tmp.txt


###############################################################################
###############################################################################
###############################################################################
echo "Running MIM; Caporaso-Sex"
fizzy -l SEX -f MIM -i ${DCPATH}/Caporaso/caporaso-gut.biom \
  -m ${DCPATH}/Caporaso/caporaso-gut.txt -o outputs/caporaso-gut-Results-Fizzy-MIM.txt \
  -n ${nsel} -r outputs/caporaso-gut-Results-Fizzy-MIM.biom

echo "Running JMI; Caporaso-Sex"
fizzy -l SEX -f JMI -i ${DCPATH}/Caporaso/caporaso-gut.biom \
  -m ${DCPATH}/Caporaso/caporaso-gut.txt \
  -o outputs/caporaso-gut-Results-Fizzy-JMI.txt -n ${nsel} \
  -r outputs/caporaso-gut-Results-Fizzy-JMI.biom

echo "Running NPFS-MIM; Caporaso-Sex"
npfs -l SEX -f MIM -i ${DCPATH}/Caporaso/caporaso-gut.biom \
  -m ${DCPATH}/Caporaso/caporaso-gut.txt -o tmp.txt -n ${nsel} -c ${cores} \
  -b ${boots} -r outputs/caporaso-gut-Results-NPFS-MIM.biom

cat tmp.txt | sed -e "s/[a-z]\_\_//g" -e "s/,,//g" -e 's/,\t/\t/g' > outputs/caporaso-gut-Results-NPFS-MIM.txt
rm tmp.txt
 
echo "Running NPFS-JMI; Caporaso-Sex"
npfs -l SEX -f JMI -i ${DCPATH}/Caporaso/caporaso-gut.biom \
  -m ${DCPATH}/Caporaso/caporaso-gut.txt -o tmp.txt \
  -n ${nsel} -c ${cores} -b ${boots} -r outputs/caporaso-gut-Results-NPFS-JMI.biom

cat tmp.txt | sed -e "s/[a-z]\_\_//g" -e "s/,,//g" -e 's/,\t/\t/g' > outputs/caporaso-gut-Results-NPFS-JMI.txt
rm tmp.txt






###############################################################################
###############################################################################
###############################################################################
echo "Running MIM; AG-DIET"
fizzy -l DIET_TYPE -f MIM -i ${DCPATH}/AmericanGut/AmericanGut-Gut-Diet.biom \
  -m ${DCPATH}/AmericanGut/AmericanGut-Gut-Diet-OV.txt \
  -o outputs/AmericanGut-Gut-Diet-OV-Results-Fizzy-MIM.txt -n ${nsel} \
  -r outputs/AmericanGut-Gut-Diet-OV-Results-Fizzy-MIM.biom

echo "Running JMI; AG-DIET"
fizzy -l DIET_TYPE -f JMI -i ${DCPATH}/AmericanGut/AmericanGut-Gut-Diet.biom \
  -m ${DCPATH}/AmericanGut/AmericanGut-Gut-Diet-OV.txt \
  -o outputs/AmericanGut-Gut-Diet-OV-Results-Fizzy-JMI.txt -n ${nsel} \
  -r outputs/AmericanGut-Gut-Diet-OV-Results-Fizzy-JMI.biom

echo "Running NPFS-MIM; AG-DIET"
npfs -l DIET_TYPE -f MIM \
  -i ${DCPATH}/AmericanGut/AmericanGut-Gut-Diet.biom \
  -m ${DCPATH}/AmericanGut/AmericanGut-Gut-Diet-OV.txt -o tmp.txt \
  -n ${nsel} -c ${cores} -b ${boots} -r outputs/AmericanGut-Gut-Diet-OV-Results-NPFS-MIM.biom

cat tmp.txt | sed -e "s/[a-z]\_\_//g" -e "s/,,//g" -e 's/,\t/\t/g' > outputs/AmericanGut-Gut-Diet-OV-Results-NPFS-MIM.txt
rm tmp.txt

echo "Running NPFS-JMI; AG-DIET"
npfs -l DIET_TYPE -f JMI \
  -i ${DCPATH}/AmericanGut/AmericanGut-Gut-Diet.biom \
  -m ${DCPATH}/AmericanGut/AmericanGut-Gut-Diet-OV.txt -o tmp.txt \
  -n ${nsel} -c ${cores} -b ${boots} -r outputs/AmericanGut-Gut-Diet-OV-Results-NPFS-JMI.biom

cat tmp.txt | sed -e "s/[a-z]\_\_//g" -e "s/,,//g" -e 's/,\t/\t/g' > outputs/AmericanGut-Gut-Diet-OV-Results-NPFS-JMI.txt
rm tmp.txt


