# Define the root directory for the monorepo
$rootDir = Get-Location

# Create the root directory if it doesn't exist
If (!(Test-Path -Path $rootDir)) {
    New-Item -ItemType Directory -Force -Path $rootDir
}

# Navigate to the root directory
Set-Location -Path $rootDir

# Create the apps, packages, and mockserver directories
New-Item -ItemType Directory -Force -Path "apps/web"
New-Item -ItemType Directory -Force -Path "apps/mobile"
New-Item -ItemType Directory -Force -Path "packages/shared-api"
New-Item -ItemType Directory -Force -Path "packages/shared-ui"
New-Item -ItemType Directory -Force -Path "mockserver/data"

# Create empty files for the mock server
New-Item -ItemType File -Force -Path "mockserver/index.js"
New-Item -ItemType File -Force -Path "mockserver/data/users.json"

# Output completion message
Write-Host "Monorepo setup complete with empty file skeletons."
