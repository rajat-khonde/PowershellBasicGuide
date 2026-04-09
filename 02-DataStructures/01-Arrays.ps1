# PowerShell Arrays
# ==============================================================================
# Arrays are ordered collections of items. They can store multiple values.

# Creating Arrays
# ==============================================================================

# Method 1: Using @() syntax
$emptyArray = @()
$fruits = @("Apple", "Banana", "Orange")
$numbers = @(1, 2, 3, 4, 5)

# Method 2: Using comma operator
$colors = "Red", "Green", "Blue"
$mixed = 1, "Hello", $true, 3.14

# Method 3: Using range operator
$range = 1..10
$letters = 'A'..'Z'

# Method 4: Implicit array (assigning single value creates single-item array)
$single = "One"

# Method 5: Using @() with pipeline
$processes = @(Get-Process | Select-Object -First 5)


# Accessing Array Elements
# ==============================================================================

# Accessing by index (0-based)
$fruits = @("Apple", "Banana", "Orange", "Mango")

Write-Host "First fruit: $($fruits[0])"           # Apple
Write-Host "Second fruit: $($fruits[1])"          # Banana
Write-Host "Last fruit: $($fruits[-1])"           # Mango (negative indexing)
Write-Host "Second to last: $($fruits[-2])"       # Orange

# Accessing multiple elements
$subset = $fruits[0, 2]                          # Apple, Orange
$range = $fruits[1..3]                           # Banana, Orange, Mango


# Array Properties and Methods
# ==============================================================================

$numbers = @(10, 20, 30, 40, 50)

# Count property
Write-Host "Array length: $($numbers.Count)"
Write-Host "Array length: $($numbers.Length)"

# Get actual number of items
if ($numbers -is [array]) {
    Write-Host "This is an array"
}

# Check if item exists in array
if ($numbers -contains 30) {
    Write-Host "30 exists in array"
}

if (30 -in $numbers) {
    Write-Host "30 is in the array"
}

# Find index of item
[Array]::IndexOf($numbers, 30)                   # Returns 2

# Get sub-array (slice)
$sliced = $numbers[1..3]                         # 20, 30, 40


# Adding and Removing Elements
# ==============================================================================

# Adding elements (creates new array - arrays are immutable in size)
$list = @(1, 2, 3)
$list = $list + 4                                # Array becomes [1, 2, 3, 4]
$list = $list + @(5, 6)                          # Array becomes [1, 2, 3, 4, 5, 6]

# Adding to beginning
$list = @(0) + $list                             # Array becomes [0, 1, 2, 3, 4, 5, 6]

# Removing elements
$list = $list | Where-Object { $_ -ne 3 }       # Remove value 3

# Removing by index
$newList = $list[0..($list.Count-2)]             # Remove last element

# Using ArrayList for better performance with many additions
[System.Collections.ArrayList]$arrayList = @(1, 2, 3)
$arrayList.Add(4)                                # Add single item
$arrayList.AddRange(@(5, 6))                     # Add multiple items
$arrayList.Remove(2)                             # Remove by value
$arrayList.RemoveAt(0)                           # Remove by index


# Iterating Through Arrays
# ==============================================================================

$names = @("Alice", "Bob", "Charlie")

# Method 1: ForEach loop
foreach ($name in $names) {
    Write-Host "Name: $name"
}

# Method 2: For loop
for ($i = 0; $i -lt $names.Count; $i++) {
    Write-Host "[$i] $($names[$i])"
}

# Method 3: ForEach-Object (pipeline)
$names | ForEach-Object {
    Write-Host "Person: $_"
}

# Method 4: ForEach-Object with index
$names | ForEach-Object -Process {
    Write-Host "[$($_.GetHashCode())] $_"
}


# Sorting and Filtering Arrays
# ==============================================================================

$numbers = @(5, 2, 8, 1, 9, 3)
$names = @("Zara", "Alice", "Bob", "Charlie")

# Sort array
$sorted = $numbers | Sort-Object
Write-Host "Sorted numbers: $sorted"

$sortedNames = $names | Sort-Object
Write-Host "Sorted names: $sortedNames"

# Sort descending
$descending = $numbers | Sort-Object -Descending
Write-Host "Descending: $descending"

# Filter array (Where-Object)
$evenNumbers = $numbers | Where-Object { $_ % 2 -eq 0 }
Write-Host "Even numbers: $evenNumbers"

$namesStartingWithA = $names | Where-Object { $_ -like "A*" }
Write-Host "Names starting with A: $namesStartingWithA"


# Array Transformation
# ==============================================================================

# Select specific properties (Select-Object)
$result = $numbers | Select-Object -First 3
$result = $numbers | Select-Object -Last 2
$result = $numbers | Select-Object -Skip 2 -First 3

# Map/Transform (ForEach-Object)
$doubled = $numbers | ForEach-Object { $_ * 2 }
Write-Host "Doubled: $doubled"

$squared = $numbers | ForEach-Object { $_ * $_ }
Write-Host "Squared: $squared"

# Group by condition
$grouped = $numbers | Group-Object { if ($_ % 2 -eq 0) { "Even" } else { "Odd" } }


# Multidimensional Arrays
# ==============================================================================

# 2D Array (array of arrays)
$matrix = @(
    @(1, 2, 3),
    @(4, 5, 6),
    @(7, 8, 9)
)

Write-Host "Element [0,0]: $($matrix[0][0])"     # 1
Write-Host "Element [1,2]: $($matrix[1][2])"     # 6
Write-Host "Element [2,1]: $($matrix[2][1])"     # 8

# Iterate through 2D array
foreach ($row in $matrix) {
    foreach ($item in $row) {
        Write-Host "Value: $item"
    }
}


# Array Best Practices
# ==============================================================================

# 1. Use @() for empty arrays
$items = @()

# 2. Check count before accessing
if ($items.Count -gt 0) {
    Write-Host "First item: $($items[0])"
}

# 3. Use ArrayList for performance with many additions
[System.Collections.ArrayList]$largeList = @()
for ($i = 0; $i -lt 1000; $i++) {
    $largeList.Add($i) | Out-Null
}

# 4. Use pipeline with Where-Object instead of nested loops
$result = $numbers | Where-Object { $_ -gt 5 } | Select-Object

# 5. Document array contents
# $userIds contains employee IDs in sequential order
$userIds = @(1001, 1002, 1003, 1004)
