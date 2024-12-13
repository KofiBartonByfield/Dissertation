"""
Guardian Scraper

https://open-platform.theguardian.com/

"""




import requests
import datetime
import re
import pandas as pd
import os
import math


API_KEY = os.getenv("GUARDIAN_API_KEY")
file_name = "../data/guardian_articles.csv"
url = "https://content.guardianapis.com/search"
articles = []



if API_KEY:
    print("API Key Loaded Successfully")
else:
    print("API Key Not Found")
    
# set wd
os.chdir(os.path.dirname(os.path.abspath(__file__)))




# check if csv already exists
if os.path.exists(file_name):
    Guardian_df = pd.read_csv(file_name)
    last_date = Guardian_df['webPublicationDate'].str[:10].iloc[-1]
else:
    Guardian_df = pd.DataFrame()
    last_date = str(datetime.date.today())
    print(f"{file_name} will be created.")


params = {
       "to-date": last_date,  # end date
        "api-key": API_KEY,  # Guardian API key
        "section": "uk-news",  # filter for UK news
        "page-size": 200,  # number of results
        "page": 1  # page number 
    }



# get user input on how many days to search for
try:
    k=int(input('How many Articles?\n'))

except: 
    print('Please enter an Integer!')
    try:
        k=int(input('How many Articles?\n'))

    except: 
        raise SystemExit('Idiot...')

n = math.ceil(k/200)



def scrape_data(last_date):
    
    params = {
           "to-date": last_date,  # end date
            "api-key": API_KEY,  # Guardian API key
            "section": "uk-news",  # filter for UK news
            "page-size": 200,  # number of results
            "page": 1  # page number 
        }

    response = requests.get(url, params=params)
    Gardian_data = response.json()
    
    for result in Gardian_data["response"]["results"]:
        # Append all relevant fields to the articles list
        articles.append({
            
            "webPublicationDate": result.get("webPublicationDate"),
            "webTitle": result.get("webTitle"),
            "webUrl": result.get("webUrl"),
         
        })
        
    return articles









n

for _ in range(n):

    guardian_data = scrape_data(last_date)


    
    # update DataFrame
    update_Gardian_df= pd.DataFrame(guardian_data)
    
    Guardian_df = pd.concat([Guardian_df, update_Gardian_df], 
                              ignore_index=True)
    Guardian_df.drop_duplicates(subset='title', keep='last', inplace=True)
    
    
    last_date = step_date_backwards(last_date)

    # update user
    print(f"Added {len(update_Gardian_df)} new articles for {last_date}")


# Save to CSV:
#-------------

#test
Guardian_df.to_csv(file_name, index=False)

print(f"Scraping complete. Updated {file_name}.")

















