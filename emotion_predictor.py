import joblib

# 🧠 تحميل الموديل والمعالج
model = joblib.load("emotion_model.pkl")
tfidf = joblib.load("tfidf_vectorizer.pkl")

# 🗂️ خريطة التصنيفات
label_map = {
    0: "anger",
    1: "fear",
    2: "joy",
    3: "love",
    4: "sadness",
    5: "surprise"
}

def predict_emotion(text):
    X = tfidf.transform([text])
    prediction = model.predict(X)[0]
    return label_map[int(prediction)]

# 🚀 تشغيل تلقائي عند الفتح
if __name__ == "__main__":
    print("🔹 Emotion Detection Model Ready!")
    while True:
        user_input = input("\nاكتب جملة (أو اكتب exit للخروج): ")
        if user_input.lower() == "exit":
            print("👋 تم إنهاء البرنامج.")
            break
        print("🎯 Emotion:", predict_emotion(user_input))
