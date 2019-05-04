import scipy.io
import numpy as np
import matplotlib.pyplot as plt
from sklearn.metrics import confusion_matrix
import plot_confusion_matrix
targets = scipy.io.loadmat('Wovels/Wovels/py_target1_data.mat')
outs = scipy.io.loadmat('Wovels/Wovels/py_gmm2_data.mat')
groups = scipy.io.loadmat('Wovels/Wovels/vowel_data.mat')
print(targets['py_target1'][0])
print(outs['py_gmm2'][0])
print(groups['vowel'])
plot_confusion_matrix.plot_confusion_matrix(targets['py_target1'][0],outs['py_gmm2'][0],groups['vowel'])
np.set_printoptions(precision=2)
plt.show()
