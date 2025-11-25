import os
os.environ["TF_USE_LEGACY_KERAS"] = "1"  
from tf_keras.models import load_model
import cv2
import numpy as np
from fastapi import FastAPI, UploadFile, File
from fastapi.responses import JSONResponse
import io
from PIL import Image



IMG_SIZE = (224, 224)
CLASS_LABELS = ['Angry', "Contempt",'Disgust', 'Fear', 'Happy', 'Neutral', 'Sad', 'Surprise']
model = load_model("Model.h5", compile=False)
face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + "haarcascade_frontalface_default.xml")
app = FastAPI(debug=True)

def get_top3_predictions(preds, class_labels):
    """
    preds: softmax vector (1D array)
    class_labels: your CLASS_LABELS list
    """

    sorted_idx = np.argsort(preds)[::-1]

    top3 = []
    for i in range(3):
        idx = sorted_idx[i]
        top3.append({
            "rank": i + 1,
            "label": class_labels[idx],
            "value": float(preds[idx])
        })

    return top3



def detect_faces(image_bgr):
    """
    Detect faces in a BGR image.
    Returns dict with list of face bounding boxes.
    """
    gray = cv2.cvtColor(image_bgr, cv2.COLOR_BGR2GRAY)

    faces = face_cascade.detectMultiScale(gray,scaleFactor=1.2,minNeighbors=5)

    face_list = []
    for (x, y, w, h) in faces:
        face_list.append({"x": int(x), "y": int(y), "w": int(w), "h": int(h)})

    return {"face_found": len(face_list) > 0,"faces": face_list}


def process_and_predict(image_bgr, x, y, w, h):
    face_crop = image_bgr[y:y+h, x:x+w]

    face_resized = cv2.resize(face_crop, IMG_SIZE)
    face_norm = face_resized / 255.0
    face_input = np.expand_dims(face_norm, axis=0)

    preds = model.predict(face_input, verbose=0)
    top3 = get_top3_predictions(preds[0], CLASS_LABELS)

    return {"top3": top3}


@app.post("/predict")
async def predict(image: UploadFile = File(...)):
    try:
        img_bytes = await image.read()
        pil_img = Image.open(io.BytesIO(img_bytes)).convert("RGB")

        image_np = np.array(pil_img)
        image_bgr = cv2.cvtColor(image_np, cv2.COLOR_RGB2BGR)

        detection = detect_faces(image_bgr)

        results = []
        faces = detection["faces"]

        if detection["face_found"] and len(faces) >= 1:
            f = faces[0]

            if f["w"] > 0 and f["h"] > 0:
                results.append(process_and_predict(image_bgr, f["x"], f["y"], f["w"], f["h"]))
            else: 
                results.append({"faces": 0})   
        else:
            results.append({"faces": 0})

        return JSONResponse({"status": "success", "results": results[0]})

    except Exception as e:
        return JSONResponse({"status": "error", "message": str(e)}, status_code=500)
