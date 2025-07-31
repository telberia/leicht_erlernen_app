# PowerShell script to rename folders with special characters
# Run this script from the project root directory

Write-Host "Starting folder renaming process..." -ForegroundColor Green

# Define the mapping of special characters to ASCII
$folderMapping = @{
    'Hörtexte' = 'Hoertexte'
    'Übungsaudios' = 'Uebungsaudios'
}

# Get the assets directory path
$assetsPath = "assets\App-data"
$fullPath = Join-Path $PSScriptRoot $assetsPath

Write-Host "Assets path: $fullPath" -ForegroundColor Yellow

# Check if the assets directory exists
if (-not (Test-Path $fullPath)) {
    Write-Host "Error: Assets directory not found at $fullPath" -ForegroundColor Red
    exit 1
}

# Process each lesson folder
for ($i = 1; $i -le 20; $i++) {
    $lessonFolder = "Lektion $i"
    $lessonPath = Join-Path $fullPath $lessonFolder
    
    if (Test-Path $lessonPath) {
        Write-Host "Processing $lessonFolder..." -ForegroundColor Cyan
        
        # Rename folders within each lesson
        foreach ($oldName in $folderMapping.Keys) {
            $newName = $folderMapping[$oldName]
            $oldPath = Join-Path $lessonPath $oldName
            $newPath = Join-Path $lessonPath $newName
            
            if (Test-Path $oldPath) {
                try {
                    Rename-Item -Path $oldPath -NewName $newName -Force
                    Write-Host "  Renamed '$oldName' to '$newName'" -ForegroundColor Green
                }
                catch {
                    Write-Host "  Error renaming '$oldName': $($_.Exception.Message)" -ForegroundColor Red
                }
            }
            else {
                Write-Host "  Folder '$oldName' not found in $lessonFolder" -ForegroundColor Yellow
            }
        }
    }
    else {
        Write-Host "Lesson folder $lessonFolder not found" -ForegroundColor Yellow
    }
}

Write-Host "`nFolder renaming completed!" -ForegroundColor Green
Write-Host "Press any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") 