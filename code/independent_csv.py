# -*- coding: utf-8 -*-
"""
Independent Scraper

https://www.independent.co.uk/archive/

"""

import os
import requests
from bs4 import BeautifulSoup
from datetime import datetime, timedelta
import pandas as pd

# Set working directory (optional, depending on use case)
os.chdir(os.path.dirname(os.path.abspath(__file__)))

# File path for saving articles (modify as needed)
file_name = "../data/independent_articles.csv"

# Functions:
# -----------

def step_date_backwards(date_str):
    """Move date back by one day."""
    date_obj = datetime.strptime(date_str, '%Y-%m-%d')
    return (date_obj - timedelta(days=1)).strftime('%Y-%m-%d')


def fetch_independent_data(date):
    """Fetch articles for a specific date."""
    url = f'https://www.independent.co.uk/archive/{date}'
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
    }
    response = requests.get(url, headers=headers)

    if response.status_code != 200:
        print(f"Failed to fetch {date}: {response.status_code}")
        return []

    soup = BeautifulSoup(response.text, 'html.parser')
    articles = []

    # Look for all <li> elements matching the article structure
    for li in soup.find_all('li', {'class': 'sc-9rjm6m-3 hbOjMw'}):
        link_tag = li.find('a', {'class': 'sc-9rjm6m-4 jeyBnT'})

        if not link_tag:
            continue

        title = link_tag.get_text(strip=True)
        href = link_tag['href']
        full_url = f'https://www.independent.co.uk{href}'

        articles.append({
            'title': title,
            'url': full_url,
            'date': date
        })

    if not articles:
        print(f"No articles found for {date}.")
    return articles




# File Setup:
#------------


# check if csv already exists
if os.path.exists(file_name):
    Independent_df = pd.read_csv(file_name)
    last_date = str(Independent_df['date'].iloc[-1])
else:
    Independent_df = pd.DataFrame(columns=['title', 'url', 'date'])
    # last_date = datetime.today().strftime('%Y-%m-%d')
    last_date = '2024-11-01'
    print(f"{file_name} will be created.")





# get user input on how many days to search for
try:
    n=int(input('How many Days worth of Articles?\n'))

except: 
    print('Please enter an Integer!')
    try:
        n=int(input('How many Days worth of Articles?\n'))

    except: 
        raise SystemExit('Idiot...')







# Processing Loop:
#-----------------


# step date backwards
date = step_date_backwards(last_date)

# collect data
for i in range(n):
    Independent_data = fetch_independent_data(date)
    if not Independent_data:
        print(f"No data for {date}.")
        date = step_date_backwards(date)
        continue

    # update DataFrame
    update_Independent_df = pd.DataFrame(Independent_data)
    Independent_df = pd.concat([Independent_df, update_Independent_df], 
                              ignore_index=True)
    Independent_df.drop_duplicates(subset='title', keep='last', inplace=True)

    # update user
    print(f"Added {len(update_Independent_df)} new articles for {date}")
    date = step_date_backwards(date)
    print(f"Completed: {len(Independent_df['date'].unique())} / 365")





# Save to CSV:
#-------------


Independent_df.to_csv(file_name, index=False)

print(f"Scraping complete. Updated {file_name}.")

