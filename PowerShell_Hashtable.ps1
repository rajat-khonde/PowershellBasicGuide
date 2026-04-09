# Creating a hashtable
$hashtable = @{}

# Adding key-value pairs to a hashtable
$hashtable["Name"] = "John"
$hashtable["Age"] = 30
$hashtable["Country"] = "USA"

# Creating a hashtable with initial key-value pairs
$hashtable = @{
    Name = "Jane"
    Age = 25
    Country = "Canada"
}

# Accessing values in a hashtable
$name = $hashtable["Name"]
$age = $hashtable["Age"]
$country = $hashtable["Country"]

# Modifying values in a hashtable
$hashtable["Age"] = 26

# Removing a key-value pair from a hashtable
$hashtable.Remove("Country")

# Checking if a key exists in a hashtable
if ($hashtable.ContainsKey("Name")) {
    Write-Output "Name exists in the hashtable."
}

# Iterating over a hashtable
foreach ($key in $hashtable.Keys) {
    $value = $hashtable[$key]
    Write-Output "$key: $value"
}

# Merging two hashtables
$hashtable1 = @{
    Key1 = "Value1"
    Key2 = "Value2"
}

$hashtable2 = @{
    Key3 = "Value3"
    Key4 = "Value4"
}

$mergedHashtable = @{}
$mergedHashtable += $hashtable1
$mergedHashtable += $hashtable2

# Nested hashtables
$nestedHashtable = @{
    Person1 = @{
        Name = "Alice"
        Age = 28
    }
    Person2 = @{
        Name = "Bob"
        Age = 32
    }
}

# Accessing values in a nested hashtable
$person1Name = $nestedHashtable["Person1"]["Name"]
$person2Age = $nestedHashtable["Person2"]["Age"]

# Hashtable with different value types
$mixedHashtable = @{
    String = "Hello"
    Integer = 123
    Array = @(1, 2, 3)
    Hashtable = @{
        NestedKey = "NestedValue"
    }
}

# Accessing values in a mixed hashtable
$stringValue = $mixedHashtable["String"]
$integerValue = $mixedHashtable["Integer"]
$arrayValue = $mixedHashtable["Array"]
$nestedValue = $mixedHashtable["Hashtable"]["NestedKey"]

# Creating and initializing a hashtable in one line
$hashtable = @{ Name = "John"; Age = 30; Country = "USA" }

# Accessing and modifying values in a hashtable in one line
$hashtable["Age"] = 31

# Removing a key-value pair from a hashtable in one line
$hashtable.Remove("Country")

# Checking if a key exists in a hashtable in one line
if ($hashtable.ContainsKey("Name")) { Write-Output "Name exists in the hashtable." }

# Iterating over a hashtable in one line
$hashtable.GetEnumerator() | ForEach-Object { Write-Output "$($_.Key): $($_.Value)" }

# Merging two hashtables in one line
$mergedHashtable = $hashtable1 + $hashtable2

# Accessing values in a nested hashtable in one line
$person1Name = $nestedHashtable["Person1"]["Name"]
$person2Age = $nestedHashtable["Person2"]["Age"]

# Accessing values in a mixed hashtable in one line
$stringValue = $mixedHashtable["String"]
$integerValue = $mixedHashtable["Integer"]
$arrayValue = $mixedHashtable["Array"]
$nestedValue = $mixedHashtable["Hashtable"]["NestedKey"]


# Creating an unordered hashtable
$unorderedHashtable = @{
    Name = "Charlie"
    Age = 29
    Country = "UK"
}

# Displaying the unordered hashtable
Write-Output "Unordered Hashtable:"
#$unorderedHashtable
$unorderedHashtable.GetEnumerator() | ForEach-Object { Write-Output "$($_.Key): $($_.Value)" }

# Creating an ordered hashtable
$orderedHashtable = [ordered]@{
    Name = "Diana"
    Age = 34
    Country = "Australia"
}

# Displaying the ordered hashtable
Write-Output "Ordered Hashtable:"
$orderedHashtable.GetEnumerator() | ForEach-Object { Write-Output "$($_.Key): $($_.Value)" }