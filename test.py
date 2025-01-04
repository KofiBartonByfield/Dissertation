import pandas as pd
import os

os.chdir(os.path.dirname(os.path.abspath(__file__)))


# List of file paths for the articles
file_paths = os.listdir('data/headlines')


# Keywords related to knife crime
keywords = ['knife', 'stabbing', 'murder', 'kill', 'killed', 'injured', 'stab', 'injuries']

# Function to check for keyword matches
def crime_related(text):
    text = str(text).lower()  # Convert to lowercase
    return any(keyword in text for keyword in keywords)  # Check if any keyword exists in the text




crime_data = pd.DataFrame()

for file in file_paths:
    
    file_path = f"data/headlines/{file}"
    data = pd.read_csv(file_path)


    data['crime_related'] = data['title'].apply(crime_related)
    
    
    temp_crime_data = data[data['crime_related']]
    
    crime_data = pd.concat([crime_data, temp_crime_data], ignore_index=True)


