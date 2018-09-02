import numpy as np
import scipy as sp
from scipy import linalg
from scipy.optimize import minimize, rosen, rosen_der
import scipy.integrate as integrate
from scipy.integrate import simps
import matplotlib as plot

x = np.linspace(1,10,10) #Sample parameters on curve
K = [0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5] #Gaussian curvature per curve param
size = len(x)-2
Width = np.linspace(1,1,8)

# Solve a matrix system M*W=B

def L(i): #Return parameter step
    return x[i+1]-x[i]
def generateMatrixM():
    #Generate B matrix (eq. 2.6 page 20. Special Curve Patterns for Freeform Architecture)
    M = np.zeros((size,size))

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
    
    return M
def generateMatrixB(w0,wM):
    #Generate B matrix (eq. 2.6 page 20. Special Curve Patterns for Freeform Architecture)
    B = np.zeros((size))
    i = 0
    B[i] = -2*L(i+1)*w0/(L(i)+L(i+1))
    i = size-1
    B[i] = -2*L(i-2)*wM/(L(i-2)+L(i-1))
    return B
def solveW1(): #Fundamental solution 1
    M = generateMatrixM()
    B = generateMatrixB(0,1)
    return linalg.solve(M,B)
def solveW2(): #Fundamental solution 2
    M = generateMatrixM()
    B = generateMatrixB(1,0)
    return linalg.solve(M,B)

#Calculate fundamental solution 1
W1 = solveW1()
# Calculate fundamental solution 2
W2 = solveW2()



# Once fundamental solutions have been founnd
# Must calculate lambda coefficients
lmbd = np.array([1,1])

print ("Initial lambdas:", lmbd[0],lmbd[1])
def w(s,lmbd):
    lambda1=lmbd[0]
    lambda2=lmbd[1]
    return lambda1*W1+lambda2*W2

res = integrate.nquad(w,x)
## Selecting a Jacobi Field
sample = np.linspace(2,9,8)

def f(params):
    # print(params)  # <-- you'll see that params is a NumPy array
    lambda1, lambda2 = params # <-- for readability you may wish to assign names to the component variables
    return lambda1**2 + lambda2**2


result = minimize(f, lmbd)
if result.success:
    fitted_params = result.x
    print('Fitted lambdas:', fitted_params)
else:
    raise ValueError(result.message)