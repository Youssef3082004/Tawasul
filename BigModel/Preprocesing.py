import pandas as pd


class Process_column:

    def __init__(self,Column_name:str,Dataset:pd.DataFrame):
        self.Column_name = Column_name
        self.Dataset = Dataset
    

    def Updeate_column(self,func):
        self.Dataset[self.Column_name] = self.Dataset[self.Column_name].apply(func=func)
        