import numpy as np
import matplotlib.pyplot as plt
%matplotlib inline

# Make sure that caffe is on the python path:
caffe_root = '../'  # this file is expected to be in {caffe_root}/examples
import sys
sys.path.insert(0, caffe_root + 'python')

import caffe

plt.rcParams['figure.figsize'] = (10, 10)
plt.rcParams['image.interpolation'] = 'nearest'
plt.rcParams['image.cmap'] = 'gray'

import os
caffe.set_device(7)
caffe.set_mode_gpu()
net = caffe.Net(caffe_root + 'examples/kaggle2/deploy.prototxt',
                caffe_root + 'examples/kaggle2/bvlc_googlenet_iter_40000.caffemodel',
                caffe.TEST)
