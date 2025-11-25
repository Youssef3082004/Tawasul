import requests


API_URL = "https://awadallayossef-EmotionClassification.hf.space/predict"

# 2. Path to a test image on your computer
IMAGE_PATH = r"D:\My Download\Files\IMG_20251016_023413.jpg" 

def predict_emotion(image_path):
    try:
        with open(image_path, "rb") as img_file:
            files = {"image": img_file}
            
            
            response = requests.post(API_URL, files=files)
            
            if response.status_code == 200:
                data = response.json()                
                if "results" in data and "top3" in data["results"]:
                    top_emotion = data["results"]["top3"]
                    # print(f"\nDetected: {top_emotion['label']} ({top_emotion['value']:.2f})")
                    print(top_emotion)
            else:
                print(f"\nError: Server returned status {response.status_code}")
                print(response.text)
                
    except FileNotFoundError:
        print(f"Error: Could not find image at {image_path}")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    predict_emotion(IMAGE_PATH)