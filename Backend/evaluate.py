import h5py
import numpy as np
import cv2
from keras.models import load_model
import keras.backend as K
import keras.layers as KL


SEED = 42
EPOCHS = 100
BATCH_SIZE = 32
IMG_HEIGHT = 192
IMG_WIDTH = 256
THRESHOLD = 0.5


# Function to define the custom layer
def fixed_dropout(x, level, noise_shape=None, seed=None, **kwargs):
    return KL.Dropout(level, noise_shape, seed, **kwargs)(x)


def preprocess_image(image_data, img_width, img_height):
    #img = cv2.imread(image_path)
    img = cv2.cvtColor(image_data, cv2.COLOR_BGR2RGB)
    img = cv2.resize(img, (img_width, img_height))
    img = img / 255.0  
    img = np.expand_dims(img, axis=0) 
    return img


def eval(image):
    # Returns True if cataract detected. Else False
    
    # Load the trained model with custom layer
    custom_objects = {'FixedDropout': fixed_dropout}
    model_path = 'Trained_models/cataract_net.h5'
    with h5py.File(model_path, 'r') as file:
        loaded_model = load_model(file, custom_objects=custom_objects)

    processed_image = preprocess_image(image, IMG_WIDTH, IMG_HEIGHT)
    prediction_probabilities = loaded_model.predict(processed_image)
    cataract_predicted = True if prediction_probabilities[0, 0] > THRESHOLD else False

    print("Predicted class:", cataract_predicted)

    return cataract_predicted
