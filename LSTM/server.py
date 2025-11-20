from fastapi import FastAPI
import pickle
import re
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
from nltk.stem import WordNetLemmatizer
import nltk
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing.sequence import pad_sequences


app = FastAPI()


model = load_model("sentiment_model.keras")

with open("tokenizer.pickle", "rb") as f:
    tokenizer = pickle.load(f)

with open("label_encoder.pkl", "rb") as f:
    label_encoder = pickle.load(f)

nltk.download("stopwords")
_stopwords = stopwords.words("english")


def _remove_Stopwords(text:list):
    return [x for x in text if x not in _stopwords]

def _Lemmatizong_data(text:list):
    Lemmarizer = WordNetLemmatizer()
    return [Lemmarizer.lemmatize(word=word,pos="v") for word in text]



def CleanText(Text:str):

    Text = Text.lower()
    Text = re.sub(pattern=r"[^\w\s]",repl=" ",string=Text)
    Text = re.sub(pattern=r"\b[a-z]+n\s+t\b",repl=" ",string=Text)
    Text = re.sub(pattern=r"\b[a-z]{1}\b",repl=" ",string=Text)
    Text = word_tokenize(Text)
    Text = _remove_Stopwords(Text)
    Text = _Lemmatizong_data(Text)
 

    return " ".join(Text)



@app.post("/Classify")
def ClassifyText(NoteText:str):

    text = [CleanText(Text=NoteText)]
    seq = tokenizer.texts_to_sequences(text)
    padded = pad_sequences(seq, maxlen=25, padding="post")

    y_pred = model.predict(padded)
    label = y_pred.argmax(axis=1)

    label_name = label_encoder.inverse_transform(label)[0]

    return {"Emotion":label_name,"Percentage":float(y_pred[0][label[0]])}
