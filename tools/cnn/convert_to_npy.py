#!/usr/bin/python
import matplotlib
matplotlib.use('Agg')

import numpy as np
from caffe.io import blobproto_to_array2
from caffe.proto import caffe_pb2

blob = caffe_pb2.BlobProto()

filename = '/home/coldmanck/kaggle/kaggle_mean.binaryproto'

data = open(filename, "rb").read() 
blob.ParseFromString(data) 

nparray =blobproto_to_array2(blob) 
f = file("/home/coldmanck/kaggle/kaggle_mean.npy","wb") 
np.save(f,nparray) 
f.close()
