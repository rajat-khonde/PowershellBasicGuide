# PowerShell Conditionals - If, Else, Else If, Switch
# ==============================================================================

# If Statement
# ==============================================================================

# Basic If statement
$age = 25

if ($age -ge 18) {
    Write-Host "You are an adult"
}

# If-Else statement
$temperature = 15

if ($temperature -gt 20) {
    Write-Host "It's warm"
} else {
    Write-Host "It's cold"
}

# If-Else If-Else statement
$score = 75

if ($score -ge 90) {
    Write-Host "Grade: A"
} elseif ($score -ge 80) {
    Write-Host "Grade: B"
} elseif ($score -ge 70) {
    Write-Host "Grade: C"
} else {
    Write-Host "Grade: F"
}


# Comparison Operators
# ==============================================================================

$x = 10
$y = 20

# Numeric comparisons
if ($x -eq $y) { Write-Host "Equal" }
if ($x -ne $y) { Write-Host "Not equal" }           # True
if ($x -lt $y) { Write-Host "Less than" }          # True
if ($x -le $y) { Write-Host "Less than or equal" } # True
if ($x -gt $y) { Write-Host "Greater than" }
if ($x -ge $y) { Write-Host "Greater than or equal" }

# String comparisons
$name1 = "Rajat"
$name2 = "rajat"

if ($name1 -eq $name2) { Write-Host "Strings equal (case-insensitive by default)" }
if ($name1 -ceq $name2) { Write-Host "Strings equal (case-sensitive)" }
if ($name1 -ine $name2) { Write-Host "Strings not equal (case-insensitive)" }
if ($name1 -cne $name2) { Write-Host "Strings not equal (case-sensitive)" } # True


# Logical Operators
# ==============================================================================

$age = 25
$income = 50000

# AND operator (-and)
if ($age -ge 18 -and $income -ge 30000) {
    Write-Host "Eligible for loan"
}

# OR operator (-or)
$isWeekend = $true
$isHoliday = $false

if ($isWeekend -or $isHoliday) {
    Write-Host "No work today"
}

# NOT operator (-not)
$isActive = $false

if (-not $isActive) {
    Write-Host "User is inactive"
}

# Combining conditions
$status = "Active"
$role = "Admin"

if (($status -eq "Active") -and (($role -eq "Admin") -or ($role -eq "Supervisor"))) {
    Write-Host "Access granted"
}


# String Operators
# ==============================================================================

$text = "PowerShell"

# -like (wildcard matching)
if ($text -like "Power*") {
    Write-Host "Starts with 'Power'"
}

if ($text -like "*Shell") {
    Write-Host "Ends with 'Shell'"
}

# -match (regex matching)
$email = "rajat@example.com"

if ($email -match "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$") {
    Write-Host "Valid email format"
}

# -contains (checks if array contains value)
$fruits = @("Apple", "Banana", "Orange")

if ($fruits -contains "Apple") {
    Write-Host "Array contains Apple"
}

# -in (checks if value is in collection)
if ("Banana" -in $fruits) {
    Write-Host "Banana is in the array"
}


# Null and Empty Checks
# ==============================================================================

$var = $null

if ($var -eq $null) {
    Write-Host "Variable is null"
}

if (-not $var) {
    Write-Host "Variable is null or empty"
}

$empty = ""

if ([string]::IsNullOrEmpty($empty)) {
    Write-Host "String is null or empty"
}

$whitespace = "   "

if ([string]::IsNullOrWhiteSpace($whitespace)) {
    Write-Host "String is null or whitespace"
}


# Switch Statement
# ==============================================================================

# Basic switch statement
$day = "Monday"

switch ($day) {
    "Monday" {
        Write-Host "Start of work week"
    }
    "Friday" {
        Write-Host "Almost weekend"
    }
    "Saturday" {
        Write-Host "Weekend day"
    }
    "Sunday" {
        Write-Host "Weekend day"
    }
    default {
        Write-Host "Midweek day"
    }
}

# Switch with multiple values (case fall-through)
$role = "Developer"

switch ($role) {
    "Admin" {
        Write-Host "Full system access"
        break
    }
    "Manager" {
        Write-Host "Department access"
        break
    }
    "Developer" {
        Write-Host "Code repository access"
        break
    }
    "User" {
        Write-Host "Limited access"
        break
    }
    default {
        Write-Host "Unknown role"
    }
}

# Switch with regex matching
$status = "Error: Database connection failed"

switch -Regex ($status) {
    "^Error" {
        Write-Host "This is an error"
    }
    "^Warning" {
        Write-Host "This is a warning"
    }
    "^Success" {
        Write-Host "Operation successful"
    }
}

# Switch with wildcard matching
$filename = "report.pdf"

switch -Wildcard ($filename) {
    "*.txt" {
        Write-Host "Text file"
    }
    "*.pdf" {
        Write-Host "PDF file"
    }
    "*.xlsx" {
        Write-Host "Excel file"
    }
    default {
        Write-Host "Unknown file type"
    }
}


# Ternary Operator (PowerShell 7+)
# ==============================================================================

# Using if-else as expression
$age = 20
$status = if ($age -ge 18) { "Adult" } else { "Minor" }
Write-Host "Status: $status"

# Using ternary operator syntax (PowerShell 7+)
# $status = $age -ge 18 ? "Adult" : "Minor"
# Write-Host "Status: $status"


# Practical Examples
# ==============================================================================

# Example 1: Validate user input
$userInput = "hello"

if ([string]::IsNullOrEmpty($userInput)) {
    Write-Host "Error: Input cannot be empty"
} elseif ($userInput.Length -lt 3) {
    Write-Host "Error: Input must be at least 3 characters"
} else {
    Write-Host "Input is valid: $userInput"
}

# Example 2: File operation check
$filePath = "C:\temp\data.txt"

if (Test-Path $filePath) {
    Write-Host "File exists"
    $file = Get-Item $filePath
    if ($file.Length -gt 1MB) {
        Write-Host "File is large"
    } else {
        Write-Host "File is small"
    }
} else {
    Write-Host "File does not exist"
}

# Example 3: Permission checking
$username = "Rajat"
$role = "Admin"
$action = "DeleteDatabase"

if ($role -eq "Admin") {
    Write-Host "Access granted for $action"
} elseif ($role -eq "Manager" -and $action -eq "ViewReports") {
    Write-Host "Access granted for $action"
} else {
    Write-Host "Access denied"
}

# Example 4: Number range validation
$number = 42

if ($number -lt 0) {
    Write-Host "Negative number"
} elseif ($number -eq 0) {
    Write-Host "Zero"
} elseif ($number -gt 0 -and $number -le 10) {
    Write-Host "Single digit"
} elseif ($number -gt 10 -and $number -le 100) {
    Write-Host "Two digit number"
} else {
    Write-Host "Large number"
}
