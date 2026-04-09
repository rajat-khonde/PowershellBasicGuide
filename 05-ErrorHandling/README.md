# PowerShell Error Handling Guide

## Overview
Error handling allows you to gracefully manage exceptions and failures in your scripts. PowerShell provides Try-Catch-Finally blocks and error action preferences for robust error handling.

## Files in This Section

### 01-Error-Handling.ps1
Complete guide to exception and error handling in PowerShell:
- Basic Try-Catch block structure
- Catching specific exception types
- Try-Catch-Finally blocks
- Error object properties and information
- ErrorAction preferences (Stop, Continue, SilentlyContinue)
- Custom error messages with throw
- Multiple catch blocks for different errors
- Finally blocks for resource cleanup
- Nested try-catch handling
- Error recording and logging
- Retry logic with exponential backoff
- Validation before operations
- Real-world practical examples

**Key Concepts:**
- Always use -ErrorAction Stop for critical operations
- Catch specific exceptions before generic ones
- Use Finally for guaranteed cleanup
- Validate input to prevent errors proactively
- Implement retry logic for transient failures
- Log errors for debugging and troubleshooting

## Quick Reference

### Basic Try-Catch
```powershell
try {
    # Code that might fail
    Get-Item "C:\nonexistent.txt" -ErrorAction Stop
} catch {
    Write-Host "Error: $_"
}
```

### Specific Exception Handling
```powershell
try {
    Get-Item $path -ErrorAction Stop
} catch [System.IO.FileNotFoundException] {
    Write-Host "File not found: $path"
} catch [System.IO.DirectoryNotFoundException] {
    Write-Host "Directory not found"
} catch {
    Write-Host "Other error: $_"
}
```

### Try-Catch-Finally
```powershell
try {
    # Risky operation
} catch {
    # Handle error
} finally {
    # Always executes (cleanup)
    Write-Host "Cleanup code here"
}
```

### Error Action Preferences
```powershell
-ErrorAction Stop              # Convert error to terminating
-ErrorAction Continue          # Show error but continue (default)
-ErrorAction SilentlyContinue  # Suppress error silently
-ErrorAction Inquire           # Ask user what to do
```

### Custom Error with Throw
```powershell
if ($number -lt 0) {
    throw "Number cannot be negative: $number"
}
```

### Error Object Properties
```powershell
$_.Exception.Message           # Error message
$_.CategoryInfo.Category       # Error category
$_.InvocationInfo.ScriptLineNumber  # Line number
$_.FullyQualifiedErrorId       # Error ID
```

## Error Handling Patterns

### Pattern 1: Validate Then Execute
```powershell
function Safe-Operation {
    param([string]$Path)
    
    # Validate first
    if ([string]::IsNullOrEmpty($Path)) {
        throw "Path cannot be empty"
    }
    
    if (-not (Test-Path $Path)) {
        throw "Path does not exist: $Path"
    }
    
    # Then execute
    Get-Item $Path
}
```

### Pattern 2: Retry with Backoff
```powershell
function Get-DataWithRetry {
    param(
        [int]$MaxRetries = 3,
        [int]$DelaySeconds = 2
    )
    
    for ($attempt = 1; $attempt -le $MaxRetries; $attempt++) {
        try {
            # Attempt operation
            return "Success"
        } catch {
            if ($attempt -eq $MaxRetries) { throw }
            Start-Sleep -Seconds $DelaySeconds
        }
    }
}
```

### Pattern 3: Cleanup with Finally
```powershell
$file = $null
try {
    $file = [System.IO.File]::Open($path, [System.IO.FileMode]::Read)
    # Use file
} catch {
    Write-Host "Error: $_"
} finally {
    if ($file) { $file.Close() }
}
```

### Pattern 4: Error Logging
```powershell
function Log-Error {
    param([string]$Message)
    
    $errorLog = "C:\logs\error.log"
    $logEntry = "$(Get-Date): $Message"
    Add-Content -Path $errorLog -Value $logEntry
}

try {
    # Operation
} catch {
    Log-Error -Message $_
}
```

## ErrorAction vs Try-Catch

| Method | Use Case | Pros | Cons |
|--------|----------|------|------|
| -ErrorAction Stop | Critical operations | Explicit, converts non-terminating to terminating | More verbose |
| Try-Catch | Specific handling | Fine-grained control, handles exceptions | More code |
| -ErrorAction Continue | Non-critical | Minimal code | Less control |
| -ErrorAction SilentlyContinue | Optional operations | Clean output | Can hide issues |

## Best Practices

1. **Use -ErrorAction Stop for Critical Operations**
   ```powershell
   ✅ Get-Item $path -ErrorAction Stop
   ❌ Get-Item $path  # Might not catch error
   ```

2. **Catch Specific Exceptions First**
   ```powershell
   ✅ Specific [System.IO.FileNotFoundException]
   ✅ Then generic catch
   
   ❌ Generic catch block alone
   ```

3. **Always Use Finally for Resources**
   ```powershell
   try {
       $file = Open-File
   } finally {
       Close-File $file  # Always runs
   }
   ```

4. **Validate Before Operations**
   ```powershell
   ✅ Prevent errors through validation
   ❌ Don't rely solely on error handling
   
   # Good
   if (Test-Path $path) { Get-Item $path }
   ```

5. **Log Errors for Debugging**
   ```powershell
   catch {
       Write-Host "Error: $_"
       Add-Content $logPath "$(Get-Date): $_"
   }
   ```

6. **Provide Context in Error Messages**
   ```powershell
   catch {
       throw "Failed to process user $userId at line $($_.InvocationInfo.ScriptLineNumber): $_"
   }
   ```

## Common Mistakes to Avoid

- ❌ Swallowing errors silently without logging
  ```powershell
  # Bad
  Get-Item $path -ErrorAction SilentlyContinue | Out-Null
  ```

- ❌ Catching generic Exception instead of specific types
  ```powershell
  # Bad
  catch [Exception] { }
  
  # Better
  catch [System.IO.FileNotFoundException] { }
  ```

- ❌ Not cleaning up resources in Finally
  ```powershell
  # Bad
  $file.Close()  # Might not run if error occurs
  
  # Good
  finally { $file.Close() }
  ```

- ❌ Ignoring validation and relying on error handling
  ```powershell
  # Bad - reactive
  try { $value.Length } catch { }
  
  # Good - proactive
  if ($null -ne $value) { $value.Length }
  ```

- ❌ Not providing error context
  ```powershell
  # Bad
  catch { Write-Host "Error" }
  
  # Good
  catch { Write-Host "Error processing file $path: $_" }
  ```

## Exception Types

Common PowerShell exceptions:

| Exception | Cause | Example |
|-----------|-------|---------|
| FileNotFoundException | File doesn't exist | Get-Item "nonexistent.txt" |
| DirectoryNotFoundException | Directory doesn't exist | Get-ChildItem "C:\invalid\" |
| UnauthorizedAccessException | Access denied | Get-Item restricted_file.txt |
| ArgumentNullException | Null argument passed | Process-Data $null |
| InvalidOperationException | Invalid operation | Division by zero |
| ItemNotFoundException | Item not found in collection | $arr[100] out of bounds |

## Learning Path

1. Start with **01-Error-Handling.ps1** to learn fundamentals
2. Understand Try-Catch-Finally structure
3. Learn different error action preferences
4. Practice handling specific exceptions
5. Implement retry logic and logging
6. Create robust error handling patterns

## Related Topics

- **Functions** - Error handling in function bodies
- **Control Flow** - Logic flow with error handling
- **Variables** - Using error objects and properties
- **Validation** - Preventing errors proactively
