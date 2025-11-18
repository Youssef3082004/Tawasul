import pandas as pd


class Process_column:

    @staticmethod
    def NumberofUniqueWords(dataset:pd.DataFrame,Column:str):
        unique_words = set()
        for text in dataset[Column].dropna(): 
            for word in text.split():
                unique_words.add(word)
        num_unique_words = len(unique_words)
        print("Number of unique words:", num_unique_words)


    def __init__(self,Column_name:str,Dataset:pd.DataFrame):
        self.Column_name = Column_name
        self.Dataset = Dataset
    

    def Updeate_column(self,func):
        self.Dataset[self.Column_name] = self.Dataset[self.Column_name].apply(func=func)
        