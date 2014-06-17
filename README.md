# Fizzy Feature Selection Tool

Fizzy is a subset selection tool that uses [FEAST](http://www.cs.man.ac.uk/~gbrown/fstoolbox/) in the background to run feature selection. Fizzy processes [BIOM](http://biom-format.org/) and mapping files, which are a standard in metagenomics data analysis. `fizzy` will run feature selection on taxanomic abundances obtained from the biom file given a set of categorical labels obtained form the the mapping file.  

# Installation and Dependencies

Install the following dependencies: 
* [PyFeast](https://github.com/EESI/PyFeast) 
* [MIToolbox](https://github.com/Craigacp/MIToolbox) 
* [FEAST](https://github.com/Craigacp/FEAST)
* [PyNPFS]()

Then open a shell and run: 
```shell
 sudo make install
```

# Options 

## Fizzy 
```bash
Gregorys-MacBook-Pro-2:Fizzy gditzler$ fizzy -h
usage: fizzy [-h] [-n SELECT] -l LABEL [-f FS_METHOD] -i INPUT_FILE -m
             MAP_FILE [-j] -o OUTPUT_FILE

optional arguments:
  -h, --help            show this help message and exit
  -n SELECT, --select SELECT
                        number of features to select
  -l LABEL, --label LABEL
                        name of column of the mapping file that indicates the
                        labels
  -f FS_METHOD, --fs-method FS_METHOD
                        Feature selection method. Available: CIFE CMIM CondMI
                        Condred ICAP JMI MIM MIFS mRMR
  -i INPUT_FILE, --input-file INPUT_FILE
                        biom format file
  -m MAP_FILE, --map-file MAP_FILE
                        map file (tsv)
  -j, --json            store the output as a json format file.
  -o OUTPUT_FILE, --output-file OUTPUT_FILE
                        output file where selected OTU IDs and averages of the
                        OTUS for each classare stored
```

## NPFS
```bash
Gregorys-MacBook-Pro-2:Fizzy gditzler$ npfs -h
usage: npfs [-h] [-a ALPHA] [-b BOOTSTRAPS] [-c CPUS] [-f FS_METHOD] -i
            INPUT_FILE [-j] -l LABEL -m MAP_FILE [-n SELECT] -o OUTPUT_FILE

optional arguments:
  -h, --help            show this help message and exit
  -a ALPHA, --alpha ALPHA
                        size of the Neyman-Pearson hypothesis test
  -b BOOTSTRAPS, --bootstraps BOOTSTRAPS
                        number of bootstraps to run
  -c CPUS, --cpus CPUS  the number of bootstraps to run simultaneously
  -f FS_METHOD, --fs-method FS_METHOD
                        Feature selection method. Available: CIFE CMIM CondMI
                        Condred ICAP JMI MIM MIFS mRMR
  -i INPUT_FILE, --input-file INPUT_FILE
                        biom format file
  -j, --json            store the output as a json format file.
  -l LABEL, --label LABEL
                        name of column of the mapping file that indicates the
                        labels
  -m MAP_FILE, --map-file MAP_FILE
                        map file (tsv)
  -n SELECT, --select SELECT
                        number of features to start with
  -o OUTPUT_FILE, --output-file OUTPUT_FILE
                        output file where selected OTU IDsare stored 
```

# General Usage Example

A general useage example for Fizzy would be something along the lines of
```bash
  fizzy -i my-data.biom -o results.txt -m mapping-file.txt -f JMI -l BODY-SITE -n 100
```
where `BODY-SITE` is a column in the mapping file. The output file is save in JSON format with the fields that are the classes and a key called `Features`. The `Features` key contains the OTUs that were selected as relevant. Each of the class keys contains the average relative abundance of the OTUs that were selected. The user has contol over the output format (either TSV or JSON) by setting, or not setting the `json` flag. 

Also, check out the [IPython notebook](http://nbviewer.ipython.org/github/EESI/Fizzy/blob/master/test/Fizzy-Notebook.ipynb) for a general Fizzy usage example. 

# Credits

* [Calvin Morrison](http://mutantturkey.com/)
* [Gregory Ditzler](http://gregoryditzler.com)
* [Gail Rosen](http://www.ece.drexel.edu/gailr/) 

