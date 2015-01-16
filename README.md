# Fizzy Feature Selection Tool

Fizzy is a feature subset selection tool that uses [FEAST](http://www.cs.man.ac.uk/~gbrown/fstoolbox/) in the background to run feature selection on biological data formats. Fizzy processes [BIOM](http://biom-format.org/) and mapping files, which are a standard in metagenomics data analysis. `fizzy` will run feature selection on taxonomic abundances obtained from the biom file given a set of categorical labels obtained form the the mapping file.  `npfs` is a subset selection tool that provides inference on the number of features that are deemed as *important*. Note that if you do not specify a map file than it is assumed that the labels (indicated by the `--label` option) is stored in the `metadata` of the BIOM file for each of the samples in the data. Check out the [tutorial](https://github.com/gditzler/Fizzy/blob/master/test/Tutorial.md) to see `fizzy` and `npfs` in action.

*Do not use any version of Fizzy prior to v1.2.0*.  

# Installation and Dependencies

`fizzy` and `npfs` have a couple of dependencies, which are:
* [PyFeast](https://github.com/EESI/PyFeast)
* [PyNPFS](https://github.com/EESI/py-npfs)

Note, that you'll need to install [MIToolbox](https://github.com/Craigacp/MIToolbox) and [FEAST](https://github.com/Craigacp/FEAST) for PyFeast. After installing the dependencies open a shell and run:
```shell
 sudo make install
```

# Options

## Fizzy

Fizzy implements a suite of information theoretic subset selection objective functions. The objective function can be changed with the `-f` flag. Note that Fizzy requires the number of OTUs to be selected is specified in advance; however, NPFS can provide statistical inference on the number of important variables in the data.

```bash
Gregorys-MacBook-Pro-2:Fizzy gditzler$ fizzy -h
usage: fizzy [-h] [-n SELECT] [-q BINS] -l LABEL [-f FS_METHOD] -i INPUT_FILE
             [-m MAP_FILE] [-j] -o OUTPUT_FILE [-r OUTPUT_BIOM] [-v]

Fizzy implements feature subset selection for biological data formats, which
are commonly used in metagenomic data analysis.

optional arguments:
  -h, --help            show this help message and exit
  -n SELECT, --select SELECT
                        number of features to select
  -q BINS, --bins BINS  number of bins to histogram the data
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
                        OTUS for each class. are stored
  -r OUTPUT_BIOM, --output-biom OUTPUT_BIOM
                        output a BIOM file with the relative abundances of the
                        sub-matrix of the selected features.
  -v, --svf             the input file is a separated variables file
```

## NPFS

NPFS is applied as a wrapper to any feature subset selection algorithm, regardless of the obbjective function criteria used by that algorithm, to determine whether a feature belongs in the relevant set. Perhaps more importantly, this procedure efficiently determines the number of relevant features given an initial starting point. Refer to the reference shown below for the details of NPFS.

```bash
Gregorys-MacBook-Pro-2:Fizzy gditzler$ npfs -h
usage: npfs [-h] [-a ALPHA] [-b BOOTSTRAPS] [-c CPUS] [-f FS_METHOD] -i
            INPUT_FILE [-j] [-q BINS] -l LABEL [-m MAP_FILE] [-n SELECT] -o
            OUTPUT_FILE [-r OUTPUT_BIOM] [-v]

NPFS implements feature subset selection for biological data formats, which
are commonly used in metagenomic data analysis.

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
  -q BINS, --bins BINS  number of bins to histogram the data
  -l LABEL, --label LABEL
                        name of column of the mapping file that indicates the
                        labels
  -m MAP_FILE, --map-file MAP_FILE
                        map file (tsv)
  -n SELECT, --select SELECT
                        number of features to start with
  -o OUTPUT_FILE, --output-file OUTPUT_FILE
                        output file where selected OTU IDsare stored
  -r OUTPUT_BIOM, --output-biom OUTPUT_BIOM
                        output a BIOM file with the relative abundances of the
                        sub-matrix of the selected features.
  -v, --svf             the input file is a separated variables file
```

## Lasso 

```bash 
Gregorys-MacBook-Pro-2:Fizzy gditzler$ lasso -h
usage: lasso [-h] -l LABEL -i INPUT_FILE [-m MAP_FILE] [-j] -o OUTPUT_FILE
             [-r OUTPUT_BIOM] [-v] [-c CONFIG]

Fizzy implements feature subset selection for biological data formats, which
are commonly used in metagenomic data analysis.

optional arguments:
  -h, --help            show this help message and exit
  -l LABEL, --label LABEL
                        name of column of the mapping file that indicates the
                        labels
  -i INPUT_FILE, --input-file INPUT_FILE
                        biom format file
  -m MAP_FILE, --map-file MAP_FILE
                        map file (tsv)
  -j, --json            store the output as a json format file.
  -o OUTPUT_FILE, --output-file OUTPUT_FILE
                        output file where selected OTU IDs and averages of the
                        OTUS for each class. are stored
  -r OUTPUT_BIOM, --output-biom OUTPUT_BIOM
                        output a BIOM file with the relative abundances of the
                        sub-matrix of the selected features.
  -v, --svf             the input file is a separated variables file
  -c CONFIG, --config CONFIG
                        file path to lasso config file. see sklearn's
                        documentation on the options available to the user.
```

# General Usage Example

## Working with Biom files
A general useage example for Fizzy would be something along the lines of
```bash
fizzy -i my-data.biom -o results.txt -m mapping-file.txt -f JMI -l BODY-SITE -n 100
```
where `BODY-SITE` is a column in the mapping file. The output file is save in JSON format with the fields that are the classes and a key called `Features`. The `Features` key contains the OTUs that were selected as relevant. Each of the class keys contains the average relative abundance of the OTUs that were selected. The user has contol over the output format (either TSV or JSON) by setting, or not setting the `json` flag.

Also, check out the [IPython notebook](http://nbviewer.ipython.org/github/EESI/Fizzy/blob/master/test/Fizzy-Notebook.ipynb) for a general Fizzy and NPFS usage example.

## Working with CSV file

You can also with with CSV files as long as the file conforms to a strict standard. The csv file containing the abundances should look something like:
```bash
otu,sample1,sample2,sample3,sample4
otu1,0,0,1,1
otu2,2,2,1,1
otu3,1,2,2,1
otu4,1,1,1,1
otu5,2,2,2,2
```
where there first row contains the feature identifier followed by the sample IDs. Each subsequent row contains the feature name followed by the feature values for each sample. *Not sticking to this format could cause errors in the interpretation of the results*. You'll need a corresponding map file to identify the class labels. 

```bash
#SampleID Class
sample1 0
sample2 0
sample3 1
sample4 1
```

Calling `fizzy` or `npfs` is pretty much the same, just set the `-v` flag. 

```bash 
Gregorys-MacBook-Pro-2:Fizzy gditzler$ fizzy -n 2 -l Class -f MIM -m test.map -i test.csv -s -o test.ouput -r test.biom -v
```

The output selects otu1 and otu2, which makes sense because they are the only variables that carry information about the class label. 

```bash 
Gregorys-MacBook-Pro-2:src gditzler$ cat test.ouput 
Features  Feature IDs 1 (std) 0 (mean)  1 (mean)  0 (std)
otu1  Feature1  0.0119047619048 0.0 0.154761904762  0.0
otu2  Feature2  0.0119047619048 0.309523809524  0.154761904762  0.0238095238095
```

Note that the data in the csv file *MUST* be discretized into bins as per the FEAST documentation. 

## Configuring Lasso's Config

A config file might look something like the one below. This is an exhaustive list. A config file is not required if the system defaults are acceptable. 
```bash 
alpha:0.0001:float
fit_intercept:True:bool 
normalize:True:bool
precompute:auto:string
copy_X:True:bool 
max_iter:5000:int
tol:0.000001:float
warm_start:True:bool
positive=False:bool
cut_off:0.00001:float
```

* `alpha`, `fit_intercept`, `normalize`, `precompute`, `copy_X`, `max_iter`, `tol`, `warm_start`, `positive`: Scikit-learn's Lasso parameters. Refer the Scikit-learn's documentation. 
* `cut_off`: threshold for determining which weights are zero.


# Credits

* [Calvin Morrison](http://mutantturkey.com/)
* [Gregory Ditzler](http://gregoryditzler.com)
* [Gail Rosen](http://www.ece.drexel.edu/gailr/)

# References

* Gregory Ditzler, Robi Polikar, and Gail Rosen, "A bootstrap based Neyman-Pearson test for identifying variable importance," *IEEE Transactions on Neural Networks and Learning Systems*, 2014, In Press. ([link](http://ieeexplore.ieee.org/xpl/articleDetails.jsp?arnumber=6823119))
* Gavin Brown, Adam Pocock, Ming-Jie Zhao, and Mikel Lujan, “Conditional likelihood maximisation: A unifying framework ´
for information theoretic feature selection,” *Journal of Machine Learning Research*, vol. 13, pp. 27–66, 2012. ([link](http://jmlr.org/papers/v13/brown12a.html))
