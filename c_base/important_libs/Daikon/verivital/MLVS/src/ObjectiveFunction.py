import math
import time
import onnx
import onnxruntime as rt
from src.racos_util import predictWithOnnxruntime, propCheck
import numpy as np

#Sphere function for continue optimization
def Sphere(x):
    value = sum([(i-0.2)*(i-0.2) for i in x])
    return value

# FFN evaluation for continue optimization
def FFN(onnxModel,inVals,inpDtype, inpShape, inpSpecs, target, objType):
   flattenOrder='C'
   inputs = np.array(inVals, dtype=inpDtype)
   inputs = inputs.reshape(inpShape, order=flattenOrder) # check if reshape order is correct
   assert inputs.shape == inpShape

   output = predictWithOnnxruntime(onnxModel, inputs)
   flatOut = output.flatten(flattenOrder) # check order, 'C' for row major order

   # objType = 0 -> maximization
   # objType = 1 -> minimization

   retVal=propCheck(inVals,inpSpecs,flatOut)
   if (objType == 0):
      flatOut[target] = -flatOut[target]

   return retVal, flatOut[target]


# Ackley function for continue optimization
def Ackley(x):
    bias = 0.2
    value_seq = 0
    value_cos = 0
    for i in range(len(x)):
        value_seq += (x[i]-bias)*(x[i]-bias)
        value_cos += math.cos(2.0*math.pi*(x[i]-bias))
    ave_seq = value_seq/len(x)
    ave_cos = value_cos/len(x)
    value = -20*math.exp(-0.2*math.sqrt(ave_seq))-math.exp(ave_cos)+20.0+math.e
    return value

#A test function for mixed optimization
def MixedFunction(x):
    value = sum([i*i for i in x])
    return value

#set cover problem for discrete optimization
def SetCover(x):
    weight = [0.8356, 0.5495, 0.4444, 0.7269, 0.9960, 0.6633, 0.5062, 0.8429, 0.1293, 0.7355,
              0.7979, 0.2814, 0.7962, 0.1754, 0.0267, 0.9862, 0.1786, 0.5884, 0.6289, 0.3008]
    subset = []
    subset.append([0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0])
    subset.append([0, 0, 0, 1, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0])
    subset.append([1, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0])
    subset.append([0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0])
    subset.append([1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1])
    subset.append([0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0])
    subset.append([0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 0])
    subset.append([0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0])
    subset.append([0, 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0])
    subset.append([0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1])
    subset.append([0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0])
    subset.append([0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1])
    subset.append([1, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1])
    subset.append([1, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 1])
    subset.append([0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1])
    subset.append([1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0])
    subset.append([1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1])
    subset.append([0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1])
    subset.append([0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0])
    subset.append([0, 0, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1])

    allweight = 0
    countw = 0
    for i in range(len(weight)):
        allweight = allweight+weight[i]

    dims = []
    for i in range(len(subset[0])):
        dims.append(False)

    for i in range(len(subset)):
        if x[i] == 1:
            countw = countw + weight[i]
            for j in range(len(subset[i])):
                if subset[i][j] == 1:
                    dims[j] = True
    full = True
    for i in range(len(dims)):
        if dims[i] == False:
            full = False

    if full is False:
        countw = countw + allweight

    return countw

