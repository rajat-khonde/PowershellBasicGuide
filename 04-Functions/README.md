# PowerShell Functions Guide

## Overview
Functions are reusable blocks of code that perform specific tasks. They help organize code, improve maintainability, and enable code reuse throughout your scripts.

## Files in This Section

### 01-Functions-Basics.ps1
Complete guide to creating and using PowerShell functions:
- Function declaration and basic structure
- Parameters and arguments
- Mandatory vs optional parameters
- Parameter types and validation
- Return values (explicit and implicit)
- Comment-based help documentation
- Function scope and variables
- Switch parameters
- Splatting for parameter passing
- Real-world practical examples

**Key Concepts:**
- Functions promote code reuse and maintainability
- Parameters make functions flexible and reusable
- Always validate input parameters
- Use comment-based help for documentation
- Return appropriate data types (objects, not strings)
- Understand function scope for proper variable access

## Quick Reference

### Basic Function
```powershell
function Get-Welcome {
    Write-Host "Welcome to PowerShell!"
}

Get-Welcome
```

### Function with Parameters
```powershell
function Get-UserInfo {
    param(
        [Parameter(Mandatory=$true)]
        [string]$UserName,
        
        [Parameter(Mandatory=$false)]
        [string]$Department = "Unknown"
    )
    
    Write-Host "User: $UserName"
    Write-Host "Department: $Department"
}

Get-UserInfo -UserName "Rajat" -Department "DevOps"
```

### Function with Return Value
```powershell
function Calculate-Sum {
    param([int]$A, [int]$B)
    
    $sum = $A + $B
    return $sum
}

$result = Calculate-Sum -A 10 -B 20
```

### Function with Parameter Validation
```powershell
function Set-Level {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateRange(1, 100)]
        [int]$Level
    )
    
    Write-Host "Level set to $Level"
}

Set-Level -Level 50  # Valid
# Set-Level -Level 150  # Invalid - exceeds range
```

### Comment-Based Help
```powershell
<#
.SYNOPSIS
Brief description of what function does

.DESCRIPTION
Detailed description of functionality

.PARAMETER ParameterName
Description of parameter

.EXAMPLE
Get-MyFunction -Parameter "Value"
Description of output

.NOTES
Additional information
#>
function Get-MyFunction {
    param([string]$Parameter)
}
```

## Parameter Types and Validation

| Validation | Example | Purpose |
|-----------|---------|---------|
| Mandatory | `[Parameter(Mandatory=$true)]` | Requires parameter |
| Default | `[string]$Name = "Default"` | Provides default value |
| ValidateRange | `[ValidateRange(1, 100)]` | Limits numeric range |
| ValidateLength | `[ValidateLength(3, 50)]` | Limits string length |
| ValidateNotNull | `[ValidateNotNull()]` | Prevents null values |
| ValidateSet | `[ValidateSet("Yes", "No")]` | Limits to specific values |

## Function Patterns

### Pattern 1: Perform Action
```powershell
function Restart-Service {
    param([string]$ServiceName)
    
    Stop-Service -Name $ServiceName
    Start-Service -Name $ServiceName
    Write-Host "Service restarted: $ServiceName"
}
```

### Pattern 2: Retrieve and Return Data
```powershell
function Get-UserCount {
    param([string]$Department)
    
    $count = Get-User -Department $Department | Measure-Object | Select-Object -ExpandProperty Count
    return $count
}
```

### Pattern 3: Validate and Process
```powershell
function Process-UserData {
    param([object]$Data)
    
    if ($null -eq $Data) { throw "Data cannot be null" }
    if ($Data.Count -eq 0) { return "No data to process" }
    
    # Process data
    return $processedData
}
```

### Pattern 4: Configuration Access
```powershell
function Get-Config {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Key,
        [string]$DefaultValue = "Not Set"
    )
    
    $config = @{ Server = "localhost"; Port = 8080 }
    
    return if ($config.ContainsKey($Key)) { $config[$Key] } else { $DefaultValue }
}
```

## Best Practices

1. **Use Descriptive Names** - Follow Verb-Noun convention
   ```powershell
   ✅ Get-UserInfo        # Clear what it does
   ❌ ProcessUser         # Vague
   ```

2. **Document with Comment-Based Help**
   ```powershell
   <#
   .SYNOPSIS
   Gets user information
   #>
   function Get-UserInfo { }
   ```

3. **Validate Parameters**
   ```powershell
   param(
       [Parameter(Mandatory=$true)]
       [ValidateNotNullOrEmpty()]
       [string]$UserName
   )
   ```

4. **Return Objects, Not Strings**
   ```powershell
   # Good
   $user = @{ Name = $name; Age = $age }
   return $user
   
   # Avoid
   return "Name: $name, Age: $age"
   ```

5. **Use Consistent Parameter Names**
   ```powershell
   ✅ Standard: -Name, -Path, -Filter, -Force
   ❌ Avoid: -N, -P, -F, -Frce
   ```

6. **Default to Sensible Values**
   ```powershell
   param(
       [int]$Timeout = 30,
       [string]$LogLevel = "Info"
   )
   ```

## Common Mistakes to Avoid

- ❌ Not validating mandatory parameters
- ❌ Returning strings instead of objects
- ❌ Hardcoding values in functions
- ❌ Poor parameter naming
- ❌ Missing help documentation
- ❌ Not handling errors in functions

## Advanced Patterns

### Splatting
```powershell
$params = @{
    Name = "Service"
    Force = $true
}

Restart-Service @params
```

### Array Parameters
```powershell
param([string[]]$Items)

foreach ($item in $Items) {
    Write-Host "Processing: $item"
}
```

### Switch Parameters
```powershell
param([switch]$Verbose)

if ($Verbose) {
    Write-Host "Detailed information..."
}
```

## Learning Path

1. Start with **01-Functions-Basics.ps1** to learn fundamentals
2. Practice writing simple functions
3. Add parameter validation and error handling
4. Document functions with comment-based help
5. Create reusable function libraries

## Related Topics

- **Variables** - Variable scope in functions
- **Control Flow** - Conditional logic within functions
- **Error Handling** - Try-Catch in function bodies
- **Data Structures** - Returning complex objects

