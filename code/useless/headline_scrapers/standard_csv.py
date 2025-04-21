# -*- coding: utf-8 -*-
"""
Standard Scraper

https://www.standard.co.uk/archive/

"""

import os
import requests
from bs4 import BeautifulSoup
import pandas as pd
from datetime import datetime, timedelta

# set wd
os.chdir(os.path.dirname(os.path.abspath(__file__)))



file_name = "../../data/headlines/standard_articles.csv"
end_date = datetime.strptime(str(pd.read_csv('details.csv').iloc[0].Details), '%d/%m/%y').strftime('%Y-%m-%d')



# Functions:
#-----------

def step_date_backwards(date_str):
    """Move date back by one day."""
    date_obj = datetime.strptime(date_str, '%Y-%m-%d')
    return (date_obj - timedelta(days=1)).strftime('%Y-%m-%d')

def fetch_standard_data(date):
    """Fetch articles for a specific date."""
    url = f'https://www.standard.co.uk/archive/{date}'
    response = requests.get(url)
    
    if response.status_code != 200:
        print(f"Failed to fetch {date}: {response.status_code}")
        return []
    
    soup = BeautifulSoup(response.text, 'html.parser')
    ul = soup.find('ul')
    if not ul:
        print(f"No articles found for {date}.")
        return []
    
    articles = ul.find_all('li')
    return [{'title': article.find('a').get_text(),
             'url': 'https://www.standard.co.uk/' + article.find('a')['href'],
             'date': date,
              'source': 'Standard'} for article in articles if article.find('a')]







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
    Standard_df = pd.read_csv(file_name)
    date = step_date_backwards(str(Standard_df['date'].iloc[-1]))
else:
    Standard_df = pd.DataFrame()
    # last_date = datetime.today().strftime('%Y-%m-%d')
    date = datetime.strptime(str(pd.read_csv('details.csv').iloc[1].Details), '%d/%m/%y').strftime('%Y-%m-%d')

    print(f"{file_name} will be created.")



# Processing Loop:
#-----------------




# collect data
for i in range(n):
    standard_data = fetch_standard_data(date)
    if not standard_data:
        print(f"No data for {date}.")
        date = step_date_backwards(date)
        continue

    # update DataFrame
    update_Standard_df = pd.DataFrame(standard_data)
    Standard_df = pd.concat([Standard_df, update_Standard_df], 
                              ignore_index=True)
    Standard_df.drop_duplicates(subset='title', keep='last', inplace=True)

    # update user
    print(f"Added {len(update_Standard_df)} new articles for {date}")
   
    
    if date == end_date:
        print('End Date Reached')
        break
    else:
        date = step_date_backwards(date)


# Save to CSV:
#-------------
print(Standard_df)

# Standard_df.to_csv(file_name, index=False)

# print(f"Scraping complete. Updated {file_name}.")





