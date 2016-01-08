import matplotlib
matplotlib.use('Agg')

import caffe
import numpy as np
import os
import os.path
import scipy.io as sio

caffe_root = '../'
MODEL_FILE = '../examples/kaggle2/deploy.prototxt'
# PRETRAINED = '../examples/kaggle2/googlenet/bvlc_googlenet_txt_lr_1e-3_1020_iter_95000.caffemodel'

caffe.set_device(10)
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
    # test_images_path = '/home/coldmanck/kaggle/ImagesTestCropAll'
    # length = len([name for name in os.listdir(test_images_path) if os.path.isfile(os.path.join(test_images_path, name))])
    # for name in os.listdir(test_images_path):
    #     if os.path.isfile(os.path.join(test_images_path, name)):
    #         caffe_predict(test_images_path, name)  

    if __name__ == "__main__":
        classifier = caffe.Classifier("train/predict.prototxt", model_file, image_dims=[384, 384], input_scale=0.00392156862745, channel_swap=[2, 1, 0])
        sample_df = pd.read_csv("data/sample_submission.csv")
        final_df = pd.DataFrame(columns=sample_df.columns, index=sample_df.index)
        final_df.Image = sample_df.Image
        batch_size = 8
        start_index = 0
        sample_len = len(sample_df)
        while start_index < sample_len:
          end_index = min(start_index + batch_size, sample_len)
          print "predicting ", start_index, ":", end_index
          img = [caffe.io.load_image("/home/coldmanck/kaggle/ImagesTestCropAll/{}".format(sample_df.Image[i])) for i in range(start_index, end_index)]
          preds = classifier.predict(img, oversample=False)
          final_df.ix[range(start_index, end_index), 1:] = preds[0].argmax()
          start_index = end_index
          print preds
          for i in range(0, 8):
            print preds[i].argmax()
        print "Writing output to", output_file
        final_df.to_csv(output_file, index=False)