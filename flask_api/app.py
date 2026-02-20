# 👉 Import necessary libraries
from flask import Flask, request, jsonify             # Flask for API handling
import joblib                                          # Load the ML model and label encoder
import numpy as np                                     # To reshape input arrays for prediction
import firebase_admin                                  # To connect with Firebase
from firebase_admin import credentials, firestore      # Firebase auth and Firestore client

# 👉 Create the Flask app instance
app = Flask(__name__)

# 👉 Load the trained ML model
model = joblib.load("vark_xgboost_model.pkl")

# 👉 Load the label mapping (e.g. {'Visual': 0, ...})
label_mapping = joblib.load("label_mapping.pkl")

# 👉 Invert the label mapping: {0: 'Visual', ...}
inverse_label_mapping = {v: k for k, v in label_mapping.items()}

# 👉 Initialize Firebase Admin SDK using service account
cred = credentials.Certificate("club-2f8df-firebase-adminsdk-7tui8-b8596db7c7.json")
firebase_admin.initialize_app(cred)

# 👉 Get the Firestore database client
db = firestore.client()

# 👉 Define the exact order of features your model expects
FEATURE_ORDER = [
    'Visual_Score', 'Auditory_Score', 'Read/Write_Score', 'Kinesthetic_Score',
    'Visual_Activity_Time', 'Auditory_Activity_Time', 'Read/Write_Activity_Time', 'Kinesthetic_Activity_Time',
    'Visual_Quiz_Time', 'Auditory_Quiz_Time', 'Read/Write_Quiz_Time', 'Kinesthetic_Quiz_Time',
    'Visual_Avg_Q_Time', 'Auditory_Avg_Q_Time', 'Read/Write_Avg_Q_Time', 'Kinesthetic_Avg_Q_Time',
    'VARK_Result'
]

# 👉 Define the API route to receive POST requests
@app.route('/predict-style', methods=['POST'])
def predict_style():
    try:
        # ✅ Step 1: Get the user ID from the incoming JSON request
        data = request.get_json()
        user_id = data.get("user_id")

        if not user_id:
            return jsonify({"error": "Missing user_id"}), 400

        # ✅ Step 2: Fetch user's input from Firestore `ai_inputs` collection
        doc = db.collection("ai_inputs").document(user_id).get()
        if not doc.exists:
            return jsonify({"error": "User input not found"}), 404

        user_input = doc.to_dict()

        # ✅ Step 3: Arrange input data in the expected order
        try:
            features = [user_input[field] for field in FEATURE_ORDER]
        except KeyError as e:
            return jsonify({"error": f"Missing field in Firestore: {str(e)}"}), 400

        # ✅ Step 4: Predict the learning style using the ML model
        features_np = np.array(features).reshape(1, -1)
        prediction = model.predict(features_np)[0]
        predicted_label = inverse_label_mapping[int(prediction)]

        # ✅ Step 5: Save the predicted style to `users` collection
        db.collection("users").document(user_id).update({
            "learningStyle": predicted_label
        })

        # ✅ Step 6: Return the result as JSON
        return jsonify({
            "user_id": user_id,
            "predicted_style": predicted_label,
            "status": "success"
        })

    except Exception as e:
        return jsonify({"error": str(e)}), 500

# 👉 Run the Flask server on localhost
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)

