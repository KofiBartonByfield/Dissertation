import pandas as pd
import os

os.chdir(os.path.dirname(os.path.abspath(__file__)))


# List of file paths for the articles
file_paths = os.listdir('data/headlines')


# Keywords related to knife crime
keywords = ['knife', 'stabbing', 'murder', 'kill']

# Function to check for keyword matches
def is_knife_crime_related(text):
    text = text.lower()  # Convert to lowercase
    return any(keyword in text for keyword in keywords)  # Check if any keyword exists in the text

# Placeholder for consolidated knife crime data
knife_data = pd.DataFrame()

# Loop through file paths and process each file
for file in file_paths:
    
    file_path = f"data/headlines/{file}"
    
    try:
        # Read the data
        data = pd.read_csv(file_path)

        # Apply the function to check for knife crime related titles
        data['knife_crime_related'] = data['title'].apply(is_knife_crime_related)

        # Filter rows where the title is knife crime related
        temp_knife_data = data[data['knife_crime_related']]

        # Append filtered data to the consolidated DataFrame
        knife_data = pd.concat([knife_data, temp_knife_data], ignore_index=True)
    except Exception as e:
        print(f"Error processing file {file_path}: {e}")

# Display the consolidated knife data
print(knife_data)
