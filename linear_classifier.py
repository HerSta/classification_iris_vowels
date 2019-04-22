# x1,x2,x3 = trai2ing datasets for each class 1, 2, 3
from itertools import islice
import math
import numpy as np
from plot_confusion_matrix import plot_confusion_matrix

import matplotlib.pyplot as plt
plt.close('all')
def main():
    number_of_times_to_train = 5000
    nclasses = 3
    ndim = 4
    N = 30 #entire training set

    x,t = readData(N);

    w = calculateWeights(number_of_times_to_train, N, nclasses, x) 
  
    class_names = ['setosa','versicolor','virginica']
    gen_conf_d(N,w,x,class_names)
    gen_conf_t(20,w,t,class_names)

    plt.rcParams.update({'font.size': 52})
    plt.show()

def gen_conf_d(N,w,x,class_names):
    nclasses = 3
    y_true_d = [1]*30 + [2]*30 + [3]*30
    y_d = [0]*90
    y_pred_d = y_d
    for i in range(N*nclasses):
        y_d[i] = np.matmul(w,x[i,:])
        y_pred_d[i] = find_nearest_ret_idx(sigmoid(y_d[i]), 1) +1
    plot_confusion_matrix(y_true_d,y_pred_d,class_names)

def gen_conf_t(N,w,t,class_names):
    nclasses = 3
    y_true_d = [1]*20 + [2]*20 + [3]*20
    y_d = [0]*60
    y_pred_d = y_d
    for i in range(N*nclasses):
        y_d[i] = np.matmul(w,t[i,:])
        y_pred_d[i] = find_nearest_ret_idx(sigmoid(y_d[i]), 1) +1
    plot_confusion_matrix(y_true_d,y_pred_d,class_names)


def find_nearest_ret_idx(array, value):
    array = np.asarray(array)
    idx = (np.abs(array - value)).argmin()
    return idx 



def readData(N):
    ndim = 4
    nclasses = 3
    c1 = open("Iris_TTT4275/class_1",'r').read().split('\n')
    c2 = open("Iris_TTT4275/class_2",'r').read().split('\n')
    c3 = open("Iris_TTT4275/class_3",'r').read().split('\n')
    x1 = c1[20:50]
    t1 = c1[:20]
    x2 = c2[20:50]
    t2 = c2[:20]
    x3 = c3[20:50]
    t3 = c3[:20]
        
    #x1 = a1,b1,c1,d1
    #   = a2,c2,c2,d2
    xs = x1 + x2 +x3
    for i in range(len(xs)):
        xs[i] = xs[i].split(',')
    x = np.zeros((N*nclasses,ndim + 1))
    ones = np.ones(N*nclasses)
    x[:,4] = ones
    x[:,0:ndim] = xs

    ts = t1 + t2 + t3
    for i in range(len(ts)):
        ts[i] = ts[i].split(',')
    t = np.zeros((20*nclasses,ndim + 1))
    ones = np.ones(20*nclasses)
    t[:,4] = ones
    t[:,0:ndim] = ts
    
    return x,t

def calculateWeights(number_of_times_to_train, N, nclasses, x):
    alpha = 0.04 #training speed parameter set by us
    #this corresponds to beta1,2,3,4 and alpha


    W_curr = np.array([[0.0,0.0,0.0,0.0,0.0],
                       [0.0,0.0,0.0,0.0,0.0],
                       [0.0,0.0,0.0,0.0,0.0]])
    W_prev = W_curr
    for i in range(number_of_times_to_train):
        MSE_grad_w = 0
        for k in range(N*nclasses):
            yk = np.matmul(W_curr, x[k,:])[np.newaxis].T
            gk = sigmoid(yk) #this is done in order to avoid gk blowing up to infinity
            if k < 30:
                tk = np.array([1,0,0])[np.newaxis].T
            elif k >= 30 and k < 60:
                tk = np.array([0,1,0])[np.newaxis].T
            else: 
                tk = np.array([0,0,1])[np.newaxis].T


            grad_1 = np.multiply((gk-tk), gk)
            MSE_grad_w_k = np.matmul(np.multiply(grad_1, (1-gk)), (x[k,:])[np.newaxis])
            
            MSE_grad_w += MSE_grad_w_k
        W_curr = W_prev - alpha * MSE_grad_w
        W_prev = W_curr

    print("Final weights: ")
    print(W_curr)
    return W_curr

def printConfusionT():
    for i in range(number_classes):
        print("Data confusion table: ")

        print("Test confusion table: ")

def sigmoid(x):
    return np.array(1 / (1 + np.exp(-x)))



main()
