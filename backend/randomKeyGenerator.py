import random
import string
import time

def generate_activation_key(length=18):
    # Define the character set (uppercase, lowercase, and digits)
    characters = string.ascii_letters + string.digits
    
    # Generate a random string of the specified length
    random_part = ''.join(random.choices(characters, k=length - 13))  # Reserve 13 characters for timestamp
    timestamp_part = str(int(time.time() * 1000))[-13:]  # Get the last 5 digits of the current timestamp in ms
    return random_part + timestamp_part

# Generate a specified number of unique activation keys
def generate_unique_activation_keys(num_keys):
    activation_keys = set()  # Use a set to store unique keys
    while len(activation_keys) < num_keys:
        key = generate_activation_key()
        activation_keys.add(key)
    return activation_keys

# Example usage
if __name__ == "__main__":
    num_keys_to_generate = 10  # Set the number of activation keys to generate
    unique_keys = generate_unique_activation_keys(num_keys_to_generate)
    print(unique_keys)
