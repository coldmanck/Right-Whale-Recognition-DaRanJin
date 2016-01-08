import matplotlib
matplotlib.use('Agg')

import caffe
import numpy as np
import os
import os.path
import scipy.io as sio

caffe_root = '../'
MODEL_FILE = '../examples/kaggle2/deploy.prototxt'
# PRETRAINED = '../examples/kaggle2/bvlc_googlenet2_lr_1e-2_iter_13000.caffemodel'
# PRETRAINED = '../examples/kaggle2/bvlc_googlenet6_iter_15000.caffemodel'
# PRETRAINED = '../examples/kaggle2/bvlc_googlenet_lr_3e-2_128_iter_7000.caffemodel'
# PRETRAINED = '../examples/kaggle2/bvlc_googlenet_lr_1e-4_iter_18000.caffemodel'
# PRETRAINED = '/media/VSlab/coldmanck/fast-rcnn/caffe-fast-rcnn/examples/kaggle2/bvlc_googlenet2_lr_5e-4_mean_129_inc_5b_iter_41000.caffemodel'
# PRETRAINED = '/media/VSlab/coldmanck/fast-rcnn/caffe-fast-rcnn/examples/kaggle2/bvlc_googlenet_lr_1e-4_iter_18000.caffemodel'
# PRETRAINED = '../examples/kaggle2/googlenet/bvlc_googlenet2_1e-4_iter_15000.caffemodel'
# PRETRAINED = '../examples/kaggle2/googlenet/bvlc_googlenet_txt_lr_1e-2_iter_5000.caffemodel'
# PRETRAINED = '../examples/kaggle2/googlenet/bvlc_googlenet_txt_lr_1e-2_iter_10000.caffemodel'
# PRETRAINED = '../examples/kaggle2/googlenet/bvlc_googlenet_txt_lr_5e-3_iter_10000.caffemodel'
# PRETRAINED = '../examples/kaggle2/googlenet/bvlc_googlenet_txt_lr_1e-2_step_25k_iter_10000.caffemodel'
# PRETRAINED = '../examples/kaggle2/googlenet/bvlc_googlenet_txt_lr_1e-3_iter_115000.caffemodel'
# PRETRAINED = '../examples/kaggle2/googlenet/bvlc_googlenet_txt_lr_1e-2_1020_iter_15000.caffemodel'
# PRETRAINED = '../examples/kaggle2/googlenet/bvlc_googlenet_lr_1e-2_layer_2_iter_80000.caffemodel'
# PRETRAINED = '../examples/kaggle2/googlenet/bvlc_googlenet_txt_lr_1e-2_1020_iter_80000.caffemodel'
# PRETRAINED = '../examples/kaggle2/googlenet/bvlc_googlenet_txt_lr_1e-3_1020_iter_95000.caffemodel'
# PRETRAINED = '/media/VSlab/coldmanck/fast-rcnn/caffe-fast-rcnn/examples/kaggle2/googlenet/bvlc_googlenet_txt_lr_1e-2_resize_rotated_iter_15000.caffemodel'
# PRETRAINED = '/media/VSlab/coldmanck/fast-rcnn/caffe-fast-rcnn/examples/kaggle2/googlenet/bvlc_googlenet_txt_lr_1e-2_resize_rotated_iter_40000.caffemodel'
# PRETRAINED = '/media/VSlab/coldmanck/fast-rcnn/caffe-fast-rcnn/examples/kaggle2/googlenet/bvlc_googlenet_txt_lr_1e-2_resize_rotated_iter_60000.caffemodel'
PRETRAINED = '/media/VSlab/coldmanck/fast-rcnn/caffe-fast-rcnn/examples/bvlc_googlenet_txt_lr_2e-2_resize_rotated_step_5k_iter_27500.caffemodel'

caffe.set_device(5)
caffe.set_mode_gpu()

net = caffe.Classifier(MODEL_FILE, PRETRAINED,
               mean=np.load('/home/coldmanck/kaggle/kaggle_mean.npy').mean(1).mean(1),
               # mean=np.load('../python/caffe/imagenet/ilsvrc_2012_mean.npy').mean(1).mean(1),
               channel_swap=(2,1,0),
               raw_scale=255,
               image_dims=(224, 224))
'''
net = caffe.Net(MODEL_FILE, PRETRAINED, caffe.TEST)

# input preprocessing: 'data' is the name of the input blob == net.inputs[0]
transformer = caffe.io.Transformer({'data': net.blobs['data'].data.shape})
transformer.set_transpose('data', (2,0,1))
transformer.set_mean('data', np.load('/home/coldmanck/kaggle/kaggle_mean.npy').mean(1).mean(1)) # mean pixel
transformer.set_raw_scale('data', 255)  # the reference model operates on images in [0,255] range instead of [0,1]
transformer.set_channel_swap('data', (2,1,0))  # the reference model has channels in BGR order instead of RGB
'''
def caffe_predict(path, name):
        full_path = os.path.join(path, name)
        input_image = caffe.io.load_image(full_path)
        print 'Image path: ', full_path
        # print input_image
        prediction = net.predict([input_image])

        '''
        net.blobs['data'].reshape(50,3,224,224)
        net.blobs['data'].data[...] = transformer.preprocess('data', 
            caffe.io.load_image(path))
        out = net.forward()
        print "-----------"
        print("Predicted class is #{}.".format(out['prob'][0].argmax()))
        '''

        print prediction
        print "----------"
        print 'prediction shape: ', prediction[0].shape
        print 'predicted class: ', prediction[0].argmax()

        proba = prediction[0][prediction[0].argmax()]
        ind = prediction[0].argsort()[-5:][::-1] # top-5 predictions

        print 'probability: ', proba
        print 'top-5: ', ind

        save_mat_dir = os.path.join(caffe_root, 'result', 'kaggle')
        if not os.path.exists(save_mat_dir):
           os.makedirs(save_mat_dir)
        sio.savemat(os.path.join(save_mat_dir, name + '.mat'), {'fileName': name,'class': prediction[0].argmax(), 'probability': proba, 'top5': ind})

        return prediction[0].argmax(), proba, ind

if __name__ == '__main__':
    # testing
    # img_path = '/home/coldmanck/kaggle/ImagesTestCropAll/w_5256.jpg'
    
    # training
    # img_path = '/home/coldmanck/kaggle/ImagesTrainCropAll/w_1669.jpg' # 7
    # img_path = '/home/coldmanck/kaggle/ImagesTrainCropAll/w_8098.jpg' # 13

    # validation
    # img_path = '/home/coldmanck/kaggle/ImagesTrainCropAll/w_9382.jpg' # 22
    
    # caffe_predict(img_path)

    # test_images_path = '/home/coldmanck/kaggle/ImagesTestCropAll'
    # test_images_path = '/media/VSlab/coldmanck/kaggle/croppedTestImageNewRotated'
    # test_images_path = '/media/VSlab/coldmanck/kaggle/croppedTestImageNewRotatedResized'
    test_images_path = '/media/VSlab/coldmanck/kaggle/testcrops'
    # length = len([name for name in os.listdir(test_images_path) if os.path.isfile(os.path.join(test_images_path, name))])
    for name in os.listdir(test_images_path):
        if os.path.isfile(os.path.join(test_images_path, name)):
            caffe_predict(test_images_path, name)
