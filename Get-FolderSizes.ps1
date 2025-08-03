# Define the root directory
$RootPath = "E:\121"

# Define the output CSV file location
$OutputCsv = "E:\FolderSizesReport.csv"

# Get all subfolders in the specified directory
$Folders = Get-ChildItem -Path $RootPath -Directory

# Create an array to store results
$Results = @()

foreach ($Folder in $Folders) {
    # Calculate folder size (sum of all files inside)
    $SizeBytes = (Get-ChildItem -Path $Folder.FullName -Recurse -File -ErrorAction SilentlyContinue | 
                  Measure-Object -Property Length -Sum).Sum
    
    # Convert size to GB (2 decimal points)
    $SizeGB = [Math]::Round(($SizeBytes / 1GB), 2)
    
    # Add result to array
    $Results += [PSCustomObject]@{
        FolderName = $Folder.Name
        FullPath   = $Folder.FullName
        SizeGB     = $SizeGB
    }
}

# Export the results to CSV
$Results | Export-Csv -Path $OutputCsv -NoTypeInformation -Encoding UTF8

Write-Host "Folder size report generated at $OutputCsv"