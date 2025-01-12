from flask import Flask, request, render_template, jsonify
from PIL import Image, UnidentifiedImageError
import numpy as np
import tensorflow as tf
from tensorflow.keras.preprocessing.image import load_img, img_to_array
import os

# Initialize the Flask app
app = Flask(__name__)

# Load the trained model
MODEL_PATH = "brain_tumor_detection_model.h5"
try:
    model = tf.keras.models.load_model(MODEL_PATH)
    model.compile(optimizer='Adam', loss='categorical_crossentropy', metrics=['accuracy'])
    print(f"Model loaded successfully from {MODEL_PATH}")
except Exception as e:
    print(f"Error loading model: {e}")
    model = None

# Define class names
CLASS_NAMES = ["glioma", "meningioma", "notumor", "pituitary"]

# Prediction function
def predict_image(image_path):
    try:
        # Load and preprocess the image
        img = load_img(image_path, target_size=(128, 128))  # Assuming 128x128 input size
        img_array = img_to_array(img) / 255.0
        img_array = np.expand_dims(img_array, axis=0)
        
        # Predict the class
        predictions = model.predict(img_array)
        predicted_class = np.argmax(predictions, axis=1)[0]
        confidence = predictions[0][predicted_class]
        return CLASS_NAMES[predicted_class], confidence
    except Exception as e:
        print(f"Prediction error: {e}")
        raise

# Routes
@app.route('/')
def index():
    return render_template('index.html')  # Ensure index.html is present in your templates folder

@app.route('/predict', methods=['POST'])
def predict():
    if 'file' not in request.files:
        print("No file provided in the request.")
        return jsonify({"error": "No file provided"}), 400

    file = request.files['file']
    if file.filename == '':
        print("No file selected.")
        return jsonify({"error": "No file selected"}), 400

    print(f"Received file: {file.filename}, Content-Type: {file.content_type}")

    # Validate file type
    if not file.content_type.startswith('image/'):
        print("Invalid file type.")
        return jsonify({"error": "Invalid file type. Please upload an image."}), 400

    # Save the file temporarily
    os.makedirs('uploads', exist_ok=True)
    file_path = os.path.join('uploads', file.filename)
    try:
        file.save(file_path)
        print(f"File saved to {file_path}")
    except Exception as e:
        print(f"Error saving file: {e}")
        return jsonify({"error": "Failed to save the file"}), 500

    # Make prediction
    try:
        predicted_class, confidence = predict_image(file_path)
        print(f"Prediction: {predicted_class}, Confidence: {confidence}")
        os.remove(file_path)  # Clean up the uploaded file
        
        return jsonify({
            "class": predicted_class,
            "confidence": float(confidence)
        })
    except UnidentifiedImageError:
        print("Uploaded file is not a valid image.")
        return jsonify({"error": "Uploaded file is not a valid image"}), 400
    except Exception as e:
        print(f"Error during prediction: {e}")
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True, host='192.168.1.8', port=3000)
