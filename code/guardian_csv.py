"""
Guardian Scraper

https://open-platform.theguardian.com/

"""




import requests
import datetime
import re
import pandas as pd
import os


API_KEY = os.getenv("GUARDIAN_API_KEY")
file_name = "../data/guardian_articles.csv"



if API_KEY:
    print("API Key Loaded Successfully")
else:
    print("API Key Not Found")
    
    



# check if csv already exists
if os.path.exists(file_name):
    Guardian_df = pd.read_csv(file_name)
    last_date = Guardian_df['webPublicationDate'].str[:10].iloc[-1]
else:
    Guardian_df = pd.DataFrame()
    last_date = str(datetime.date.today())
    print(f"{file_name} will be created.")

























