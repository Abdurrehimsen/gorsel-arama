import tensorflow as tf, sys
import urllib2

image_url = sys.argv[1]

# Read in the image_data
image_data = urllib2.urlopen(image_url).read()
# Loads label file, strips off carriage return
label_lines = [line.rstrip() for line 
                   in tf.gfile.GFile("/home/abdurrehim/Desktop/Tarzara/app/tf_files/retrained_labels.txt")]

# Unpersists graph from file
with tf.gfile.FastGFile("/home/abdurrehim/Desktop/Tarzara/app/tf_files/retrained_graph.pb", 'rb') as f:
    graph_def = tf.GraphDef()
    graph_def.ParseFromString(f.read())
    _ = tf.import_graph_def(graph_def, name='')

with tf.Session() as sess:

    # Feed the image_data as input to the graph and get first prediction
    softmax_tensor = sess.graph.get_tensor_by_name('final_result:0')
    
    predictions = sess.run(softmax_tensor, \
             {'DecodeJpeg/contents:0': image_data})
    
    # Sort to show labels of first prediction in order of confidence
    top_k = predictions[0].argsort()[-len(predictions[0]):][::-1]
    
    predres = ""
    for node_id in top_k:
        predres += label_lines[node_id] + " " + str(predictions[0][node_id]) + " "
    print predres
