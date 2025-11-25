import cv2

face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + "haarcascade_frontalface_default.xml")

def detect_faces(image_path):
    image = cv2.imread(image_path)

    if image is None:
        return {"face_found": False,"faces": [],"error": "Image not found or unreadable"}

    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    faces = face_cascade.detectMultiScale(gray, scaleFactor=1.2,minNeighbors=5)

    face_list = []
    for (x, y, w, h) in faces:
        face_list.append({"x": int(x), "y": int(y), "w": int(w), "h": int(h)})

    return {"face_found": len(face_list) > 0,"faces": face_list}


result = detect_faces("D:\My Download\Files\1748620995354.jpg")

print(result)

if result["face_found"]:
    print("Faces detected:", len(result["faces"]))
else:
    print("No face found")
