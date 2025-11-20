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


## 🔍 Model API Overview

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


