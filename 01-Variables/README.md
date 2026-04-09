# PowerShell Variables Guide

## Overview
Variables are containers for storing data values in PowerShell. All variables are prefixed with a dollar sign ($).

## Files in This Section

### 01-Variables-Basics.ps1
Covers fundamental variable concepts:
- Variable declaration and assignment
- Different data types (string, integer, boolean, etc.)
- Naming conventions
- Variable scope (global, script, local)
- Special variables ($PSVersionTable, $PROFILE, $_, etc.)
- Removing and clearing variables

**Key Concepts:**
- Variables are dynamically typed in PowerShell
- Use meaningful, consistent naming conventions
- Understand variable scope for proper code organization

### 02-Variable-Validation.ps1
Focuses on checking and validating variables:
- Null and empty string checks
- Type validation
- Collection validation (arrays, hashtables)
- String pattern matching (regex)
- Safe variable access with Try-Catch
- Default values and null coalescing

**Key Concepts:**
- Always validate variables before using them
- Use appropriate methods for different validation scenarios
- Implement proper error handling

## Quick Reference

### Creating Variables
```powershell
$name = "Rajat"        # String
$age = 30              # Integer
$isActive = $true      # Boolean
$today = Get-Date      # Date
$items = @(1, 2, 3)   # Array
```

### Checking Variables
```powershell
# Check if empty
if ([string]::IsNullOrEmpty($var)) { }

# Check if exists
if (Test-Path variable:\varName) { }

# Check type
if ($var -is [string]) { }

# Check if null
if ($null -eq $var) { }
```

### Variable Scope
```powershell
$global:globalVar = "global"    # Global scope
$script:scriptVar = "script"    # Script scope
$localVar = "local"             # Local scope (default)
```

## Best Practices

1. **Use Meaningful Names** - Choose names that describe the variable's purpose
   - ✅ Good: `$employeeCount`, `$isActive`
   - ❌ Avoid: `$ec`, `$ia`

2. **Follow Naming Convention** - Use consistent casing throughout your code
   - Recommended: `$camelCase` for variables
   - Alternative: `$PascalCase`

3. **Initialize Variables** - Set initial values before using them
   ```powershell
   $result = $null
   if ($condition) {
       $result = "value"
   }
   ```

4. **Validate Input** - Always check variables before using them
   ```powershell
   if ([string]::IsNullOrEmpty($userInput)) {
       Write-Error "Input cannot be empty"
       return
   }
   ```

5. **Use Explicit Types** - Add type declarations for clarity when needed
   ```powershell
   [int]$count = 0
   [string]$name = "Rajat"
   ```

## Common Mistakes to Avoid

- ❌ Using undefined variables - leads to null reference errors
- ❌ Not checking for null/empty before accessing properties
- ❌ Mixing variable naming conventions
- ❌ Not understanding variable scope
- ❌ Assuming variable types

## Learning Path

1. Start with **01-Variables-Basics.ps1** to understand variable fundamentals
2. Progress to **02-Variable-Validation.ps1** to learn proper validation techniques
3. Practice creating and validating variables in your own scripts

## Related Topics

- **Data Structures** - Arrays and Hashtables for storing multiple values
- **Control Flow** - Using variables in conditionals and loops
- **Functions** - Variables and parameters in function definitions
