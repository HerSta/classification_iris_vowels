from itertools import islice
import numpy as np
from plot_confusion_matrix import plot_confusion_matrix
from mpl_toolkits.mplot3d import Axes3D
from matplotlib.ticker import MaxNLocator
import matplotlib.pyplot as plt
plt.close('all')


#In our dataset we have 4 features. A "1" indicate that the corresponding feature will be used. 0 and the feature will be ignored. Prior analysis shows that the order of the features in descending order of overlap is:
#f2, f1, f4, f3
used_features = [0,0,1,0]
features = sum(used_features) 
C = 3
N = 50
split_at = 30
def main():
    number_of_times_to_train = 5000
    x,t = read_data(split_at);
    #generate_histograms_for_features_and_classes(x)
    w = calculateWeights(number_of_times_to_train, split_at, C, x) 
  
    class_names = ['setosa','versicolor','virginica']
    gen_conf_matrix(w,x,class_names)
    gen_conf_matrix(w,t,class_names)

    plt.rcParams.update({'font.size': 52})
    plt.show()

def gen_conf_matrix(w,y,class_names):
    l = len(y) // C
    y_true_d = [1]*l + [2]*l + [3]*l
    y_d = [0]*len(y)
    y_pred_d = y_d
    for i in range(len(y)):
        y_d[i] = np.matmul(w,y[i,:])
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
        del xs[i][3]
        del xs[i][1]
        del xs[i][0]
    x = np.zeros((split_at*C,features + 1))
    ones = np.ones(split_at*C)
    x[:,features] = ones
    x[:,0:features] = xs

    ts = t1 + t2 + t3
    for i in range(len(ts)):
        ts[i] = ts[i].split(',')
        del ts[i][3]
        del ts[i][1]
        del ts[i][0]
    t = np.zeros((len(ts),features + 1))
    ones = np.ones(len(ts))
    t[:,features] = ones
    t[:,0:features] = ts
    
    return x,t

def calculateWeights(number_of_times_to_train, split_at, C, x):
    alpha = 0.04 #training speed parameter set by us
    W_curr = np.zeros((C,features+1))
    W_prev = W_curr
    for i in range(number_of_times_to_train):
        MSE_grad_w = 0
        for k in range(split_at*C):
            yk = np.matmul(W_curr, x[k,:])[np.newaxis].T
            gk = sigmoid(yk)
            if k < split_at:
                tk = np.array([1,0,0])[np.newaxis].T
            elif k >= split_at and k < 2*split_at:
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

def sigmoid(x):
    return np.array(1 / (1 + np.exp(-x)))


main()
