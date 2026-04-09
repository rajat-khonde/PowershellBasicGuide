# PowerShell Hashtables
# ==============================================================================
# Hashtables are collections of key-value pairs. They provide fast access
# to values based on keys.

# Creating Hashtables
# ==============================================================================

# Method 1: Using @{} syntax
$emptyHash = @{}

$person = @{
    Name = "Rajat Khonde"
    Age = 30
    City = "Mumbai"
    Email = "rajat@example.com"
}

# Method 2: Multi-line format (more readable)
$employee = @{
    EmployeeId = 1001
    FirstName  = "Rajat"
    LastName   = "Khonde"
    Department = "DevOps"
    Salary     = 75000
}

# Method 3: Creating and adding to hashtable
$config = @{}
$config["Database"] = "SQL Server"
$config["Port"] = 1433
$config["Host"] = "localhost"


# Accessing Hashtable Values
# ==============================================================================

$person = @{
    Name = "Rajat"
    Age = 30
    City = "Mumbai"
}

# Method 1: Using dot notation
Write-Host "Name: $($person.Name)"
Write-Host "Age: $($person.Age)"

# Method 2: Using bracket notation (bracket notation works for all keys)
Write-Host "City: $($person['City'])"
Write-Host "Name: $($person['Name'])"

# Method 3: Using bracket notation with variables
$key = "City"
Write-Host "Value: $($person[$key])"

# Method 4: Using GetEnumerator (least common)
$person.GetEnumerator() | ForEach-Object { 
    Write-Host "$($_.Key): $($_.Value)" 
}


# Adding and Updating Values
# ==============================================================================

$user = @{
    Name = "Rajat"
    Age = 30
}

# Add new key-value pair
$user["Email"] = "rajat@example.com"
$user["Phone"] = "+91-XXXXXXXXXX"

# Update existing value
$user["Age"] = 31

# Add using dot notation
$user.Country = "India"

# Add using Add method
$user.Add("Department", "Engineering")

# Method: Using Set (PowerShell 7+)
$user['City'] = "Mumbai"

Write-Host "Updated hashtable: $($user | Out-String)"


# Removing Values
# ==============================================================================

$data = @{
    Name = "Test"
    Value = 100
    Status = "Active"
}

# Remove specific key
$data.Remove("Value")

# Remove using dollar notation (less common)
# $data = $data | Where-Object { $_.Keys -ne "Value" }

Write-Host "After removal: $($data | Out-String)"


# Checking Keys and Values
# ==============================================================================

$config = @{
    Server = "localhost"
    Port = 8080
    Environment = "Development"
}

# Check if key exists
if ($config.ContainsKey("Server")) {
    Write-Host "Server key exists"
}

if (-not $config.ContainsKey("Database")) {
    Write-Host "Database key does not exist"
}

# Check if value exists
if ($config.ContainsValue("localhost")) {
    Write-Host "Value 'localhost' exists"
}

# List all keys
Write-Host "Keys: $($config.Keys)"

# List all values
Write-Host "Values: $($config.Values)"

# Get key count
Write-Host "Number of entries: $($config.Count)"


# Iterating Through Hashtables
# ==============================================================================

$person = @{
    Name = "Rajat"
    Age = 30
    City = "Mumbai"
    Email = "rajat@example.com"
}

# Method 1: GetEnumerator with foreach
foreach ($entry in $person.GetEnumerator()) {
    Write-Host "$($entry.Key): $($entry.Value)"
}

# Method 2: Using Keys property
foreach ($key in $person.Keys) {
    Write-Host "$key = $($person[$key])"
}

# Method 3: Pipeline with ForEach-Object
$person.GetEnumerator() | ForEach-Object {
    Write-Host "$($_.Key) -> $($_.Value)"
}

# Method 4: Direct enumeration
$person | ForEach-Object {
    $_.GetEnumerator() | ForEach-Object {
        Write-Host "$($_.Key): $($_.Value)"
    }
}


# Hashtable Properties and Methods
# ==============================================================================

$settings = @{
    Theme = "Dark"
    Language = "English"
    AutoSave = $true
    Timeout = 300
}

# Count (number of key-value pairs)
Write-Host "Total settings: $($settings.Count)"

# Keys
Write-Host "Available keys: $($settings.Keys -join ', ')"

# Values
Write-Host "Available values: $($settings.Values -join ', ')"

# Clone hashtable (shallow copy)
$settingsCopy = $settings.Clone()

# Check if hashtable is empty
if ($settings.Count -eq 0) {
    Write-Host "Hashtable is empty"
} else {
    Write-Host "Hashtable has $($settings.Count) items"
}


# Nested Hashtables
# ==============================================================================

# Creating nested structure
$company = @{
    Name = "TechCorp"
    CEO = @{
        FirstName = "John"
        LastName = "Doe"
        Age = 45
    }
    Departments = @{
        Engineering = @{
            Manager = "Rajat Khonde"
            Team = "DevOps Team"
            Count = 10
        }
        Sales = @{
            Manager = "Jane Smith"
            Team = "Sales Team"
            Count = 5
        }
    }
}

# Accessing nested values
Write-Host "CEO: $($company.CEO.FirstName) $($company.CEO.LastName)"
Write-Host "Engineering Manager: $($company.Departments.Engineering.Manager)"
Write-Host "Sales Team Count: $($company.Departments.Sales.Count)"

# Iterating through nested structure
foreach ($dept in $company.Departments.Keys) {
    Write-Host "Department: $dept"
    Write-Host "  Manager: $($company.Departments[$dept].Manager)"
    Write-Host "  Team: $($company.Departments[$dept].Team)"
}


# Ordered Hashtables
# ==============================================================================

# Regular hashtables don't guarantee order
$unordered = @{
    Zebra = 1
    Apple = 2
    Banana = 3
}

# Ordered hashtables maintain insertion order
$ordered = [ordered]@{
    Apple = 1
    Banana = 2
    Zebra = 3
}

# Iterating ordered hashtable preserves order
foreach ($item in $ordered.GetEnumerator()) {
    Write-Host "$($item.Key): $($item.Value)"
}


# Sorting Hashtables
# ==============================================================================

$data = @{
    Charlie = 3
    Alice = 1
    Bob = 2
}

# Sort by keys
$sortedByKeys = $data.GetEnumerator() | Sort-Object -Property Name
$sortedByKeys | ForEach-Object { Write-Host "$($_.Name): $($_.Value)" }

# Sort by values
$sortedByValues = $data.GetEnumerator() | Sort-Object -Property Value
$sortedByValues | ForEach-Object { Write-Host "$($_.Name): $($_.Value)" }


# Converting Hashtables
# ==============================================================================

$hashtable = @{
    Name = "Rajat"
    Age = 30
    City = "Mumbai"
}

# Convert to custom object
$object = $hashtable | ConvertTo-Json | ConvertFrom-Json
Write-Host "As Object: $object"

# Convert to parameter splatting
$params = @{
    Path = "C:\Test"
    Filter = "*.txt"
    Recurse = $true
}
Get-ChildItem @params  # Splat the hashtable


# Practical Examples
# ==============================================================================

# Example 1: Configuration management
$appConfig = @{
    AppName = "MyApp"
    Version = "1.0.0"
    Database = @{
        Host = "localhost"
        Port = 5432
        Name = "mydb"
    }
    Logging = @{
        Level = "Info"
        Path = "C:\Logs"
    }
}

# Example 2: Data mapping
$userMap = @{
    "rajat@example.com" = @{ Name = "Rajat Khonde"; Role = "Engineer" }
    "jane@example.com" = @{ Name = "Jane Doe"; Role = "Manager" }
    "bob@example.com" = @{ Name = "Bob Smith"; Role = "Developer" }
}

# Look up user
$email = "rajat@example.com"
if ($userMap.ContainsKey($email)) {
    $user = $userMap[$email]
    Write-Host "User: $($user.Name) - Role: $($user.Role)"
}

# Example 3: Splatting for function calls
$splatParams = @{
    Path = "C:\Windows"
    Recurse = $true
    Force = $true
}
Get-ChildItem @splatParams
