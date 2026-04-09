# PowerShell Functions - Basics
# ==============================================================================
# Functions are reusable blocks of code that perform specific tasks.
# They help organize code, improve maintainability, and enable code reuse.

# Basic Function Structure
# ==============================================================================

# Simple function with no parameters
function Get-Welcome {
    Write-Host "Welcome to PowerShell Functions!"
    Write-Host "This demonstrates a basic function"
}

# Call the function
Get-Welcome


# Function with Parameters
# ==============================================================================

# Function with single parameter
function Get-UserGreeting {
    param(
        [string]$Name
    )
    
    Write-Host "Hello, $Name! Welcome to PowerShell."
}

Get-UserGreeting -Name "Rajat"
Get-UserGreeting -Name "Alice"


# Function with Multiple Parameters
# ==============================================================================

# Function with multiple parameters
function Get-PersonInfo {
    param(
        [string]$FirstName,
        [string]$LastName,
        [int]$Age
    )
    
    Write-Host "Person Information:"
    Write-Host "  First Name: $FirstName"
    Write-Host "  Last Name: $LastName"
    Write-Host "  Age: $Age"
}

Get-PersonInfo -FirstName "Rajat" -LastName "Khonde" -Age 30


# Mandatory Parameters
# ==============================================================================

# Function with mandatory parameters
function Get-EmployeeData {
    param(
        [Parameter(Mandatory=$true)]
        [string]$EmployeeId,
        
        [Parameter(Mandatory=$false)]
        [string]$Department = "Unknown"
    )
    
    Write-Host "Employee ID: $EmployeeId"
    Write-Host "Department: $Department"
}

# This requires EmployeeId
Get-EmployeeData -EmployeeId "EMP001" -Department "Engineering"
Get-EmployeeData -EmployeeId "EMP002"  # Department defaults to "Unknown"


# Parameter Types and Validation
# ==============================================================================

# Function with typed parameters and validation
function Add-Numbers {
    param(
        [int]$Number1,
        [int]$Number2
    )
    
    $sum = $Number1 + $Number2
    Write-Host "Sum: $Number1 + $Number2 = $sum"
}

Add-Numbers -Number1 10 -Number2 20


# Function with range validation
function Set-PowerLevel {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateRange(1, 100)]
        [int]$Level
    )
    
    Write-Host "Power Level set to: $Level%"
}

Set-PowerLevel -Level 75
# Set-PowerLevel -Level 150  # This would fail - out of range


# Function with array parameters
function Get-ItemCount {
    param(
        [string[]]$Items
    )
    
    Write-Host "Total items: $($Items.Count)"
    Write-Host "Items:"
    foreach ($item in $Items) {
        Write-Host "  - $item"
    }
}

Get-ItemCount -Items "Apple", "Banana", "Orange"


# Return Values
# ==============================================================================

# Function that returns a value
function Calculate-Total {
    param(
        [int]$Price1,
        [int]$Price2,
        [int]$Price3
    )
    
    $total = $Price1 + $Price2 + $Price3
    return $total
}

$result = Calculate-Total -Price1 100 -Price2 200 -Price3 150
Write-Host "Total Amount: $result"


# Implicit Return (pipeline)
# ==============================================================================

# Function that returns through pipeline
function Get-Squares {
    param(
        [int]$Count
    )
    
    for ($i = 1; $i -le $Count; $i++) {
        $i * $i
    }
}

$squares = Get-Squares -Count 5
Write-Host "Squares: $squares"


# Return Objects
# ==============================================================================

# Function that returns a custom object
function Get-UserObject {
    param(
        [string]$UserName,
        [string]$Email,
        [int]$Age
    )
    
    $user = @{
        UserName = $UserName
        Email = $Email
        Age = $Age
        DateCreated = Get-Date
    }
    
    return $user
}

$userData = Get-UserObject -UserName "rajat" -Email "rajat@example.com" -Age 30
Write-Host "User Info: $($userData | Out-String)"


# Function Scope
# ==============================================================================

# Global scope variable
$global:GlobalVar = "I am global"

function Test-FunctionScope {
    param(
        [string]$Name
    )
    
    # Local scope variable (only in this function)
    $localVar = "Local to function"
    
    # Accessing global variable
    Write-Host "Global: $GlobalVar"
    Write-Host "Local: $localVar"
    Write-Host "Parameter: $Name"
}

Test-FunctionScope -Name "TestFunction"
Write-Host "Outside function - Local not accessible"


# Advanced: Using Splatting
# ==============================================================================

# Function that uses splatted parameters
function Format-Message {
    param(
        [string]$Message,
        [string]$Color = "Green",
        [switch]$Bold = $false
    )
    
    if ($Bold) {
        Write-Host $Message -ForegroundColor $Color -NoNewline
        Write-Host " [BOLD]" -ForegroundColor Yellow
    } else {
        Write-Host $Message -ForegroundColor $Color
    }
}

# Using splatting
$messageParams = @{
    Message = "Important Alert"
    Color = "Red"
    Bold = $true
}

Format-Message @messageParams


# Comment-Based Help
# ==============================================================================

# Function with comment-based help
<#
.SYNOPSIS
Calculates the area of a rectangle

.DESCRIPTION
This function takes width and height as parameters and returns the area

.PARAMETER Width
The width of the rectangle (integer)

.PARAMETER Height
The height of the rectangle (integer)

.EXAMPLE
Get-RectangleArea -Width 5 -Height 10
Returns: 50

.NOTES
Area = Width * Height
#>
function Get-RectangleArea {
    param(
        [Parameter(Mandatory=$true)]
        [int]$Width,
        
        [Parameter(Mandatory=$true)]
        [int]$Height
    )
    
    $area = $Width * $Height
    return $area
}

$rectArea = Get-RectangleArea -Width 5 -Height 10
Write-Host "Rectangle Area: $rectArea square units"


# Function with Switch Parameters
# ==============================================================================

# Function with boolean switch
function Get-SystemInfo {
    param(
        [switch]$Verbose,
        [switch]$Details
    )
    
    Write-Host "System Information:"
    Write-Host "  OS: Windows 10"
    
    if ($Verbose) {
        Write-Host "  [VERBOSE] Retrieving detailed information..."
    }
    
    if ($Details) {
        Write-Host "  Architecture: 64-bit"
        Write-Host "  CPU Cores: 8"
        Write-Host "  RAM: 16 GB"
    }
}

Get-SystemInfo
Write-Host ""
Get-SystemInfo -Verbose -Details


# Practical Examples
# ==============================================================================

# Example 1: File operation function
function Test-FileExists {
    param(
        [Parameter(Mandatory=$true)]
        [string]$FilePath
    )
    
    if (Test-Path $FilePath) {
        $file = Get-Item $FilePath
        Write-Host "File exists: $($file.Name)"
        Write-Host "Size: $($file.Length) bytes"
        Write-Host "Modified: $($file.LastWriteTime)"
        return $true
    } else {
        Write-Host "File not found: $FilePath"
        return $false
    }
}

Test-FileExists -FilePath "C:\Windows\notepad.exe"


# Example 2: Data processing function
function Process-StudentGrades {
    param(
        [string[]]$Grades
    )
    
    if ($Grades.Count -eq 0) {
        Write-Host "No grades provided"
        return $null
    }
    
    [int[]]$numGrades = $Grades | ForEach-Object { [int]$_ }
    $average = ($numGrades | Measure-Object -Average).Average
    $highest = ($numGrades | Measure-Object -Maximum).Maximum
    $lowest = ($numGrades | Measure-Object -Minimum).Minimum
    
    Write-Host "Grade Analysis:"
    Write-Host "  Average: $([Math]::Round($average, 2))"
    Write-Host "  Highest: $highest"
    Write-Host "  Lowest: $lowest"
    
    return $average
}

Process-StudentGrades -Grades 85, 90, 78, 92, 88


# Example 3: Configuration function
function Get-AppConfig {
    param(
        [Parameter(Mandatory=$true)]
        [string]$ConfigKey,
        
        [string]$DefaultValue = "Not Set"
    )
    
    $config = @{
        "AppName" = "MyApplication"
        "Version" = "1.0.0"
        "Environment" = "Development"
        "LogLevel" = "Info"
        "Database" = "SQL Server"
    }
    
    if ($config.ContainsKey($ConfigKey)) {
        return $config[$ConfigKey]
    } else {
        return $DefaultValue
    }
}

Write-Host "App Name: $(Get-AppConfig -ConfigKey 'AppName')"
Write-Host "Version: $(Get-AppConfig -ConfigKey 'Version')"
Write-Host "Timeout: $(Get-AppConfig -ConfigKey 'Timeout' -DefaultValue '30 seconds')"


# Best Practices
# ==============================================================================

# ✅ Good: Clear function with proper parameters and help
<#
.SYNOPSIS
Validates user email format
#>
function Test-EmailFormat {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Email
    )
    
    $emailPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
    
    if ($Email -match $emailPattern) {
        Write-Host "Valid email: $Email"
        return $true
    } else {
        Write-Host "Invalid email: $Email"
        return $false
    }
}

Test-EmailFormat -Email "rajat@example.com"
Test-EmailFormat -Email "invalid-email"


# ✅ Good: Function with parameter validation
function Set-UserProfile {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$UserName,
        
        [Parameter(Mandatory=$true)]
        [ValidateLength(8, 50)]
        [string]$Password
    )
    
    Write-Host "Setting profile for user: $UserName"
    Write-Host "Password set (hidden for security)"
}

Set-UserProfile -UserName "RajatKhonde" -Password "SecurePassword123!"
