# PowerShell Variable Validation and Advanced Checking
# ==============================================================================

# Checking if Variables are Empty or Null
# ==============================================================================

# Method 1: Using [string]::IsNullOrEmpty()
$var1 = "Hello"
$var2 = ""
$var3 = $null

if ([string]::IsNullOrEmpty($var1)) {
    Write-Output "$var1 is empty or null"
} else {
    Write-Output "$var1 has a value: $var1"
}

if ([string]::IsNullOrEmpty($var2)) {
    Write-Output "$var2 is empty"
}

if ([string]::IsNullOrEmpty($var3)) {
    Write-Output "$var3 is null"
}


# Method 2: Using -eq comparison
if ($var1 -eq $null) {
    Write-Output "var1 is null"
}

if ($var1 -eq "") {
    Write-Output "var1 is empty string"
}

# Method 3: Using -not operator
if (-not $var1) {
    Write-Output "var1 is empty/null/false"
}

if ($var1) {
    Write-Output "var1 has a truthy value"
}


# Checking if Variable Exists
# ==============================================================================

# Using Test-Path with variable provider
if (Test-Path variable:\var1) {
    Write-Host "Variable var1 exists"
} else {
    Write-Host "Variable var1 does not exist"
}

# Using Get-Variable
if (Get-Variable -Name var1 -ErrorAction SilentlyContinue) {
    Write-Host "Variable var1 exists"
}


# Type Checking and Validation
# ==============================================================================

# Check if variable is of specific type
$number = 42
$text = "Hello"
$boolValue = $true

if ($number -is [int]) {
    Write-Host "number is an integer"
}

if ($text -is [string]) {
    Write-Host "text is a string"
}

if ($boolValue -is [bool]) {
    Write-Host "boolValue is a boolean"
}

# Check if variable is NOT of specific type
if ($text -isnot [int]) {
    Write-Host "text is not an integer"
}

# Get actual type information
Write-Host "Type of number: $($number.GetType().FullName)"
Write-Host "Type of text: $($text.GetType().FullName)"


# Validating Collections (Arrays and Hashtables)
# ==============================================================================

# Check if array is empty
$emptyArray = @()
$populatedArray = @(1, 2, 3)

if ($emptyArray.Count -eq 0) {
    Write-Host "emptyArray is empty"
}

if ($populatedArray.Count -gt 0) {
    Write-Host "populatedArray has $($populatedArray.Count) items"
}

# Check if hashtable is empty
$emptyHash = @{}
$populatedHash = @{ Name = "Rajat"; Age = 30 }

if ($emptyHash.Count -eq 0) {
    Write-Host "emptyHash is empty"
}

if ($populatedHash.Count -gt 0) {
    Write-Host "populatedHash has $($populatedHash.Count) items"
}

# Check if key exists in hashtable
if ($populatedHash.ContainsKey("Name")) {
    Write-Host "Name key exists in hashtable"
}

if (-not $populatedHash.ContainsKey("Email")) {
    Write-Host "Email key does not exist in hashtable"
}


# Validating Numeric Values
# ==============================================================================

$age = 30

# Check if numeric
if ($age -is [int] -or $age -is [double]) {
    Write-Host "$age is a numeric value"
}

# Check if within range
if ($age -ge 18 -and $age -le 65) {
    Write-Host "$age is within working age range"
}

# Check if greater/less than
if ($age -gt 21) {
    Write-Host "$age is greater than 21"
}


# String Validation
# ==============================================================================

$email = "rajat@example.com"
$password = "MyPassword123!"

# Check string length
if ($email.Length -gt 0) {
    Write-Host "Email has $($email.Length) characters"
}

# Check if string contains specific text
if ($email -like "*@example.com") {
    Write-Host "Email belongs to example.com domain"
}

# Use regex for pattern matching
if ($email -match "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$") {
    Write-Host "Email format is valid"
}

# Check password strength
if ($password.Length -ge 8 -and $password -match "[A-Z]" -and $password -match "[0-9]") {
    Write-Host "Password meets strength requirements"
}


# Safe Variable Access - Try/Catch
# ==============================================================================

try {
    # Access potentially problematic variable
    $result = $undefined_var.Property
    if ($null -eq $result) {
        Write-Host "Result is null"
    }
} catch {
    Write-Host "Error accessing variable: $_"
}


# Default Values and Null Coalescing
# ==============================================================================

# Method 1: Using ternary operator (PowerShell 7+)
$name = $null
$displayName = if ($name) { $name } else { "Guest" }
Write-Host "Welcome, $displayName"

# Method 2: Using -or operator
$userName = $null
$username = $userName -or "DefaultUser"
Write-Host "User: $username"

# Method 3: Using ?? null coalescing (PowerShell 7+)
# $title = $userData.Title ?? "Employee"


# Practical Examples
# ==============================================================================

# Function with parameter validation
function Get-UserInfo {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$UserId,
        
        [Parameter(Mandatory=$false)]
        [string]$Department = "Unknown"
    )
    
    if (-not [string]::IsNullOrWhiteSpace($UserId)) {
        Write-Host "User ID: $UserId"
        Write-Host "Department: $Department"
    }
}

# Safe hashtable access
$user = @{
    Name = "Rajat"
    Age = 30
}

if ($user.ContainsKey("Name")) {
    Write-Host "User Name: $($user['Name'])"
} else {
    Write-Host "Name property not found"
}

# Safe array access
$items = @(1, 2, 3)
$index = 1

if ($index -ge 0 -and $index -lt $items.Count) {
    Write-Host "Item at index $index: $($items[$index])"
} else {
    Write-Host "Index out of range"
}
