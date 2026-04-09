# PowerShell Data Structures Guide

## Overview
Data structures allow you to organize and store multiple related values. PowerShell provides two primary data structures: Arrays and Hashtables.

## Files in This Section

### 01-Arrays.ps1
Comprehensive guide to PowerShell arrays:
- Creating arrays using various methods (@(), ranges, implicit)
- Accessing array elements (indexing, negative indexing, slicing)
- Array properties and methods (Count, Length, Contains, etc.)
- Adding and removing elements
- Iterating through arrays (foreach, for, pipeline)
- Sorting and filtering arrays
- Multi-dimensional arrays
- Performance considerations with ArrayList

**Key Concepts:**
- Arrays are zero-indexed collections
- Arrays are fixed-size in PowerShell (additions create new arrays)
- Use ArrayList for better performance with frequent additions
- Pipeline operations (Where-Object, ForEach-Object) are powerful

### 02-Hashtables.ps1
Complete guide to PowerShell hashtables:
- Creating hashtables (@{} syntax)
- Accessing values using dot notation and bracket notation
- Adding, updating, and removing entries
- Checking for key/value existence
- Iterating through hashtables
- Nested hashtables for complex data structures
- Ordered hashtables for maintaining insertion order
- Converting hashtables and parameter splatting

**Key Concepts:**
- Hashtables are key-value pair collections (like dictionaries)
- Keys provide fast access to values
- Use ordered @{} for predictable iteration order
- Hashtables enable flexible function parameter usage through splatting

## Quick Reference

### Arrays
```powershell
# Create
$arr = @(1, 2, 3)
$arr = 1, 2, 3
$arr = @()  # empty

# Access
$arr[0]      # First element
$arr[-1]     # Last element
$arr[1..3]   # Range

# Add
$arr += 4
$arr += @(5, 6)

# Iterate
$arr | ForEach-Object { $_ }
foreach ($item in $arr) { $item }

# Filter
$arr | Where-Object { $_ -gt 2 }

# Sort
$arr | Sort-Object
$arr | Sort-Object -Descending
```

### Hashtables
```powershell
# Create
$hash = @{ Name = "Rajat"; Age = 30 }
$hash = @{}  # empty

# Access
$hash.Name          # Dot notation
$hash['Name']       # Bracket notation

# Add
$hash['Email'] = "rajat@example.com"
$hash.Country = "India"

# Check
$hash.ContainsKey('Name')
$hash.ContainsValue('Rajat')

# Iterate
foreach ($entry in $hash.GetEnumerator()) {
    $entry.Key
    $entry.Value
}

# Remove
$hash.Remove('Email')
```

## Arrays vs Hashtables

| Feature | Array | Hashtable |
|---------|-------|-----------|
| Data Type | Ordered collection | Key-value pairs |
| Access | By index (0-based) | By key |
| Use Case | Sequential data | Associative data |
| Performance | Good for iteration | Fast lookups |
| Size | Fixed (create new for add) | Dynamic |

## Best Practices

### Arrays
1. **Check Count Before Access**
   ```powershell
   if ($arr.Count -gt 0) {
       $first = $arr[0]
   }
   ```

2. **Use @() for Empty Arrays**
   ```powershell
   $items = @()  # Clear intent
   ```

3. **Use ArrayList for Frequent Additions**
   ```powershell
   [System.Collections.ArrayList]$list = @()
   $list.Add($item) | Out-Null
   ```

4. **Use Pipeline for Filtering**
   ```powershell
   $filtered = $array | Where-Object { $_ -gt 5 }
   ```

### Hashtables
1. **Use Ordered Hashtables When Order Matters**
   ```powershell
   $ordered = [ordered]@{ First = 1; Second = 2 }
   ```

2. **Check Keys Before Access**
   ```powershell
   if ($hash.ContainsKey('property')) {
       $value = $hash['property']
   }
   ```

3. **Use Hashtables for Function Splatting**
   ```powershell
   $params = @{ Path = "C:\"; Recurse = $true }
   Get-ChildItem @params
   ```

4. **Document Complex Structures**
   ```powershell
   # $config contains app settings:
   # - Server: database server hostname
   # - Port: connection port
   # - Database: database name
   $config = @{ Server = "localhost"; Port = 5432 }
   ```

## Common Patterns

### Array Filtering and Transformation
```powershell
# Filter
$even = $numbers | Where-Object { $_ % 2 -eq 0 }

# Transform
$doubled = $numbers | ForEach-Object { $_ * 2 }

# Combine
$result = $numbers | 
    Where-Object { $_ -gt 5 } | 
    ForEach-Object { $_ * 2 } | 
    Sort-Object -Descending
```

### Hashtable for Configuration
```powershell
$appConfig = @{
    AppName = "MyApp"
    Database = @{
        Host = "localhost"
        Port = 5432
    }
    Logging = @{
        Level = "Info"
        Path = "C:\Logs"
    }
}

# Access nested
$dbHost = $appConfig.Database.Host
```

## Learning Path

1. Start with **01-Arrays.ps1** for understanding ordered collections
2. Progress to **02-Hashtables.ps1** for key-value storage
3. Practice combining both structures in real scripts
4. Learn when to use each structure for optimal solutions

## Related Topics

- **Variables** - Basic data containers
- **Control Flow** - Using arrays/hashtables in loops and conditionals
- **Functions** - Passing collections as parameters
