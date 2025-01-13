# -*- coding: utf-8 -*-
"""
Combining all the data from the zipped files
"""

import os
import pandas as pd


os.chdir(os.path.dirname(os.path.abspath(__file__)))

path = '../../data/police_zips/unzipped_data'    



# find all csv file paths
csv_names = []
for folder in os.listdir(path):
        
            folder_contents = os.listdir(f'{path}/{folder}')
            
            for file in folder_contents:
                
                if file.endswith('search.csv'):
                    
                    csv_names.append(f'{path}/{folder}/{file}')
        
        


# turn each csv into a pd.df
dataframes = []

for csv in csv_names:
 

    new_df = pd.read_csv(csv)
    
   
    # add new column for name of csv
    new_df['Police_Dept'] = '_'.join(csv.split('-')[3:-3])
    
    # append list
    dataframes.append(new_df)


df = pd.concat(dataframes, ignore_index=True)



# save df to csv
df.to_csv(f'{path[:-13]}stop_and_search_sep14_nov24.csv')

















