# 🚀 Deployment Branch

<p align="center">
  <a href="https://huggingface.co/spaces/awadallayossef-lstm-sentimant-analysis">
    <img src="https://img.shields.io/badge/Hugging%20Face-FF6E1A?style=for-the-badge&logo=huggingface&logoColor=white" alt="Hugging Face"/>
  </a>
  <a href="https://www.docker.com/">
    <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" alt="Docker"/>
  </a>
  <a href="https://fastapi.tiangolo.com/">
    <img src="https://img.shields.io/badge/FastAPI-009688?style=for-the-badge&logo=fastapi&logoColor=white" alt="FastAPI"/>
  </a>
</p>


## 🔍 LSTM Model API Overview

- **Task:** Classify text (e.g., sentences or reviews) into sentiment categories.  
- **Model:** LSTM neural network for sequence classification.  
- **Use case:** Deploying one of my trained models for sentiment prediction on the **Tawasul Application**.  
- **Branch purpose:** This branch is specifically for **deployment**, containing all files needed to run the model in a Space or locally.


## 📂 Project Structure

```
.
├── README.md
├── .gitignore
└── LSTM/
    ├── app.py                
    ├── Dockerfile            
    ├── inference.ipynb 
    ├── sentiment_model.keras       
    ├── label_encoder.pkl     
    ├── tokenizer.pickle      
    └── requirements.txt     
```


## ⚙️ How It Works

1. The user enters a piece of text.  
2. The app preprocesses the input (tokenization, padding, etc.).  
3. The LSTM model processes the sequence and outputs a **sentiment label** (e.g., “Happy”, “Anger”) and **confidence score**.  
4. The result is displayed in real time on the **Tawasul Application**.


## 🚩 How to Test the Model in Python

You can test the deployed LSTM sentiment analysis model using **Python** and the `requests` library.

### 🔹 Test Code

```python
import requests

# API endpoint of the deployed Hugging Face Space
url = "https://awadallayossef-lstm-sentimant-analysis.hf.space/Classify"

# Text input to analyze
params = {"NoteText": "I'm Very happy because today i finished my exams"}

try:
    # Send POST request
    response = requests.post(url, params=params,)
    
    if response.status_code == 200:
        print(response.json())
    else:
        print(f"Error {response.status_code}:")
        print(response.text)

except Exception as e:
    print(f"Connection failed: {e}")
````

### 🔹 Example Output

```
{'Emotion': 'Happy', 'Percentage': 0.5736358761787415}
```






## 🔍 CNN Model API Overview

- **Task:** Detect faces in images and classify emotions (e.g., Happy, Disgust, Contempt).  

- **Model:** Convolutional Neural Network **(CNN/ResNet50V2)** for emotion classification combined with Haar Cascades for face detection.  

- **Use Case:** Deploy a computer vision model for real-time emotion recognition on the Tawasul Application.  

- **Branch Purpose:** This branch is specifically for deployment, containing the API server, real-time video scripts, and inference tools.

## 📂 Project Structure

`````
.
├── README.md
├── .gitignore
└── CNN/
    ├── Server.py
    ├── Face Detection.py
    ├── Video Face Detection.py
    ├── inference.py
    ├── Dockerfile
    ├── Model.h5
    └── requirements.txt

`````

## ⚙️ How It Works

1. **Input:** The user sends an image file to the API or streams video via the webcam script.  
2. **Face Detection:** The system uses OpenCV Haar Cascades to locate faces within the frame.  
3. **Preprocessing:** Detected faces are cropped, resized (e.g., 224x224), and normalized.  
4. **Classification:** The deep learning model predicts an emotion label (e.g., Happy, Surprise) with a confidence score.  
5. **Output:** The result is returned as JSON (API) or displayed as an overlay on the video feed.

## 🚩 How to Test the Model in Python

You can test the deployed Emotion Classification model using Python and the `requests` library.

```python
import requests

# API endpoint of the deployed Hugging Face Space
API_URL = "https://awadallayossef-EmotionClassification.hf.space/predict"

# Path to a test image on your computer
image_path = "path/to/your/image.jpg"

try:
    with open(image_path, "rb") as img_file:
        files = {"image": img_file}
        response = requests.post(API_URL, files=files)
        
        if response.status_code == 200:
            data = response.json()
            if "results" in data and "top3" in data["results"]:
                top_emotion = data["results"]["top3"]
                print("Prediction Success:")
                print(top_emotion)
        else:
            print(f"Error: Server returned status {response.status_code}")
            print(response.text)

except FileNotFoundError:
    print(f"Error: Could not find image at {image_path}")
except Exception as e:
    print(f"An error occurred: {e}")
````

### 🔹 Example Output

```json
[
  {
    "rank": 1,
    "label": "Happy",
    "value": 0.985
  },
  {
    "rank": 2,
    "label": "Neutral",
    "value": 0.012
  },
  {
    "rank": 3,
    "label": "Surprise",
    "value": 0.003
  }
]
```

