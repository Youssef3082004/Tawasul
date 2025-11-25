import os
os.environ["TF_USE_LEGACY_KERAS"] = "1"
import cv2
import numpy as np
import tensorflow as tf
from tensorflow.keras.models import load_model

model = load_model("vgg19_emotion_classifier_regularized.h5")

IMG_SIZE = (160, 160)


class_labels = ['Angry', 'Disgust', 'Fear', 'Happy', 'Neutral', 'Sad', 'Surprise']


face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + "haarcascade_frontalface_default.xml")

cap = cv2.VideoCapture(0)

print("Starting camera... Press 'q' to quit.")

while True:
    ret, frame = cap.read()
    if not ret:
        break

    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    faces = face_cascade.detectMultiScale(gray, scaleFactor=1.2, minNeighbors=5)

    for (x, y, w, h) in faces:
        cv2.rectangle(frame, (x, y), (x+w, y+h), (0, 255, 0), 2)

        face_crop = frame[y:y+h, x:x+w]

        face_resized = cv2.resize(face_crop, IMG_SIZE)
        face_norm = face_resized / 255.0
        face_input = np.expand_dims(face_norm, axis=0)

        preds = model.predict(face_input)
        class_index = np.argmax(preds)
        confidence = np.max(preds)

        label = f"{class_labels[class_index]} ({confidence*100:.1f}%)"

        cv2.putText(frame, label, (x, y - 10),
                    cv2.FONT_HERSHEY_SIMPLEX, 0.8, (0, 255, 0), 2)

    cv2.imshow("Emotion Detector", frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()
