# Fizzy Feature Selection Tool

Fizzy is a subset selection tool that uses [FEAST](http://www.cs.man.ac.uk/~gbrown/fstoolbox/) in the background to run feature selection. Fizzy processes [BIOM](http://biom-format.org/) and mapping files, which are a standard in metagenomics data analysis. `fizzy` will run feature selection on taxanomic abundances obtained from the biom file given a set of categorical labels obtained form the the mapping file.  

# Installation and Dependencies

You need to install the [PyFeast](https://github.com/EESI/PyFeast) feature selection library in order to run the tools in Fizzy; however, PyFeast has its own dependencies - namely FEAST. Install the [MIToolbox](https://github.com/Craigacp/MIToolbox) and [FEAST](https://github.com/Craigacp/FEAST) prior to installing PyFeast. For example, you may need to do
```shell
  git clone https://github.com/Craigacp/MIToolbox.git
  cd MIToolbox
  make 
  sudo make install
  cd ../
  git clone https://github.com/Craigacp/FEAST.git
  cd FEAST
  make
  sudo make install
  cd ../
  git clone https://github.com/EESI/PyFeast.git
  cd PyFeast
  python setup.py build 
  sudo python setup.py install 
```

The above code will install all of the dependencies. Installing `fizzy` requires that you have root access because it is copied to `/usr/local/bin/`. Run `make` at the commandline. Make sure that all of the feature selection methods are compiled with FEAST. Note that this will require you to check the `Makefile` of FEAST.  

# Options 

* `-l`, `--label`: name of column of the mapping file that indicates the labels
* `-n`, `--select`: number of taxonomic features to select
* `-f`, `--fs-method`: Feature selection method. Available: CIFE CMIM CondMI, Condred ICAP JMI MIM MIFS mRMR
* `-i`, `--input-file`: biom format file
* `-m`, `--map-file`: TSV mapping file
* `-o`, `--ouput-file`: output file where selected taxonimic IDs are saved
* `-j`, `--json`: save the file in JSON not TSV format (TSV if the option is not set)
Getting help with `fizzy`:
```bash 
  fizzy -h
```

# General Usage Example

A general useage example for Fizzy would be something along the lines of
```bash
  fizzy -i my-data.biom -o results.txt -m mapping-file.txt -f JMI -l BODY-SITE -n 100
```
where `BODY-SITE` is a column in the mapping file. The output file is save in JSON format with the fields that are the classes and a key called `Features`. The `Features` key contains the OTUs that were selected as relevant. Each of the class keys contains the average abundance of the OTUs that were selected. 

Also, check out the [IPython notebook](http://nbviewer.ipython.org/github/EESI/Fizzy/blob/master/test/Fizzy-Notebook.ipynb) for a general Fizzy usage example. 

# Credits

* [Calvin Morrison](http://mutantturkey.com/)
* [Gregory Ditzler](http://gregoryditzler.com)
* [Gail Rosen](http://www.ece.drexel.edu/gailr/) 

