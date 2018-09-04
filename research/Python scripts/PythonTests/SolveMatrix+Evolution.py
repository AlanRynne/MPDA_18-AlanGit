# -*- coding: utf-8 -*-
""" 
Python Script
Created on  Thursday August 2018 05:53:19 
@author:  Alan 

[desc]
Description of the plugin Here
Write here any thing... 
[/desc]

ARGUMENTS:
----------
<inp> 
    _input :[required] - [type = int] - [default = None] 
    Descripe your input here 
        * bullet point.
        * bullet point
</inp>
<inp>
    Other inputs go here ...
</inp>

RETURN:
----------
    <out>
        output_ : indicate your output description here. \n refers to a new line.
    </out>

"""

import numpy as np
import scipy as sp
from scipy import linalg
import matplotlib as plt
from scipy.optimize import differential_evolution

# Specify a target width (could also be a computed value according to curvature)
width = 1.00
W = np.linspace(width,width,10)

# Create a linear space to hold the sample parameters at the curve
s = np.linspace(0,1,10)
print(s)
# Curvature list
k = np.linspace(0.05,0.05,len(s))
print(k)
Lambda1 = 4
Lambda2 = -1

x = s #Sample parameters on curve
K = k #Gaussian curvature per curve param
size = len(x)-2

# Solve a matrix system M*W=B

M = np.zeros((size,size))
B = np.zeros((size))


def L(i): #Return parameter step
    return x[i+1]-x[i]

def w(args):
    # this is the width function
    # Lambda1 and 2 are the coeficients computed bi minimizing function ????
    # omega1 and 2 are the fundamental solutions of w(s) -> First: w(0)=0 w(1)=1; Second: w(0)=1 w(1)=0.
    arg1, arg2 = args
    return arg1*W1+arg2*W2;

def generateMatrixM():
    def diagCell(i):
        return L(i)*L(i+1)*K[i+1]-2

    def diagCellLeft(i):
        return 2*L(i+1)/(L(i)+L(i+1))

    def diagCellRight(i):
        return 2*L(i)/(L(i)+L(i+1))

    for i in range(0,size):
        M[i,i] = diagCell(i)
        if (i!=0): M[i,i-1] = diagCellLeft(i)
        if (i<size-1): M[i,i+1] = diagCellRight(i)


def generateMatrixB():
    i = 0
    B[i] = -2*L(i+1)*w0/(L(i)+L(i+1))
    i = size-1
    B[i] = -2*L(i-2)*wM/(L(i-2)+L(i-1))
    #B[size] = -2*L(size-2)*wM/(L(size-3)+L(size-2))

#Generate matrix M
generateMatrixM()

#Calculate fundamental solution 1
w0 = 0
wM = 1

generateMatrixB()
W1 = linalg.solve(M,B)

array = np.array(w0)
print (array)

# Calculate fundamental solution 2
w0 = 1
wM = 0
generateMatrixB()
W2 = linalg.solve(M,B)

print(w([Lambda1,Lambda2]))


# Calculate error function
def widthError(args):
    arg1, arg2 = args
    return np.sum(np.power((w([arg1,arg2]) - W[1:-1,]),2))

print("Error before optimization: ",widthError([Lambda1,Lambda2]))


bounds = [(-2, 2), (-2, 2)]
result = sp.optimize.minimize(widthError,[Lambda1,Lambda2],bounds=bounds )
print("Result ",result.x)
print("Result error ",result.fun)


#Output to grasshopper
a=W1.tolist()
b=W2.tolist()
c=w([Lambda1,Lambda2]).tolist()