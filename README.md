# Get-FolderSizes
Here’s a **PowerShell script** that analyzes all subfolders inside a given directory (like `E:\121`), calculates their sizes in **gigabytes**, and exports the results to a **CSV file**.

You can copy and save this as `Get-FolderSizes.ps1` and run it in PowerShell.

```powershell
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
```

---

### 🔹 How It Works:

1. Scans all **folders** inside `E:\121`.
2. Calculates **total folder size** (including subfolders and files).
3. Converts the size to **GB** and rounds to **2 decimals**.
4. Exports results to a **CSV file** with columns:
   `FolderName | FullPath | SizeGB`.
5. CSV will be saved as `E:\FolderSizesReport.csv`.

---

If you want, I can **modify this script** so it also **includes the root folder size** and not just subfolders.
Do you want that version?
