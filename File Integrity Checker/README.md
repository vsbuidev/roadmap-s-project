# Log Integrity Verification Tool

## Overview

This tool verifies the integrity of log files by detecting unauthorized modifications using cryptographic hashing (SHA-256). It can be used to enhance security measures by implementing file integrity monitoring to ensure that logs remain unaltered.

## Features

- Accepts a directory or a single log file as input.
- Uses SHA-256 hashing to compute file fingerprints.
- Stores computed hashes securely in a JSON file.
- Compares newly computed hashes with stored values to detect tampering.
- Reports discrepancies if unauthorized changes are detected.
- Allows manual re-initialization of log integrity checks.

## Requirements

- **Bash version** (for shell script execution)
- **jq** (for JSON processing)
- **sha256sum** (for hashing computation)

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/vsbuidev/roadmap-s-project.git
   cd File%20Integrity%20Checker
   ```
2. Ensure `jq` is installed:

3. Make the script executable:
   ```bash
   chmod +x log_integrity.sh
   ```

## Usage

### Check Log File Integrity

```bash
./log_integrity.sh
```

- Choose option `1` when prompted.
- Enter the log file or directory path to verify integrity.

### Reinitialize Log File Integrity

```bash
./log_integrity.sh
```

- Choose option `2` when prompted.
- Enter the log file or directory path to recalculate and store new hashes.

## Example Output

```
Do you want to (1) Check integrity or (2) Reinitialize integrity?
1
Enter the log file or directory path to check: /var/log/
Possible tampering detected in the following log files:
/var/log/security.log
```

## Security Considerations

- Ensure `log_hashes.json` is stored securely with restricted access.
- Regularly monitor the logs for integrity checks.
- Encrypt the hash storage file if higher security is needed.

## Project

This project is part of the vsbuidev's Roadmap projects.
