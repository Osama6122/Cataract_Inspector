from flask import Flask, request, jsonify
from flask_cors import CORS
from evaluate import eval
import numpy as np
import cv2
import base64
from pymongo import MongoClient
from datetime import datetime
import logging

# DEFINE CONFIG
PORT = 8000 # Port backend is running on
MONGODB_USERNAME = "cataractdetector"
MONGODB_PASSWORD = "udC3ww1amM48idoT"
MONGO_CONNECT_URL = f"mongodb+srv://{MONGODB_USERNAME}:{MONGODB_PASSWORD}@cluster0.xa4vby2.mongodb.net/?retryWrites=true&w=majority"


app = Flask("__main__")
CORS(app)

# Global variable for user collection
user_collection = None


# Define a route to get user info from mongodb
@app.route('/get_user', methods=['GET'])
def get_user():
    global user_collection  # Access the global user_collection variable

    try:
        email = request.args.get('email')

        if not email:
            return jsonify({'error': 'Email address is required'}), 400

        user_data = user_collection.find_one({'email': email})

        if user_data:
            # Exclude MongoDB _id field from the response
            user_data.pop('_id', None)
            return jsonify(user_data), 200
        else:
            return jsonify({'error': 'User not found'}), 404

    except Exception as e:
        return jsonify({'error': f'Error fetching user data: {str(e)}'}), 500

# Define a route to add user info to mongodb database
@app.route('/add_user', methods=['POST'])
def add_user():
    logging.info("Beginning of Add User")
    global user_collection  # Access the global user_collection variable
    logging.info("Before Try")
    try:
        logging.info("Inside Try")
        print(request.headers['Content-Type'])
        # Get user data from the request
        data = request.form
        logging.info("Got Data in json")
        first_name = data.get('first_name')
        last_name = data.get('last_name')
        age = validate_age(data.get('age'))
        gender = data.get('gender')
        email = data.get('email')
        avatar = data.get('selected_avatar')
        logging.info("Got Data from request successfully")

        # Ensure all required fields are provided
        if not all([first_name, last_name, gender, age, email, avatar]):
            return jsonify({'error': 'Incomplete user data'}), 400
        
        logging.info("All Data found successfully")

        # Check if the user already exists based on the email
        existing_user = user_collection.find_one({'email': email})
        if existing_user:
            # Update existing user
            user_collection.update_one(
                {'email': email},
                {'$set': {'first_name': first_name, 'last_name': last_name, 'age': age, 'gender': gender, 'avatar': avatar, 'last_modified': datetime.utcnow()}}
            )
        else:
            # Insert new user
            user_collection.insert_one({
                'first_name': first_name,
                'last_name': last_name,
                'age': age,
                'gender': gender,
                'email': email,
                'avatar': avatar,
                'last_modified': datetime.utcnow()
            })

        return jsonify({'message': 'User data saved successfully'}), 200

    except ValueError as e:
        return jsonify({'error': str(e)}), 400
    except Exception as e:
        return jsonify({'error': f'Error saving user data: {str(e)}'}), 500


def validate_age(age):
    try:
        age = int(age)
        if 0 < age < 100:
            return age
        else:
            raise ValueError("Age must be greater than 0 and less than 100")
    except ValueError:
        raise ValueError("Invalid age value, must be an integer")


# Define a route for the cataract API
@app.route('/check_for_cataract', methods=['POST'])
def check_for_cataract():
    # Check if the POST request contains a file
    if 'image' not in request.files:
        return jsonify({'error': 'No image found'})

    image = request.files['image']

    # Check if the file has a name
    if image.filename == '':
        return jsonify({'error': 'No image selected'})

    image_data = image.read()
    nparr = np.frombuffer(image_data, np.uint8)
    image_data = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
    # You can now process the file as needed e.g. perform cataract detection
    result = eval(image_data)


    user_email = request.form.get('email')  # or request.args.get('user_id')

    # Process and store the image and result in MongoDB
    # Assuming you have a MongoDB collection named 'users'
    _, buffer = cv2.imencode('.jpg', image_data)
    image_base64 = base64.b64encode(buffer).decode('utf-8')

    timestamp = datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S')

    # Store the base64 string instead of the numpy array
    user_collection.update_one(
        {'email': user_email},
        {'$push': {'eye_images': {'timestamp': timestamp, 'image_base64': image_base64, 'result': result}}}, upsert=True
    )


    return jsonify({'result': result})


if __name__ == '__main__':
    # Set up logging
    logging.basicConfig(level=logging.INFO)

    try:
        # Attempt to connect to MongoDB Atlas
        client = MongoClient(MONGO_CONNECT_URL)

        user_collection = client.cataract_detector_db.users  # Replace with your actual database and collection name
        # Explicitly check the connection by listing database names
        db_names = client.list_database_names()

        # Log success message
        logging.info("Connected to MongoDB Atlas successfully")

    except Exception as e:
        # Log error message if the connection fails
        client = None
        logging.error(f"Failed to connect to MongoDB Atlas: {e}")

    # Only start the app if the database connection is successful
    if "client" in locals() and client is not None:
        print(client)
        app.run(host='0.0.0.0', port=PORT)

    
    



    '''
    To test the API, run the following curl command in your terminal:
    (1)     curl -X POST -H "Content-Type: multipart/form-data" -F "image=@dense_white_mature_cataract.jpg" http://localhost:8000/check_for_cataract
    OR
    (2)     curl -X POST -F "image=@dense_white_mature_cataract.jpg" http://localhost:8000/check_for_cataract
    '''