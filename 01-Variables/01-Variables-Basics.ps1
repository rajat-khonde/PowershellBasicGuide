# PowerShell Variables - Basics
# ==============================================================================
# Variables are containers for storing data values. In PowerShell, all variables
# are prefixed with a dollar sign ($)

# Basic Variable Declaration and Assignment
# ==============================================================================

# String variables
$name = "Rajat Khonde"
$message = 'Welcome to PowerShell'

# Numeric variables
$age = 30
$salary = 50000.50
$count = 10

# Boolean variables
$isActive = $true
$isCompleted = $false

# Date variables
$today = Get-Date
$tomorrow = (Get-Date).AddDays(1)

# Displaying variables
Write-Host "Name: $name"
Write-Host "Age: $age"
Write-Host "Today's Date: $today"


# Variable Naming Conventions
# ==============================================================================

# CamelCase (Recommended)
$userName = "rajat"
$firstName = "Rajat"
$employeeId = 1001

# PascalCase (Also acceptable)
$UserName = "rajat"
$FirstName = "Rajat"

# Avoid spaces and special characters in variable names
# $user name = "rajat"  # This is INVALID


# Variable Types - PowerShell is Dynamically Typed
# ==============================================================================

$var1 = "Hello"      # String
$var2 = 42           # Integer
$var3 = 3.14         # Double
$var4 = $true        # Boolean
$var5 = 1, 2, 3      # Array
$var6 = @{}          # Hashtable

# Check variable type
Write-Host "Type of var1: $($var1.GetType().Name)"
Write-Host "Type of var2: $($var2.GetType().Name)"
Write-Host "Type of var4: $($var4.GetType().Name)"


# Variable Validation and Null/Empty Checks
# ==============================================================================

# Check if variable is empty
if ([string]::IsNullOrEmpty($var1)) {
    Write-Output "$var1 is empty"
} else {
    Write-Output "$var1 is not empty"
}

# Check if variable exists
if (Test-Path variable:\userName) {
    Write-Host "Variable exists"
} else {
    Write-Host "Variable does not exist"
}

# Check if variable is $null
$emptyVar = $null
if ($null -eq $emptyVar) {
    Write-Host "Variable is null"
}


# Special Variables
# ==============================================================================

# $PSVersionTable - PowerShell version information
Write-Host "PowerShell Version: $($PSVersionTable.PSVersion)"

# $PROFILE - Path to PowerShell profile
Write-Host "Profile Path: $PROFILE"

# $PSScriptRoot - Directory of current script
Write-Host "Script Root: $PSScriptRoot"

# $_ - Current object in pipeline
1..5 | ForEach-Object { Write-Host "Current item: $_" }

# $args - Arguments passed to script
# (Can only be used within function or script parameters)

# $? - Last command success status
Get-Item C:\Windows | Out-Null
if ($?) {
    Write-Host "Previous command was successful"
}

# $LASTEXITCODE - Exit code of last native command
# (Useful for error handling with external programs)


# Variable Scope
# ==============================================================================

# Global scope - accessible everywhere
$global:globalVar = "I am global"

# Script scope - accessible within the script
$script:scriptVar = "I am script scoped"

# Local scope - default, accessible only in current scope
$localVar = "I am local"

# Function scope
function TestScope {
    $localVar = "Local to function"
    Write-Host "Inside function: $localVar"
}

TestScope
Write-Host "Outside function: $localVar"


# Removing Variables
# ==============================================================================

# Remove a single variable
$tempVar = "temporary"
Remove-Variable -Name tempVar

# Remove multiple variables
Remove-Variable -Name var1, var2, var3 -ErrorAction SilentlyContinue

# Clear all variables (use with caution!)
# Remove-Variable -Name * -Scope Global


# Best Practices
# ==============================================================================

# 1. Use meaningful variable names
$userEmail = "user@example.com"  # Good
$ue = "user@example.com"         # Avoid

# 2. Use consistent naming convention
$firstName = "Rajat"             # Consistent
$LastName = "Khonde"             # Inconsistent style

# 3. Initialize variables before use
$result = $null
if ($someCondition) {
    $result = "value"
}

# 4. Use explicit types for clarity when needed
[int]$count = 0
[string]$name = "Rajat"
[bool]$isActive = $true

# 5. Document complex variables
# $userData contains user information with properties: Name, Email, Age
$userData = @{
    Name = "Rajat"
    Email = "rajat@example.com"
    Age = 30
}
