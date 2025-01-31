#!/bin/bash

HASH_FILE="log_hashes.json"

# function to compute the SHA-256 hash of a file
compute_hash() {
    sha256sum "$1" | awk '{print $1}'
}

# function to store hashes in the JSON file
store_hashes() {
    echo "Storing hashes..."
    declare -A file_hashes
    for log_file in "$@"; do
        file_hashes["$log_file"]=$(compute_hash "$log_file")
    done
    echo "{$(for key in "${!file_hashes[@]}"; do echo "\"$key\": \"${file_hashes[$key]}\","; done | sed 's/,$//')}" > "$HASH_FILE"
}

# function to load stored hashes from the JSON file
load_stored_hashes() {
    if [[ ! -f "$HASH_FILE" ]]; then
        echo "{}"
    else
        cat "$HASH_FILE"
    fi
}

# function to check the integrity of the log files
check_integrity() {
    stored_hashes=$(load_stored_hashes)
    tampered_files=()
    declare -A computed_hashes

    for log_file in "$@"; do
        computed_hash=$(compute_hash "$log_file")
        computed_hashes["$log_file"]=$computed_hash

        stored_hash=$(echo "$stored_hashes" | jq -r ".[\"$log_file\"]")

        if [[ "$stored_hash" != "$computed_hash" ]]; then
            tampered_files+=("$log_file")
        fi
    done

    if [ ${#tampered_files[@]} -gt 0 ]; then
        echo "Possible tampering detected in the following log files:"
        for tampered in "${tampered_files[@]}"; do
            echo "$tampered"
        done
    else
        echo "All log files are intact."
    fi
}

# function to manually re-initialize the log integrity check
reinitialize_integrity() {
    echo "Enter the path to the log file or directory:"
    read log_path
    if [[ -d "$log_path" ]]; then
        find "$log_path" -type f -name "*.log" > log_files.txt
        store_hashes $(cat log_files.txt)
    else
        store_hashes "$log_path"
    fi
    echo "Integrity checks have been reinitialized."
}

# main program execution
echo "Do you want to (1) Check integrity or (2) Reinitialize integrity?"
read action

case $action in
    1)
        echo "Enter the log file or directory path to check:"
        read log_path
        if [[ -d "$log_path" ]]; then
            find "$log_path" -type f -name "*.log" > log_files.txt
            check_integrity $(cat log_files.txt)
        else
            check_integrity "$log_path"
        fi
        ;;
    2)
        reinitialize_integrity
        ;;
    *)
        echo "Invalid action."
        ;;
esac
