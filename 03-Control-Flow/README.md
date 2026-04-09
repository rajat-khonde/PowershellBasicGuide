# PowerShell Control Flow Guide

## Overview
Control flow statements determine how your code executes. PowerShell provides conditional statements (if/switch) and loops (for, foreach, while) to control program flow.

## Files in This Section

### 01-Conditionals.ps1
Complete guide to decision-making in PowerShell:
- If, Else If, Else statements
- Comparison operators (-eq, -ne, -lt, -gt, -le, -ge)
- Logical operators (-and, -or, -not)
- String operators (-like, -match, -contains, -in)
- Null and empty checks
- Switch statements with various matching modes
- Ternary operators (PowerShell 7+)
- Real-world validation examples

**Key Concepts:**
- PowerShell uses -eq, -ne, etc. (not ==, !=)
- String comparisons are case-insensitive by default
- Use -c prefix for case-sensitive comparisons (-ceq, -cne)
- Switch provides elegant handling of multiple conditions
- Proper null checking prevents runtime errors

### 02-Loops.ps1
Comprehensive guide to iteration:
- ForEach loops (statement form)
- For loops with counters
- While loops with conditions
- Do-While loops (execute first, check condition)
- Do-Until loops (execute first, until condition is true)
- ForEach-Object for pipeline operations
- Break and Continue statements
- Nested loops
- Practical retry and processing examples

**Key Concepts:**
- Choose the right loop type for your scenario
- ForEach for iterating collections
- For when you need index control
- While for condition-based iteration
- Do-While/Do-Until when code must run at least once
- Use Break to exit loops, Continue to skip iterations

## Quick Reference

### Conditionals

```powershell
# If-Else
if ($condition) {
    # code
} elseif ($other) {
    # code
} else {
    # code
}

# Switch
switch ($value) {
    "Option1" { # code; break }
    "Option2" { # code; break }
    default { # code }
}

# Comparison
-eq   # Equal
-ne   # Not equal
-lt   # Less than
-gt   # Greater than
-le   # Less than or equal
-ge   # Greater than or equal

# Logical
-and  # Both conditions true
-or   # At least one true
-not  # Negation

# String
-like     # Wildcard matching
-match    # Regex matching
-contains # Array contains value
-in       # Value in array
```

### Loops

```powershell
# ForEach
foreach ($item in $collection) { }

# For
for ($i = 0; $i -lt 5; $i++) { }

# While
while ($condition) { }

# Do-While
do { } while ($condition)

# Do-Until
do { } until ($condition)

# Pipeline
$items | ForEach-Object { }

# Break & Continue
foreach ($i in 1..10) {
    if ($i -eq 5) { break }      # Exit loop
    if ($i -eq 3) { continue }   # Skip to next
}
```

## Comparison Operators

| Operator | Description | Example |
|----------|-------------|---------|
| -eq | Equal | 5 -eq 5 → $true |
| -ne | Not equal | 5 -ne 3 → $true |
| -lt | Less than | 3 -lt 5 → $true |
| -gt | Greater than | 5 -gt 3 → $true |
| -le | Less than or equal | 5 -le 5 → $true |
| -ge | Greater than or equal | 5 -ge 3 → $true |
| -like | Wildcard match | "Hello" -like "H*" → $true |
| -match | Regex match | "test@email.com" -match ".*@.*" → $true |
| -contains | Array contains | @(1,2,3) -contains 2 → $true |
| -in | Value in array | 2 -in @(1,2,3) → $true |

## Best Practices

### Conditionals
1. **Check for Null/Empty Before Access**
   ```powershell
   if ($var -and $var.Length -gt 0) {
       # Safe to use $var
   }
   ```

2. **Use Logical Operators Effectively**
   ```powershell
   if ($age -ge 18 -and $age -le 65) {
       # Working age
   }
   ```

3. **Prefer Switch for Multiple Conditions**
   ```powershell
   # Better readability than nested if-else
   switch ($status) {
       "Active" { # code }
       "Inactive" { # code }
       default { # code }
   }
   ```

4. **Use Regex for Complex Pattern Matching**
   ```powershell
   if ($email -match "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$") {
       # Valid email format
   }
   ```

### Loops
1. **Use ForEach for Collections**
   ```powershell
   foreach ($item in $items) {
       # Process each item
   }
   ```

2. **Use For When You Need Index**
   ```powershell
   for ($i = 0; $i -lt $items.Count; $i++) {
       Write-Host "[$i] $($items[$i])"
   }
   ```

3. **Use While for Condition-Based Loops**
   ```powershell
   while ($condition) {
       # Process
       # Update condition
   }
   ```

4. **Use Do-While When Code Must Run Once**
   ```powershell
   do {
       $input = Read-Host "Enter value"
   } while ([string]::IsNullOrEmpty($input))
   ```

5. **Avoid Unnecessary Nested Loops**
   ```powershell
   # Less efficient
   foreach ($x in $array1) {
       foreach ($y in $array2) {
           if ($x -eq $y) { $match = $y }
       }
   }
   
   # Better
   $match = $array1 | Where-Object { $_ -in $array2 }
   ```

## Common Patterns

### Input Validation
```powershell
if ([string]::IsNullOrEmpty($input)) {
    Write-Error "Input required"
} elseif ($input.Length -lt 3) {
    Write-Error "Input too short"
} else {
    Write-Host "Valid input: $input"
}
```

### Retry Logic
```powershell
$maxAttempts = 3
$attempt = 0

while ($attempt -lt $maxAttempts) {
    $attempt++
    try {
        # Attempt operation
        $success = $true
    } catch {
        Write-Host "Attempt $attempt failed"
        if ($attempt -lt $maxAttempts) {
            Start-Sleep -Seconds 2
        }
    }
    if ($success) { break }
}
```

### Array Filtering
```powershell
# Get matching items
$filtered = $items | Where-Object { 
    $_.Name -like "*test*" -and $_.Status -eq "Active" 
}
```

## Learning Path

1. Start with **01-Conditionals.ps1** to understand decision-making
2. Progress to **02-Loops.ps1** for iteration techniques
3. Combine both in real-world scripts
4. Practice writing efficient, readable code

## Related Topics

- **Variables** - Using variables in conditions
- **Data Structures** - Arrays and hashtables with loops
- **Functions** - Control flow in function bodies
- **Error Handling** - Try-Catch with control flow
