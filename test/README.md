# Using NPFS and Fizzy 

* [IPython notebook](http://nbviewer.ipython.org/github/EESI/Fizzy/blob/master/test/Fizzy-Notebook.ipynb)
* At the shell, 
```bash 
fizzy -l $label-column -f $fs-method -i $biom-fp -m $map-fp -o $output-fp -n $select --json
#or 
fizzy -l $label-column -f $fs-method -i $biom-fp -m $map-fp -o $output-fp -n $select 
npfs -l $label-column -f $fs-method -i $biom-fp -m $map-fp -o $output-fp -n $select -n $select -c $cpus -b $bootstraps
```
