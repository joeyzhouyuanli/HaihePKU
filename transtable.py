#convert table (xls/csv) to one dimensional list.

#cd file path
import numpy as np
#to load the file
test=np.loadtxt("XXXX.csv", dtype=np.float, delimiter=',')
#to show as array
test.tolist()
#to transpose 转置
np.transpose(test)
#to convert to one-dimensional array
test.reshape(192,1)
