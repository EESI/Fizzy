#!/usr/bin/env python 
import json 
import numpy
import scipy.sparse as sp
from optparse import OptionParser

__author__ = "Gregory Ditzler"
__copyright__ = "Copyright 2013, EESI Laboratory (Drexel University)"
__credits__ = ["Gregory Ditzler"]
__license__ = "GPL"
__version__ = "0.3.0"
__maintainer__ = "Gregory Ditzler"
__email__ = "gregory.ditzler@gmail.com"
__status__ = "development"
__about__ = "Parse biom and map files without QIIME or BIOM-format"

def load_biom(fname):
  """
  load a biom file and return a dense matrix 
  :fname - string containing the path to the biom file
  :data - numpy array containing the OTU matrix
  :samples - list containing the sample IDs (important for knowing 
    the labels in the data matrix)
  :features - list containing the feature names
  """
  o = json.loads(open(fname,"U").read())
  if o["matrix_type"] == "sparse":
    data = load_sparse(o)
  else:
    data = load_dense(o)

  samples = []
  for sid in o["columns"]:
    samples.append(sid["id"])
  features = []
  for sid in o["rows"]:
    # check to see if the taxonomy is listed, this will generally lead to more 
    # descriptive names for the taxonomies. 
    if sid.has_key("metadata") and sid["metadata"] != None:
      if sid["metadata"].has_key("taxonomy"):
        #features.append(str( \
        #    sid["metadata"]["taxonomy"]).strip( \
        #    "[]").replace(",",";").replace("u'","").replace("'",""))
        features.append(json.dumps(sid["metadata"]["taxonomy"]))
      else:
        features.append(sid["id"])
    else:
      features.append(sid["id"])
  return data, samples, features 

def load_dense(obj):
  """
  load a biom file in dense format
  :obj - json dictionary from biom file
  :data - dense data matrix
  """
  n_feat,n_sample = obj["shape"]
  data = np.array(obj["data"])
  return data.transpose()

def load_sparse(obj):
  """
  load a biom file in sparse format
  :obj - json dictionary from biom file
  :data - dense data matrix
  """
  n_feat,n_sample = obj["shape"] 
  data = numpy.zeros((n_feat, n_sample))
  for val in obj["data"]:
    data[val[0], val[1]] = val[2]
  data = data.transpose() 
  return data

def load_map(fname):
  """
  load a map file. this function does not have any dependecies on qiime's
  tools. the returned object is a dictionary of dictionaries. the dictionary 
  is indexed by the sample_ID and there is an added field for the the 
  available meta-data. each element in the dictionary is a dictionary with 
  the keys of the meta-data. 
  :fname - string containing the map file path
  :meta_data - dictionary containin the mapping file information  
  """
  f = open(fname, "U")
  mfile = []
  for line in f: 
    mfile.append(line.replace("\n","").replace("#","").split("\t"))
  meta_data_header = mfile.pop(0)

  meta_data = {}
  for sample in mfile:
    sample_id = sample[0]
    meta_data[sample_id] = {}
    for identifier, value in map(None, meta_data_header, sample):
      meta_data[sample_id][identifier] = value 
  return meta_data

