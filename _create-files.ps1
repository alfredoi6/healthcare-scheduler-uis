# Define the root directory for the monorepo
$rootDir = Get-Location

# Navigate to the root directory
Set-Location -Path $rootDir

# Initialize Yarn Workspaces by running `yarn init`
Write-Host "Initializing Yarn Workspaces..."
yarn init -y

# Install Turborepo
Write-Host "Installing Turborepo..."
yarn add turbo --dev

# Initialize Next.js (web app)
Write-Host "Initializing Next.js web app..."
cd "$rootDir\apps\web"
yarn create next-app .

# Install required dependencies for the web app
Write-Host "Installing dependencies for Next.js..."
yarn add axios react-query

# Install Jest, ESLint, and Prettier for the web app
Write-Host "Installing Jest, ESLint, and Prettier for Next.js..."
yarn add --dev jest eslint prettier eslint-plugin-react eslint-plugin-react-hooks eslint-config-prettier jest-environment-jsdom

# Initialize Expo (mobile app)
Write-Host "Initializing Expo mobile app..."
cd "$rootDir\apps\mobile"
yarn global add expo-cli
expo init .

# Install required dependencies for the mobile app
Write-Host "Installing dependencies for Expo..."
cd "$rootDir\apps\mobile"
yarn add axios react-query

# Install Jest, ESLint, and Prettier for the mobile app
Write-Host "Installing Jest, ESLint, and Prettier for Expo..."
yarn add --dev jest eslint prettier eslint-plugin-react eslint-plugin-react-hooks eslint-config-prettier jest-expo

# Initialize shared packages (shared-api and shared-ui)
Write-Host "Initializing shared API and UI packages..."

# Initialize shared-api package
cd "$rootDir\packages\shared-api"
yarn init -y
yarn add axios

# Initialize shared-ui package (optional, if you plan to use shared components/UI)
cd "$rootDir\packages\shared-ui"
yarn init -y

# Initialize ESLint and Prettier shared configs in /packages
Write-Host "Setting up shared ESLint and Prettier configs..."

# Shared ESLint config in packages
@"
{
  "extends": [
    "eslint:recommended",
    "plugin:react/recommended",
    "prettier"
  ],
  "parserOptions": {
    "ecmaVersion": 2020,
    "sourceType": "module"
  },
  "plugins": [
    "react"
  ],
  "env": {
    "browser": true,
    "node": true,
    "jest": true
  }
}
"@ | Out-File -FilePath "$rootDir\packages\shared-api\.eslintrc.json" -Force
@"
{
  "singleQuote": true,
  "trailingComma": "es5",
  "printWidth": 80,
  "semi": true
}
"@ | Out-File -FilePath "$rootDir\packages\shared-api\.prettierrc" -Force

# Create an alias for Jest in the shared package
@"
module.exports = {
  preset: 'jest-expo',
};
"@ | Out-File -FilePath "$rootDir\packages\shared-api\jest.config.js" -Force

# Output completion message
Write-Host "App infrastructure initialized successfully with Turborepo, Yarn Workspaces, Next.js, Expo, Axios, React Query, Jest, ESLint, and Prettier."
