# -*- coding: utf-8 -*-
"""
Guardian Scraper

https://open-platform.theguardian.com/

"""




import requests
# from datetime import datetime, timedelta
import pandas as pd
import os
# import datetime
from datetime import datetime



API_KEY = os.getenv("GUARDIAN_API_KEY")
file_name = "../../data/headlines/guardian_articles.csv"
url = "https://content.guardianapis.com/search"
articles = []
end_date = datetime.strptime(str(pd.read_csv('details.csv').iloc[0].Details), '%d/%m/%y').strftime('%Y-%m-%d')



if API_KEY:
    print("API Key Loaded Successfully")
else:
    raise SystemExit('API Key Not Found')
    
# set wd
os.chdir(os.path.dirname(os.path.abspath(__file__)))




# check if csv already exists
if os.path.exists(file_name):
    Guardian_df = pd.read_csv(file_name)
    last_date = Guardian_df['Date'].str[:10].iloc[-1]
else:
    Guardian_df = pd.DataFrame()
    # last_date = str(datetime.date.today())
    last_date = datetime.strptime(str(pd.read_csv('details.csv').iloc[1].Details), 
                                  '%d/%m/%y').strftime('%Y-%m-%d')

    print(f"{file_name} will be created.")


# params = {
#        "to-date": last_date,  # end date
#         "api-key": API_KEY,  # Guardian API key
#         "section": "uk-news",  # filter for UK news
#         "page-size": 200,  # number of results
#         "page": 1  # page number 
#     }



# get user input on how many days to search for
try:
    n=int(input('How many API calls?(less than 500)\n'))

except: 
    print('Please enter an Integer!')
    try:
        n=int(input('How many API calls?\n'))

    except: 
        raise SystemExit('Idiot...')




# Functions:
#-----------

# def step_date_backwards(date_str):
#     """Move date back by one day."""
#     date_obj = datetime.strptime(date_str, '%Y-%m-%d')
#     return (date_obj - timedelta(days=1)).strftime('%Y-%m-%d')



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
            

            "title": result.get("webTitle"),
            "url": result.get("webUrl"),
            "date": result.get("webPublicationDate"),
            'source': 'Guardian',
         
        })
        
    return articles









for _ in range(n):

    guardian_data = scrape_data(last_date)


    
    # update DataFrame
    update_Gardian_df= pd.DataFrame(guardian_data)
    
    Guardian_df = pd.concat([Guardian_df, update_Gardian_df], 
                              ignore_index=True)
    
    Guardian_df.drop_duplicates(subset='Title', keep='last', inplace=True)
    
    


    # update user
    print(f"Added {len(update_Gardian_df)} new articles for {last_date}")


    if last_date == end_date:
        print('End Date Reached')
        break
    else:
        last_date = Guardian_df['Date'].str[:10].iloc[-1]




# Save to CSV:
# -------------

#test
Guardian_df.to_csv(file_name, index=False)

print(f"Scraping complete. Updated {file_name}.")

















