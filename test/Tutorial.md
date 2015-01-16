# Getting Data 

We have parsed data collected from [American Gut Project](https://github.com/biocore/American-Gut) and placed the data, which has been split up by sample site, in a new Git repository. We shall use the data at Gregory Ditzler's [data repo](https://github.com/gditzler/DataCollections). To get the data, run:
```
git clone https://github.com/gditzler/DataCollections.git
cd DataCollections/
DCPATH=$(pwd)
```

# Running an Experiment with Fizzy and NPFS 

Once the data is downloaded, edit `run-fizzy-experiments.sh` to fill in the path variable for `DCPATH` in the script. This script provides a fairly comprehensive collection of experiments on how `fizzy` and `npfs` can be used. All result files will be saved in `outputs/`.

# Running Fizzy on a subsample of Omnivores and all Vegans 

This experiments is a bit more involved than some of the previous ones because we are required to modify the map and Biom files. First we should split the data by their diet. To do this, we use QIIME's `split_otu_table.py`.  
```
nsel=50
cd ${DCPATH}/AmericanGut/
 
# split the otu table in to different diet types
split_otu_table.py -i AmericanGut-Gut-Diet.biom -m AmericanGut-Gut-Diet.txt -f DIET_TYPE -o tmp/
cd tmp/
```

Once the split performed, we need to 'subsample' the Omnivores data, such that we have 65 samples. To do so, lets modify the map file such that the first 65 entries that their original diet, but the others are going to be marked as being dropped. The `AmericanGut-Gut-Diet_Omnivore.biom` and its new map file are going to be split again.  

```
# create a new omnivore mapping file to identify a subsample of size 65 
cat -n mapping_Omnivore.txt | awk -F '\t' '{if($1 < 66){ print $2,$3;}else{print $2,"DROP"} }' | tr ' ' '\t' >  new_mapping_Omnivore.txt
split_otu_table.py -i AmericanGut-Gut-Diet_Omnivore.biom -m mapping_Omnivore.txt -f DIET_TYPE -o subset-omni/
```

Now we need to merge the subsampled omnivores data with the vegans, so we are going to merge the OTU and map files. 

```
# merge the otu table of the subsample of omnivores and vegans
merge_otu_tables.py -i subset-omni/AmericanGut-Gut-Diet_Omnivore_Omnivore.biom,AmericanGut-Gut-Diet_Vegan.biom -o subsample-OmniVegan.biom
 
# merge the mapping files of the subsample of omnivores and vegans
merge_mapping_files.py -m subset-omni/mapping_Omnivore.txt,mapping_Vegan.txt -o subsample-OmniVegan.txt
```

Now that this is completed, we can run `fizzy`

```
# run fizzy 
fizzy -l DIET_TYPE -f JMI -i subsample-OmniVegan.biom -m subsample-OmniVegan.txt -n ${nsel} -o subsample-OmniVegan-Fizzy-JMI.txt -r subsample-OmniVegan-Fizzy-JMI.biom
 
# print out the differences in the abundances
cat -n subsample-OmniVegan-Fizzy-JMI.txt | tr -d ' ' | awk -F '\t' '{d=$4-$7; if (d >= 0) {print $1-1,$2,sprintf("%.9f", d),"p";}else{print $1-1,$2,sprintf("%.9f", -d),"n";} }'  | tail -n +2 | sort -k3 -nr | head -15
```

