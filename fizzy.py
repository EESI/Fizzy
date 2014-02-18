'''
Fizzy command line interface
'''
__authors__ = [ "Gregory Ditzler", "Calvin Morrison" ]
__license__ = "GPL"
__maintainer__ = "Gregory Ditzler"
__email__ = "gditzler@gmail.com"
__status__ = "Beta"

import os
import sys
import argparse
import bmu

try:
  import feast
except ImportError:
  raise ApplicationNotFoundError("Error loading the PyFeast module. It is likely that you do not have PyFeast installed locally.")

def get_fs_methods():
    """
        get_fs_methods()
        return the feature selection methods that are 
        available for use in a list. note that the options
        are case sensitive. 
    """
    return ['CIFE','CMIM','CondMI','Condred','ICAP','JMI','MIM','MIFS','mRMR']


def main():

  #TODO greg fill in descriptions
  parser = argparse.ArgumentParser(description=
      "Fizzy implements feature selection for metagenomics \n")
  parser.add_argument("-n", "--select", type=int, help="number of features to select", required=True)
  parser.add_argument("-c", "--column-label", type=int, help="column indicating labels in map file")
  parser.add_argument("-f", "--fs-method", help="Feature selection method. Available: CIFE CMIM CondMI Condred ICAP JMI MIM MIFS mRMR", required=True)
  parser.add_argument("-i", "--input-file", help="biom format file", required=True)
  parser.add_argument("-m", "--map-file", help="CSV mapping file", required=True)
  parser.add_argument("-o", "--output-file", help="output file where selected OTU IDs are stored")

  args = parser.parse_args()

  # Make sure our input exist
  if not os.path.isfile(args.input_file):
    parser.error("input file not found")

  if not os.path.isfile(args.map_file):
    parser.error("map file not found")

  if args.select < 1:
    parser.error("you must select at least one result")

  if args.fs_method not in get_fs_methods():
    parser.error("fs method not found. please select from " + ' '.join(get_fs_methods()))

  data_arr = bmu.load_biom(args.input_file)
  map_arr = bmu.load_map(args.map_file)

if __name__ == "__main__":
  sys.exit(main())

def run_pyfeast(data, labels, features, method='MIM', n_select=15):
    """
        run_pyfeast(data, labels, method)
        @data - numpy data (dense)
        @labels - vector of class labels (discrete)
        @features - list of feature names
        @method - feature selection method
        @n_select - number of features to select

        The feature selection method is based off of the FEAST 
        C variable selection toolbox. 

        Reference:
        Gavin Brown, Adam Pocock, Ming-Jie Zhao, and Mikel Lujan, 
            "Conditional Likelihood Maximisation: A Unifying Framework 
            for Information Theoretic Feature Selection," Journal of 
            Machine Learning Research, vol. 13, pp. 27--66, 2012.
            (http://jmlr.csail.mit.edu/papers/v13/brown12a.html)
    """
    
    try:
        import feast
    except ImportError:
        raise ApplicationNotFoundError("Error loading the PyFeast module. It is likely that you do not have PyFeast installed locally.")

    try:
        fs_method = getattr(feast, method)
    except AttributeError:
        raise AttributeError("Unknown feature selection method is being specified for PyFeast. Make sure the feature selection method being selected is a valid one. ")

    if len(data.transpose()) < n_select:
        raise ValueError("n_select must be less than the number of observations.")
    if n_select <= 0:
        raise ValueError("n_select cannot be less than or equal to zero.")

    sf = fs_method(data, labels, n_select)
    reduced_set = []
    for k in range(len(sf)):
        reduced_set.append(features[int(sf[k])])
    return reduced_set

