# -*- coding: utf-8 -*-
"""
Daily Express Scraper

https://www.express.co.uk/sitearchive

"""

import os
import requests
from bs4 import BeautifulSoup
import pandas as pd
from datetime import datetime, timedelta

# set wd
os.chdir(os.path.dirname(os.path.abspath(__file__)))



file_name = "../../data/daily_express_articles.csv"




# Functions:
#-----------

def step_date_backwards(date_str):
    """Move date back by one day."""
    date_obj = datetime.strptime(date_str, '%Y/%m/%d')
    return (date_obj - timedelta(days=1)).strftime('%Y/%m/%d')

def fetch_daily_express_data(date):
    """Fetch articles for a specific date."""
    url = f'https://www.express.co.uk/sitearchive/{date}'
    response = requests.get(url)
    
    if response.status_code != 200:
        print(f"Failed to fetch {date}: {response.status_code}")
        return []
    
    soup = BeautifulSoup(response.text, 'html.parser')
    ul = soup.find('ul', {'class': 'section-list'})
    if not ul:
        print(f"No articles found for {date}.")
        return []
    
    articles = ul.find_all('li')
    return [{'title': article.find('a').get_text(),
             'url': 'https://www.express.co.uk/' + article.find('a')['href'],
             'date': date,
              'source': 'Daily Express'} for article in articles if article.find('a')]



# File Setup:
#------------

# get user input on how many days to search for
try:
    n=int(input('How many Days worth of Articles?\n'))

except: 
    print('Please enter an Integer!')
    try:
        n=int(input('How many Days worth of Articles?\n'))

    except: 
        raise SystemExit('Idiot...')



# check if csv already exists
if os.path.exists(file_name):
    Daily_Express_df = pd.read_csv(file_name)
    last_date = str(Daily_Express_df['date'].iloc[-1])
else:
    Daily_Express_df = pd.DataFrame(columns=['title', 'url', 'date'])
    last_date = datetime.today().strftime('%Y/%m/%d')
    print(f"{file_name} will be created.")



# Processing Loop:
#-----------------


# step date backwards
date = step_date_backwards(last_date)

# collect data
for i in range(n):
    daily_express_data = fetch_daily_express_data(date)
    if not daily_express_data:
        print(f"No data for {date}.")
        date = step_date_backwards(date)
        continue

    # update DataFrame
    update_Daily_Express_df = pd.DataFrame(daily_express_data)
    Daily_Express_df = pd.concat([Daily_Express_df, update_Daily_Express_df], 
                              ignore_index=True)
    Daily_Express_df.drop_duplicates(subset='title', keep='last', inplace=True)

    # update user
    print(f"Added {len(update_Daily_Express_df)} new articles for {date}")
    date = step_date_backwards(date)
    print(f"Completed: {len(Daily_Express_df['date'].unique())} / 365")



# Save to CSV:
#-------------


Daily_Express_df.to_csv(file_name, index=False)

print(f"Scraping complete. Updated {file_name}.")





