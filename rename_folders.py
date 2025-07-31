#!/usr/bin/env python3
"""
Script to rename folders with special characters to ASCII equivalents
Run this script from the assets/App-data directory
"""

import os
import shutil

def rename_folders():
    """Rename folders with special characters to ASCII equivalents"""
    
    # Define the mapping of special characters to ASCII
    folder_mapping = {
        'Hörtexte': 'Hoertexte',
        'Übungsaudios': 'Uebungsaudios'
    }
    
    # Get current directory
    current_dir = os.getcwd()
    print(f"Current directory: {current_dir}")
    
    # Check if we're in the right directory
    if not os.path.exists('Lektion 1'):
        print("Error: Please run this script from the assets/App-data directory")
        return
    
    # Process each lesson folder
    for i in range(1, 21):
        lesson_folder = f'Lektion {i}'
        if os.path.exists(lesson_folder):
            print(f"\nProcessing {lesson_folder}...")
            
            # Rename folders within each lesson
            for old_name, new_name in folder_mapping.items():
                old_path = os.path.join(lesson_folder, old_name)
                new_path = os.path.join(lesson_folder, new_name)
                
                if os.path.exists(old_path):
                    try:
                        shutil.move(old_path, new_path)
                        print(f"  Renamed '{old_name}' to '{new_name}'")
                    except Exception as e:
                        print(f"  Error renaming '{old_name}': {e}")
                else:
                    print(f"  Folder '{old_name}' not found in {lesson_folder}")
    
    print("\nFolder renaming completed!")

if __name__ == "__main__":
    rename_folders() 