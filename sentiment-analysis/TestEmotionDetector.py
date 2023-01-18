import cv2
import numpy as np
from keras.models import model_from_json
import requests
import datetime as dt
import asyncio
from deepface import DeepFace

url = "https://bytehackz.vercel.app/api/auth/fearscore"

emotion_dict = {0: "Angry", 1: "Disgusted", 2: "Fearful", 3: "Happy", 4: "Neutral", 5: "Sad", 6: "Surprised"}

# load json and create model
json_file = open('model/emotion_model.json', 'r')
loaded_model_json = json_file.read()
json_file.close()
emotion_model = model_from_json(loaded_model_json)

last_request_date = None

# load weights into new modelq
emotion_model.load_weights("model/emotion_model.h5")

# start the webcam feed
cap = cv2.VideoCapture(0)
DeepFace.stream(db_path = 'model/emotion_model.json')

async def send_request(fearful_confidence):
    response = requests.post(url=url,json={"fearScore": fearful_confidence})

    print(response.text)

while True:
    # Find haar cascade to draw bounding box around face
    ret, frame = cap.read()
    frame = cv2.resize(frame, (1280, 720))
    if not ret:
        break
    face_detector = cv2.CascadeClassifier("haarcascade_frontalface_default.xml")
    gray_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    # detect faces available on camera
    num_faces = face_detector.detectMultiScale(gray_frame, scaleFactor=1.3, minNeighbors=5)

    # take each face available on the camera and Preprocess it
    if len(num_faces) >= 1:
        (x, y, w, h) = num_faces[0]

        cv2.rectangle(frame, (x, y-50), (x+w, y+h+10), (0, 255, 0), 4)
        roi_gray_frame = gray_frame[y:y + h, x:x + w]
        cropped_img = np.expand_dims(np.expand_dims(cv2.resize(roi_gray_frame, (48, 48)), -1), 0)

        # predict the emotions
        emotion_prediction = emotion_model.predict(cropped_img)
        maxindex = int(np.argmax(emotion_prediction))
        cv2.putText(frame, emotion_dict[maxindex], (x+5, y-20), cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 0, 0), 2, cv2.LINE_AA)

        # fearful emotion detected
        if last_request_date == None or (dt.datetime.now() - last_request_date).total_seconds() > 10:
            last_request_date = dt.datetime.now()

            fearful_confidence = float(emotion_prediction[0][2])
            
            asyncio.run(send_request(fearful_confidence)) 
    cv2.imshow('Emotion Detection', frame)
    
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break


cap.release()
cv2.destroyAllWindows()