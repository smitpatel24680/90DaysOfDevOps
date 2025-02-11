#!/bin/bash

# This script creates a backup of a directory in rotation, keeping only 3 most recent backups
directory_path=$1
backup_dir="/home/ubuntu/backups"  # Changed to a separate backup directory

# Function to create backups with timestamp
function rotational_backup {
    if [ -d "$directory_path" ]; then
        echo "Directory path exists"
        
        # Create backup directory if it doesn't exist
        mkdir -p "$backup_dir"
        
        # Find all backups that match the naming pattern in the backup directory
        backup_files=$(find "$backup_dir" -type f -name "backup_*.tar.gz" | sort)
        backup_count=$(echo "$backup_files" | wc -w)
        
        # First execution: Create 3 backups if none exist
        if [ "$backup_count" -eq 0 ]; then
            echo "No backups yet. Creating the first 3 backups..."
            for i in {1..3}; do
                new_backup="$backup_dir/$(date +"backup_%Y-%m-%d_%H-%M-%S").tar.gz"
                tar --exclude="$backup_dir" -czf "$new_backup" "$directory_path"
                echo "Backup created: $new_backup"
                sleep 1 # Adding a slight delay to generate different timestamps
            done
        else
            # If there are 3 or more backups, remove the oldest one
            if [ "$backup_count" -ge 3 ]; then
                oldest_backup=$(echo "$backup_files" | head -n 1)
                rm "$oldest_backup"
                echo "Deleted the oldest backup: $oldest_backup"
            fi
            
            # Create the new backup with a timestamp
            new_backup="$backup_dir/$(date +"backup_%Y-%m-%d_%H-%M-%S").tar.gz"
            tar --exclude="$backup_dir" -czf "$new_backup" "$directory_path"
            echo "Backup created: $new_backup"
        fi
    else
        echo "Invalid path"
        exit 1
    fi
}

# Check if directory path is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

rotational_backup
