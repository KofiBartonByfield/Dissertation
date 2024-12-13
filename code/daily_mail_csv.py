# -*- coding: utf-8 -*-
"""
Daily Mail Scraper

https://www.dailymail.co.uk/home/sitemaparchive/index.html

"""

import os
import requests
from bs4 import BeautifulSoup
import pandas as pd
from datetime import datetime, timedelta

# set wd
os.chdir(os.path.dirname(os.path.abspath(__file__)))



file_name = "../data/daily_mail_articles.csv"




# Functions:
#-----------

def step_date_backwards(date_str):
    """Move date back by one day."""
    date_obj = datetime.strptime(date_str, '%Y%m%d')
    return (date_obj - timedelta(days=1)).strftime('%Y%m%d')

def fetch_daily_mail_data(date):
    """Fetch articles for a specific date."""
    url = f'https://www.dailymail.co.uk/home/sitemaparchive/day_{date}.html'
    response = requests.get(url)
    
    if response.status_code != 200:
        print(f"Failed to fetch {date}: {response.status_code}")
        return []
    
    soup = BeautifulSoup(response.text, 'html.parser')
    ul = soup.find('ul', {'class': 'archive-articles debate link-box'})
    if not ul:
        print(f"No articles found for {date}.")
        return []
    
    articles = ul.find_all('li')
    return [{'title': article.find('a').get_text(),
             'url': 'https://www.dailymail.co.uk' + article.find('a')['href'],
             'date': date} for article in articles if article.find('a')]



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
    Daily_Mail_df = pd.read_csv(file_name)
    last_date = str(Daily_Mail_df['date'].iloc[-1])
else:
    Daily_Mail_df = pd.DataFrame(columns=['title', 'url', 'date'])
    last_date = datetime.today().strftime('%Y%m%d')
    print(f"{file_name} will be created.")



# Processing Loop:
#-----------------


# step date backwards
date = step_date_backwards(last_date)

# collect data
for i in range(n):
    daily_mail_data = fetch_daily_mail_data(date)
    if not daily_mail_data:
        print(f"No data for {date}.")
        date = step_date_backwards(date)
        continue

    # update DataFrame
    update_Daily_Mail_df = pd.DataFrame(daily_mail_data)
    Daily_Mail_df = pd.concat([Daily_Mail_df, update_Daily_Mail_df], 
                              ignore_index=True)
    Daily_Mail_df.drop_duplicates(subset='title', keep='last', inplace=True)

    # update user
    print(f"Added {len(update_Daily_Mail_df)} new articles for {date}")
    date = step_date_backwards(date)
    print(f"Completed: {len(Daily_Mail_df['date'].unique())} / 365")



# Save to CSV:
#-------------

#test
Daily_Mail_df.to_csv(file_name, index=False)

print(f"Scraping complete. Updated {file_name}.")





