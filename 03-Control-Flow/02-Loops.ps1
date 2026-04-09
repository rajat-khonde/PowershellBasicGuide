# PowerShell Loops - ForEach, For, While, Do-While, Do-Until
# ==============================================================================

# ForEach Loop
# ==============================================================================

# Method 1: ForEach statement
$fruits = @("Apple", "Banana", "Orange", "Mango")

foreach ($fruit in $fruits) {
    Write-Host "Fruit: $fruit"
}

# Method 2: Using ranges
foreach ($i in 1..5) {
    Write-Host "Number: $i"
}

# Method 3: Nested foreach loops
$matrix = @(
    @(1, 2, 3),
    @(4, 5, 6),
    @(7, 8, 9)
)

foreach ($row in $matrix) {
    foreach ($item in $row) {
        Write-Host "Item: $item"
    }
}

# Method 4: ForEach with hashtable
$person = @{
    Name = "Rajat"
    Age = 30
    City = "Mumbai"
}

foreach ($entry in $person.GetEnumerator()) {
    Write-Host "$($entry.Key): $($entry.Value)"
}


# For Loop
# ==============================================================================

# Basic for loop
for ($i = 0; $i -lt 5; $i++) {
    Write-Host "Count: $i"
}

# For loop with step
for ($i = 0; $i -le 10; $i += 2) {
    Write-Host "Even: $i"
}

# Countdown loop
for ($i = 5; $i -gt 0; $i--) {
    Write-Host "Countdown: $i"
}

# For loop with array
$names = @("Alice", "Bob", "Charlie")

for ($i = 0; $i -lt $names.Count; $i++) {
    Write-Host "[$i] $($names[$i])"
}

# For loop with break
for ($i = 0; $i -lt 10; $i++) {
    if ($i -eq 5) {
        break
    }
    Write-Host "Value: $i"
}

# For loop with continue
for ($i = 0; $i -lt 5; $i++) {
    if ($i -eq 2) {
        continue
    }
    Write-Host "Value: $i"
}


# While Loop
# ==============================================================================

# Basic while loop
$count = 0

while ($count -lt 5) {
    Write-Host "Count: $count"
    $count++
}

# While with condition check
$password = ""

while ([string]::IsNullOrEmpty($password)) {
    $password = Read-Host "Enter password"
    if ([string]::IsNullOrEmpty($password)) {
        Write-Host "Password cannot be empty"
    }
}

# While with file processing
$file = Get-Item "C:\temp\data.txt" -ErrorAction SilentlyContinue

if ($file -and $file.Length -gt 0) {
    $bytes = 0
    while ($bytes -lt $file.Length) {
        # Process in chunks
        $chunkSize = [Math]::Min(1024, $file.Length - $bytes)
        Write-Host "Processed: $chunkSize bytes"
        $bytes += $chunkSize
    }
}

# Infinite loop with break
$attempt = 0

while ($true) {
    $attempt++
    Write-Host "Attempt: $attempt"
    
    if ($attempt -ge 3) {
        break
    }
}


# Do-While Loop
# ==============================================================================

# Do-While ensures block executes at least once
$count = 0

do {
    Write-Host "Do-While Count: $count"
    $count++
} while ($count -lt 3)

# Do-While with user input validation
$validInput = $false

do {
    $input = Read-Host "Enter 'yes' or 'no'"
    
    if ($input -eq "yes" -or $input -eq "no") {
        $validInput = $true
        Write-Host "Valid input received: $input"
    } else {
        Write-Host "Invalid input. Please try again."
    }
} while (-not $validInput)


# Do-Until Loop
# ==============================================================================

# Do-Until repeats until condition becomes true
$number = 0

do {
    Write-Host "Number: $number"
    $number++
} until ($number -ge 5)

# Do-Until with retry logic
$maxRetries = 3
$retry = 0

do {
    try {
        # Simulate operation
        $result = Get-Item "C:\nonexistent.txt" -ErrorAction Stop
        Write-Host "Operation successful"
    } catch {
        $retry++
        Write-Host "Attempt $retry failed. Retrying..."
    }
} until ($retry -ge $maxRetries -or $result)


# ForEach-Object (Pipeline)
# ==============================================================================

# Method 1: Simple ForEach-Object
1..5 | ForEach-Object {
    Write-Host "Value: $_"
}

# Method 2: With index variable
$colors = @("Red", "Green", "Blue")
$colors | ForEach-Object -Process {
    Write-Host "Color: $_"
}

# Method 3: Using multiple scriptblocks
$numbers = @(1, 2, 3, 4, 5)

$numbers | ForEach-Object `
    -Begin { Write-Host "Starting..." } `
    -Process { Write-Host "Processing: $_" } `
    -End { Write-Host "Done!" }

# Method 4: Getting index in ForEach-Object
$items = @("A", "B", "C")
$items | ForEach-Object -Process {
    $index = [System.Array]::IndexOf($items, $_)
    Write-Host "[$index] $_"
}

# Method 5: Parallel ForEach (PowerShell 7+)
# 1..10 | ForEach-Object -Parallel {
#     Write-Host "Processing: $_"
# }


# Break and Continue
# ==============================================================================

# Break - exits the loop
foreach ($i in 1..10) {
    if ($i -eq 5) {
        Write-Host "Breaking at $i"
        break
    }
    Write-Host "Value: $i"
}

# Continue - skips to next iteration
foreach ($i in 1..5) {
    if ($i -eq 3) {
        Write-Host "Skipping $i"
        continue
    }
    Write-Host "Value: $i"
}


# Practical Examples
# ==============================================================================

# Example 1: Process multiple files
$files = Get-ChildItem "C:\temp" -Filter "*.txt" -ErrorAction SilentlyContinue

foreach ($file in $files) {
    Write-Host "Processing: $($file.Name)"
    Write-Host "Size: $($file.Length) bytes"
    Write-Host "Modified: $($file.LastWriteTime)"
    Write-Host "---"
}

# Example 2: Retry logic with while loop
$maxAttempts = 3
$attempt = 0
$success = $false

while ($attempt -lt $maxAttempts -and -not $success) {
    $attempt++
    try {
        # Simulate operation
        Write-Host "Attempt $attempt..."
        # $result = Get-Item "C:\file.txt" -ErrorAction Stop
        $success = $true
        Write-Host "Success!"
    } catch {
        Write-Host "Failed: $_"
        if ($attempt -lt $maxAttempts) {
            Start-Sleep -Seconds 2
        }
    }
}

# Example 3: Build number list with for loop
$numbers = @()

for ($i = 1; $i -le 10; $i += 2) {
    $numbers += $i
}

Write-Host "Odd numbers: $numbers"

# Example 4: Nested loops for matrix operations
$rows = 3
$cols = 3

Write-Host "Matrix:"
for ($r = 0; $r -lt $rows; $r++) {
    for ($c = 0; $c -lt $cols; $c++) {
        Write-Host -NoNewline "[$r,$c] "
    }
    Write-Host ""
}

# Example 5: Data transformation with ForEach-Object
$prices = @(10, 20, 30, 40, 50)

$discounted = $prices | ForEach-Object {
    [Math]::Round($_ * 0.9, 2)  # 10% discount
}

Write-Host "Original: $prices"
Write-Host "Discounted: $discounted"
