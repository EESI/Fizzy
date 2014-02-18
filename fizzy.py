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


if __name__ == "__main__":
  sys.exit(main())
