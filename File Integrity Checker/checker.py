import hashlib
import os
import json
from pathlib import Path

# Path to store previously computed hashes (JSON file)
HASH_STORE_PATH = 'log_hashes.json'

# Helper function to compute SHA-256 hash of a file
def compute_file_hash(file_path):
    sha256 = hashlib.sha256()
    with open(file_path, 'rb') as f:
        while chunk := f.read(8192):
            sha256.update(chunk)
    return sha256.hexdigest()

# Function to load previously stored hashes
def load_stored_hashes():
    if Path(HASH_STORE_PATH).exists():
        with open(HASH_STORE_PATH, 'r') as file:
            return json.load(file)
    return {}

# Function to save computed hashes to a file
def save_computed_hashes(hashes):
    with open(HASH_STORE_PATH, 'w') as file:
        json.dump(hashes, file, indent=4)

# Function to check log file integrity
def check_log_integrity(log_path):
    if os.path.isdir(log_path):
        log_files = [os.path.join(root, file) for root, _, files in os.walk(log_path) for file in files if file.endswith('.log')]
    else:
        log_files = [log_path]

    stored_hashes = load_stored_hashes()
    computed_hashes = {}
    tampered_files = []

    for log_file in log_files:
        file_hash = compute_file_hash(log_file)
        computed_hashes[log_file] = file_hash

        # Check for discrepancies
        if log_file in stored_hashes:
            if stored_hashes[log_file] != file_hash:
                tampered_files.append(log_file)

    # If discrepancies are found
    if tampered_files:
        print("Possible tampering detected in the following log files:")
        for file in tampered_files:
            print(file)
    else:
        print("All log files are intact.")

    # Save the computed hashes for future checks
    save_computed_hashes(computed_hashes)

# Manual re-initialization function
def reinitialize_log_integrity():
    log_path = input("Enter the log file or directory to reinitialize integrity checks: ")
    check_log_integrity(log_path)

# Main function to execute the tool
def main():
    action = input("Do you want to (1) Check integrity or (2) Reinitialize integrity: ")

    if action == '1':
        log_path = input("Enter the log file or directory path to check: ")
        check_log_integrity(log_path)
    elif action == '2':
        reinitialize_log_integrity()
    else:
        print("Invalid action.")

if __name__ == "__main__":
    main()
