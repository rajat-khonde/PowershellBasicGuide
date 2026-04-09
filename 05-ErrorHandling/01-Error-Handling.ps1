# PowerShell Error Handling - Try-Catch-Finally
# ==============================================================================
# Error handling allows you to gracefully manage exceptions and failures.
# Use Try-Catch-Finally blocks to handle errors and cleanup resources.

# Basic Try-Catch
# ==============================================================================

# Simple Try-Catch block
try {
    Write-Host "Attempting to access a file..."
    Get-Item "C:\nonexistent.txt" -ErrorAction Stop
    Write-Host "File found!"
} catch {
    Write-Host "Error caught: File does not exist"
    Write-Host "Error details: $_"
}


# Try-Catch with Specific Exception
# ==============================================================================

# Catching specific exception type
try {
    Write-Host "Attempting file operation..."
    Get-Item "C:\invalid_path\file.txt" -ErrorAction Stop
} catch [System.IO.FileNotFoundException] {
    Write-Host "Specific error: File not found"
} catch [System.IO.DirectoryNotFoundException] {
    Write-Host "Specific error: Directory not found"
} catch {
    Write-Host "Generic error: An unexpected error occurred"
    Write-Host "Error: $_"
}


# Try-Catch-Finally
# ==============================================================================

# Finally block always executes, regardless of success or failure
try {
    Write-Host "Starting operation..."
    Write-Host "Processing data..."
    # Simulate an error
    throw "Processing failed"
} catch {
    Write-Host "Error occurred: $_"
} finally {
    Write-Host "Cleanup: This block always runs"
    Write-Host "Releasing resources..."
}


# Error Object Properties
# ==============================================================================

# Accessing error object properties
try {
    $array = @(1, 2, 3)
    $value = $array[10]  # Index out of range
} catch {
    Write-Host "Error Information:"
    Write-Host "  Exception: $($_.Exception.Message)"
    Write-Host "  Category: $($_.CategoryInfo.Category)"
    Write-Host "  Line: $($_.InvocationInfo.ScriptLineNumber)"
    Write-Host "  Command: $($_.InvocationInfo.MyCommand.Name)"
    Write-Host "  Script: $($_.InvocationInfo.ScriptName)"
}


# ErrorAction Preference
# ==============================================================================

# ErrorAction = Stop (converts error to terminating)
try {
    Write-Host "Using -ErrorAction Stop..."
    Get-Item "C:\nonexistent.txt" -ErrorAction Stop
    Write-Host "This won't execute"
} catch {
    Write-Host "Caught with Stop: $_"
}

# ErrorAction = SilentlyContinue (suppress error)
Write-Host "`nUsing -ErrorAction SilentlyContinue..."
$result = Get-Item "C:\nonexistent.txt" -ErrorAction SilentlyContinue
if ($null -eq $result) {
    Write-Host "File not found, but no error shown"
}

# ErrorAction = Continue (default, shows error but continues)
Write-Host "`nUsing -ErrorAction Continue..."
Get-Item "C:\nonexistent.txt" -ErrorAction Continue
Write-Host "Script continues despite error"


# Custom Error Messages
# ==============================================================================

# Throwing custom errors
function Test-NumberRange {
    param(
        [int]$Number
    )
    
    try {
        if ($Number -lt 0) {
            throw "Number cannot be negative: $Number"
        }
        
        if ($Number -gt 100) {
            throw "Number cannot exceed 100: $Number"
        }
        
        Write-Host "Number is valid: $Number"
    } catch {
        Write-Host "Validation error: $_"
    }
}

Test-NumberRange -Number 50
Test-NumberRange -Number -10
Test-NumberRange -Number 150


# Multiple Catch Blocks
# ==============================================================================

# Handling different error types differently
try {
    Write-Host "Performing multiple operations..."
    
    # Simulate different error types
    $action = "division"
    
    switch ($action) {
        "division" {
            $result = 10 / 0  # Will cause error
        }
        "nullref" {
            $obj = $null
            $obj.Property = "value"
        }
        "indexer" {
            $arr = @(1, 2, 3)
            $arr[10]
        }
    }
} catch [System.DivideByZeroException] {
    Write-Host "Math error: Cannot divide by zero"
} catch [System.NullReferenceException] {
    Write-Host "Reference error: Object is null"
} catch [System.IndexOutOfRangeException] {
    Write-Host "Index error: Array index out of range"
} catch {
    Write-Host "Unknown error: $_"
}


# Using Finally for Cleanup
# ==============================================================================

# Finally block for resource cleanup
function Test-FileOperation {
    param(
        [string]$FilePath
    )
    
    $file = $null
    
    try {
        Write-Host "Opening file: $FilePath"
        $file = [System.IO.File]::Open($FilePath, [System.IO.FileMode]::Open)
        Write-Host "File opened successfully"
        
        # Simulate error
        throw "Error during processing"
    } catch {
        Write-Host "Error: $_"
    } finally {
        if ($file) {
            Write-Host "Closing file resource..."
            $file.Close()
        } else {
            Write-Host "File was not opened"
        }
    }
}

# Test with valid file
Test-FileOperation -FilePath "C:\Windows\notepad.exe"


# Nested Try-Catch
# ==============================================================================

# Nested error handling
try {
    Write-Host "Outer try block"
    
    try {
        Write-Host "Inner try block"
        throw "Inner error"
    } catch {
        Write-Host "Inner catch: $_"
        throw "Rethrowing error to outer block"
    }
} catch {
    Write-Host "Outer catch: $_"
}


# Error Recording and Logging
# ==============================================================================

# Capturing errors for logging
$errors = @()

function Process-Data {
    param(
        [string[]]$Items
    )
    
    global:$errors = @()
    
    foreach ($item in $Items) {
        try {
            Write-Host "Processing: $item"
            
            if ($item -eq "error") {
                throw "Invalid item: $item"
            }
            
            Write-Host "  ✓ Success"
        } catch {
            Write-Host "  ✗ Failed: $_"
            $global:errors += @{
                Item = $item
                Error = $_
                Time = Get-Date
            }
        }
    }
}

Process-Data -Items "item1", "error", "item2", "item3"

Write-Host "`nError Summary:"
if ($errors.Count -gt 0) {
    foreach ($err in $errors) {
        Write-Host "  - $($err.Item): $($err.Error)"
    }
} else {
    Write-Host "  No errors recorded"
}


# Retry Logic with Error Handling
# ==============================================================================

# Function with automatic retry on error
function Get-DataWithRetry {
    param(
        [int]$MaxRetries = 3,
        [int]$DelaySeconds = 1
    )
    
    $attempt = 0
    $success = $false
    
    while ($attempt -lt $MaxRetries -and -not $success) {
        $attempt++
        
        try {
            Write-Host "Attempt $attempt of $MaxRetries..."
            
            # Simulate random failure
            $random = Get-Random -Minimum 1 -Maximum 5
            if ($random -eq 1) {
                throw "Connection timeout"
            }
            
            Write-Host "  ✓ Success! Data retrieved"
            $success = $true
            return "Data retrieved successfully"
        } catch {
            Write-Host "  ✗ Failed: $_"
            
            if ($attempt -lt $MaxRetries) {
                Write-Host "  Retrying in $DelaySeconds seconds..."
                Start-Sleep -Seconds $DelaySeconds
            } else {
                Write-Host "  Max retries reached"
                throw $_
            }
        }
    }
}

try {
    $result = Get-DataWithRetry -MaxRetries 3 -DelaySeconds 1
    Write-Host "Final result: $result"
} catch {
    Write-Host "Operation failed after all retries: $_"
}


# Error Action Preference at Script Level
# ==============================================================================

# Setting error action for entire function
function Strict-Processing {
    $ErrorActionPreference = "Stop"
    
    try {
        Write-Host "Processing with strict error handling..."
        Get-Item "C:\nonexistent.txt"
        Write-Host "This won't execute"
    } catch {
        Write-Host "Error caught: $_"
    }
}

Strict-Processing


# Validation Before Operations
# ==============================================================================

# Prevent errors through validation
function Safe-DivideNumbers {
    param(
        [double]$Numerator,
        [double]$Denominator
    )
    
    try {
        if ($null -eq $Numerator -or $null -eq $Denominator) {
            throw "Parameters cannot be null"
        }
        
        if ($Denominator -eq 0) {
            throw "Denominator cannot be zero"
        }
        
        $result = $Numerator / $Denominator
        Write-Host "Result: $Numerator / $Denominator = $result"
        return $result
    } catch {
        Write-Host "Error: $_"
        return $null
    }
}

Safe-DivideNumbers -Numerator 10 -Denominator 2
Safe-DivideNumbers -Numerator 10 -Denominator 0
Safe-DivideNumbers -Numerator $null -Denominator 2


# Practical Real-World Examples
# ==============================================================================

# Example 1: Safe file read
function Read-ConfigFile {
    param(
        [Parameter(Mandatory=$true)]
        [string]$FilePath
    )
    
    try {
        if (-not (Test-Path $FilePath)) {
            throw "Configuration file not found: $FilePath"
        }
        
        $content = Get-Content $FilePath -ErrorAction Stop
        Write-Host "Config loaded successfully"
        return $content
    } catch {
        Write-Host "Failed to load config: $_"
        Write-Host "Using default configuration..."
        return $null
    }
}

Read-ConfigFile -FilePath "C:\config\app.config"


# Example 2: Safe API call with timeout
function Get-DataFromAPI {
    param(
        [string]$URL,
        [int]$TimeoutSeconds = 10
    )
    
    try {
        Write-Host "Calling API: $URL"
        
        # Simulate API call
        $result = "API Response Data"
        
        Write-Host "API call successful"
        return $result
    } catch {
        Write-Host "API call failed: $_"
        return $null
    }
}

Get-DataFromAPI -URL "https://api.example.com/data"


# Example 3: Database operation with rollback
function Update-Database {
    param(
        [string]$Query
    )
    
    try {
        Write-Host "Starting transaction..."
        Write-Host "Executing query: $Query"
        
        # Simulate database operation
        if ($Query -like "*DELETE*") {
            throw "Delete operation not permitted"
        }
        
        Write-Host "Query executed successfully"
        Write-Host "Committing transaction..."
    } catch {
        Write-Host "Error occurred: $_"
        Write-Host "Rolling back transaction..."
    }
}

Update-Database -Query "UPDATE users SET active = 1"
Update-Database -Query "DELETE FROM users WHERE id = 1"


# Best Practices Summary
# ==============================================================================

# ✅ Always use -ErrorAction Stop for critical operations
# ✅ Catch specific exceptions before generic ones
# ✅ Use Finally for guaranteed cleanup
# ✅ Log errors for debugging
# ✅ Provide meaningful error messages
# ✅ Validate input before processing
# ✅ Implement retry logic for transient failures
# ✅ Don't swallow errors - handle or rethrow appropriately
