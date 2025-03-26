# 1) Define the root directory for the monorepo (or current folder)
$rootDir = Get-Location

# 2) Define the port you want the mock server to run on
$mockServerPort = 4000  # Change this to your desired port

# 3) Define the 'mockserver' directory path
$mockserverDir = Join-Path $rootDir "mockserver"

# 4) Create the 'mockserver' folder if it doesn't exist
if (-not (Test-Path $mockserverDir)) {
    New-Item -ItemType Directory -Path $mockserverDir | Out-Null
    Write-Host "Created directory: $mockserverDir"
}

# 5) Navigate into the 'mockserver' directory
Set-Location -Path $mockserverDir

# 6) Initialize a new package.json if it doesn't already exist
if (-not (Test-Path (Join-Path $mockserverDir "package.json"))) {
    npm init -y
    Write-Host "Initialized a new package.json in $mockserverDir"
} else {
    Write-Host "package.json already exists in $mockserverDir"
}

# 7) Install json-server as a dev dependency
npm install json-server --save-dev

# 8) Create the db.json file (if it doesn't exist) with sample data
# Adjust the sample data as needed
$dbContent = @"
{
  "users": [
    { "id": 1, "name": "John Doe" },
    { "id": 2, "name": "Jane Smith" }
  ]
}
"@

$dbFile = Join-Path $mockserverDir "db.json"
if (-not (Test-Path $dbFile)) {
    Set-Content -Path $dbFile -Value $dbContent
    Write-Host "Created db.json with sample data in $mockserverDir"
} else {
    Write-Host "db.json already exists in $mockserverDir"
}

# 9) Load the package.json into a PowerShell object
$packageJsonFilePath = Join-Path $mockserverDir "package.json"
$packageJson = Get-Content -Raw -Path $packageJsonFilePath | ConvertFrom-Json

# 10) Ensure "scripts" exists (if not, create it)
if (-not $packageJson.PSObject.Properties.Match('scripts')) {
    Add-Member -InputObject $packageJson -MemberType NoteProperty -Name "scripts" -Value ([pscustomobject]@{}) -Force
}

# 11) Add (or overwrite) the "mock-server" script using Add-Member
#     This avoids direct indexing issues in older PowerShell versions.
Add-Member -InputObject $packageJson.scripts -MemberType NoteProperty -Name "mock-server" `
    -Value ("json-server --watch db.json --port {0}" -f $mockServerPort) -Force

# 12) Convert updated package.json object back to JSON (with enough depth to avoid truncation)
$updatedJson = $packageJson | ConvertTo-Json -Depth 10 -Compress

# 13) Write the modified JSON back to package.json
Set-Content -Path $packageJsonFilePath -Value $updatedJson

Write-Host "`n=== Setup Complete ===`n"
Write-Host "• package.json now includes a 'mock-server' script."
Write-Host "• db.json created (or already exists) in $mockserverDir."
Write-Host "• To start the mock server, run:"
Write-Host "`n  cd $mockserverDir"
Write-Host "  yarn mock-server"
Write-Host "`nThen open http://localhost:$mockServerPort to use the mock API."