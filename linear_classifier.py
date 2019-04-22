# x1,x2,x3 = trai2ing datasets for each class 1, 2, 3
from itertools import islice
import math
import numpy as np
from plot_confusion_matrix import plot_confusion_matrix
from mpl_toolkits.mplot3d import Axes3D
from matplotlib.ticker import MaxNLocator

import matplotlib.pyplot as plt
plt.close('all')

features = 4
C = 3
N = 50
split_at = 50
def main():
    number_of_times_to_train = 5000
    x,t = read_data(50);
    generate_histograms_for_features_and_classes(x)
    #w = calculateWeights(number_of_times_to_train, split_at, C, x) 
  
    #class_names = ['setosa','versicolor','virginica']
    #gen_conf_d(split_at,w,x,class_names)
    #gen_conf_t(20,w,t,class_names)

    #plt.rcParams.update({'font.size': 52})
    #plt.show()

def gen_conf_d(w,x,class_names):
    C = 3
    y_true_d = [1]*30 + [2]*30 + [3]*30
    y_d = [0]*90
    y_pred_d = y_d
    for i in range(split_at*C):
        y_d[i] = np.matmul(w,x[i,:])
        y_pred_d[i] = find_nearest_ret_idx(sigmoid(y_d[i]), 1) +1
    plot_confusion_matrix(y_true_d,y_pred_d,class_names)

def gen_conf_t(w,t,class_names):
    C = 3
    y_true_d = [1]*20 + [2]*20 + [3]*20
    y_d = [0]*60
    y_pred_d = y_d
    for i in range(split_at*C):
        y_d[i] = np.matmul(w,t[i,:])
        y_pred_d[i] = find_nearest_ret_idx(sigmoid(y_d[i]), 1) +1
    plot_confusion_matrix(y_true_d,y_pred_d,class_names)


def find_nearest_ret_idx(array, value):
    array = np.asarray(array)
    idx = (np.abs(array - value)).argmin()
    return idx 

def generate_histograms_for_features_and_classes(x):
    fig = plt.figure()
    ax = fig.add_subplot(111,projection='3d')
    nbins = 20
    for i in range(C):
        data = x[50*i:50*(i+1)]
        for j,c in zip(range(features), ['#AD2A1A','g','b','#3C6478']):
            hist, bins = np.histogram(data[:,j],bins=nbins)
            xs = (bins[:-1] + bins[1:]) / 2.0 
            l1 = ax.bar(xs,hist, zs = i+1 , zdir='y', width=0.1,color=c, ec=c,alpha=0.8)
            ax.legend(('f1','f2','f3','f4'), loc='upper right', shadow=True)
    ax.set_ylabel('Class')
    ax.yaxis.set_major_locator(MaxNLocator(integer=True))

    plt.show()

            
    #plt.legend(['s_f1','s_f2','s_f3','s_f4','ve_f1','ve_f2','ve_f3','ve_f4','vi_f1','vi_f2','vi_f3','vi_f4'])
    #plt.show()
#The first-parameter indicates whether you want the first k samples or the last k samples.
#If split_at == 50 x contains all the data.
def read_data(split_at,first=True):
    c1 = open("Iris_TTT4275/class_1",'r').read().split('\n')
    c2 = open("Iris_TTT4275/class_2",'r').read().split('\n')
    c3 = open("Iris_TTT4275/class_3",'r').read().split('\n')
    if first == False:
        x1 = c1[split_at:50]
        t1 = c1[:split_at]
        x2 = c2[split_at:50]
        t2 = c2[:split_at]
        x3 = c3[split_at:50]
        t3 = c3[:split_at]
    else: 
        x1 = c1[:split_at]
        t1 = c1[split_at:50]
        x2 = c2[:split_at]
        t2 = c2[split_at:50]
        x3 = c3[:split_at]
        t3 = c3[split_at:50]
        
    #x1 = a1,b1,c1,d1
    #   = a2,c2,c2,d2
    xs = x1 + x2 +x3
    for i in range(len(xs)):
        xs[i] = xs[i].split(',')
    x = np.zeros((split_at*C,features + 1))
    ones = np.ones(split_at*C)
    x[:,4] = ones
    x[:,0:features] = xs

    ts = t1 + t2 + t3
    for i in range(len(ts)):
        ts[i] = ts[i].split(',')
    t = np.zeros((len(ts),features + 1))
    ones = np.ones(len(ts))
    #t[:,4] = ones
    #t[:,0:features] = ts
    
    return x,t

def calculateWeights(number_of_times_to_train, split_at, C, x):
    alpha = 0.04 #training speed parameter set by us
    #this corresponds to beta1,2,3,4 and alpha


    W_curr = np.array([[0.0,0.0,0.0,0.0,0.0],
                       [0.0,0.0,0.0,0.0,0.0],
                       [0.0,0.0,0.0,0.0,0.0]])
    W_prev = W_curr
    for i in range(number_of_times_to_train):
        MSE_grad_w = 0
        for k in range(split_at*C):
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
