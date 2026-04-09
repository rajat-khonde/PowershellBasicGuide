# PowerShell Basics Guide 📚

A comprehensive, community-driven guide to PowerShell fundamentals. Perfect for beginners, self-learners, and anyone looking for quick reference material.

[![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=for-the-badge&logo=powershell&logoColor=white)](https://learn.microsoft.com/en-us/powershell/)
[![License](https://img.shields.io/badge/license-MIT-green.svg?style=for-the-badge)](LICENSE)
[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=for-the-badge)](CONTRIBUTING.md)

## Table of Contents

- [Overview](#overview)
- [Folder Structure](#folder-structure)
- [Getting Started](#getting-started)
- [Learning Path](#learning-path)
- [Quick Reference](#quick-reference)
- [Prerequisites](#prerequisites)
- [Contributing](#contributing)
- [Resources](#resources)

## Overview

This guide covers PowerShell fundamentals through practical examples and well-documented code. Each topic includes:

- **Comprehensive Scripts** - Full working examples with detailed comments
- **Quick Reference** - Snippets for rapid lookup
- **Best Practices** - Real-world guidance and recommendations
- **Common Mistakes** - What to avoid and why
- **Practical Examples** - Real-world use cases

## Folder Structure

```
PowerShell-Basics-Guide/
├── 01-Variables/
│   ├── 01-Variables-Basics.ps1      # Variable fundamentals
│   ├── 02-Variable-Validation.ps1   # Validation techniques
│   └── README.md                    # Topic guide
│
├── 02-DataStructures/
│   ├── 01-Arrays.ps1                # Arrays and collections
│   ├── 02-Hashtables.ps1            # Key-value pairs
│   └── README.md                    # Topic guide
│
├── 03-Control-Flow/
│   ├── 01-Conditionals.ps1          # If/Else/Switch statements
│   ├── 02-Loops.ps1                 # For/Foreach/While loops
│   └── README.md                    # Topic guide
│
├── 04-Functions/
│   ├── README.md                    # Topic guide (coming soon)
│   └── [Function examples coming]
│
├── 05-ErrorHandling/
│   ├── README.md                    # Topic guide (coming soon)
│   └── [Error handling examples coming]
│
├── README.md                        # This file
└── CONTRIBUTING.md                  # Contribution guidelines
```

## Getting Started

### Prerequisites

- **PowerShell 5.1+** (PowerShell 7+ recommended)
- Basic command line familiarity
- A text editor (VSCode, ISE, or similar)

### Installation

1. Clone or download this repository
   ```powershell
   git clone https://github.com/rajat-khonde/PowerShell-Basics-Guide.git
   cd PowerShell-Basics-Guide
   ```

2. Open PowerShell
   ```powershell
   # Navigate to the guide directory
   cd .\PowerShell-Basics-Guide
   ```

3. Run scripts
   ```powershell
   # Execute a script
   .\01-Variables\01-Variables-Basics.ps1
   
   # Or run in ISE
   powershell_ise .\01-Variables\01-Variables-Basics.ps1
   ```

## Learning Path

### Beginner (Week 1-2)
1. **Variables** - Understand data storage
   - Start with `01-Variables/01-Variables-Basics.ps1`
   - Progress to validation techniques

2. **Data Structures** - Organize data
   - Learn Arrays in `02-DataStructures/01-Arrays.ps1`
   - Learn Hashtables in `02-DataStructures/02-Hashtables.ps1`

### Intermediate (Week 3-4)
3. **Control Flow** - Make decisions and iterate
   - Master Conditionals in `03-Control-Flow/01-Conditionals.ps1`
   - Master Loops in `03-Control-Flow/02-Loops.ps1`

### Advanced (Week 5+)
4. **Functions** - Build reusable code
   - Coming soon in `04-Functions/`

5. **Error Handling** - Handle exceptions gracefully
   - Coming soon in `05-ErrorHandling/`

## Quick Reference

### Run All Scripts in Topic
```powershell
# Run all scripts in Variables section
Get-ChildItem .\01-Variables\*.ps1 | ForEach-Object {
    & $_
}
```

### Find Specific Topics
```powershell
# Search for specific content
Get-ChildItem -Recurse -Include "*.ps1" | 
    Select-String "switch" -List | 
    Select-Object Filename, Path
```

### View Scripts in ISE
```powershell
# Open script in PowerShell ISE
powershell_ise .\01-Variables\01-Variables-Basics.ps1
```

## Quick Reference Guide

### Variables
```powershell
# Declaration
$name = "Rajat"
$count = 42
$items = @(1, 2, 3)

# Validation
if ([string]::IsNullOrEmpty($var)) { }
if (Test-Path variable:\varName) { }
```

### Arrays
```powershell
# Create
$arr = @(1, 2, 3)
$arr = 1..10

# Access
$arr[0]         # First
$arr[-1]        # Last
$arr[1..3]      # Range

# Iterate
foreach ($item in $arr) { }
$arr | ForEach-Object { }
```

### Hashtables
```powershell
# Create
$hash = @{ Name = "Rajat"; Age = 30 }

# Access
$hash.Name
$hash['Name']

# Check
$hash.ContainsKey('Name')
```

### Conditionals
```powershell
# If-Else
if ($x -eq 5) { } else { }

# Switch
switch ($value) {
    "A" { }
    default { }
}
```

### Loops
```powershell
# ForEach
foreach ($i in 1..10) { }

# For
for ($i = 0; $i -lt 10; $i++) { }

# While
while ($condition) { }
```

## Best Practices Summary

1. **Use Meaningful Names** - Code readability matters
2. **Validate Input** - Always check before using variables
3. **Handle Errors** - Use Try-Catch blocks appropriately
4. **Document Code** - Comments explain the "why"
5. **Test Thoroughly** - Verify edge cases

## Common Mistakes to Avoid

❌ **Not checking for null/empty values**
```powershell
# Bad
$var.Length  # Could fail if $var is $null

# Good
if ($var -and $var.Length -gt 0) { }
```

❌ **Using = for comparison**
```powershell
# Bad
if ($x = 5) { }  # This assigns, not compares!

# Good
if ($x -eq 5) { }
```

❌ **Mixing variable naming conventions**
```powershell
# Bad
$userName = "rajat"
$FirstName = "Rajat"  # Inconsistent

# Good
$userName = "rajat"
$firstName = "Rajat"  # Consistent
```

## Contributing

We welcome contributions! Whether it's:
- ✅ Bug fixes
- ✅ New examples
- ✅ Documentation improvements
- ✅ Better explanations
- ✅ Function and Error Handling scripts

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## Resources

### Official Documentation
- [Microsoft PowerShell Docs](https://learn.microsoft.com/en-us/powershell/)
- [PowerShell GitHub](https://github.com/PowerShell/PowerShell)

### Learning Resources
- [PowerShell by Example](https://learn.microsoft.com/en-us/powershell/scripting/samples/sample-scripts-for-administration)
- [PowerShell Gallery](https://www.powershellgallery.com/)

### Advanced Topics
- [Advanced PowerShell Functions](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced)
- [Error Handling](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_try_catch_finally)

## FAQ

**Q: What PowerShell version should I use?**
A: PowerShell 7+ (cross-platform) or PowerShell 5.1+ (Windows). This guide works with both.

**Q: Can I use these scripts in production?**
A: These are educational examples. Always test thoroughly before production use.

**Q: How do I run scripts if execution policy blocks me?**
A: Use `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser` (or ask your admin in enterprise environments).

**Q: Where can I practice?**
A: Open PowerShell ISE or VSCode with PowerShell extension and run the scripts interactively.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Created by **Rajat Khonde** - Cloud Automation & DevOps Engineer

- 🔗 [GitHub](https://github.com/rajat-khonde)
- 💼 [LinkedIn](https://www.linkedin.com/in/rajat-khonde-450b46119/)
- 📧 [Email](mailto:rajatkhonde@gmail.com)

## Acknowledgments

This guide was created to help the PowerShell community learn and share knowledge. Thanks to all contributors and learners!

---

**Made with ❤️ for the PowerShell Community**

Have questions or suggestions? [Create an issue](https://github.com/rajat-khonde/PowerShell-Basics-Guide/issues) or submit a pull request!
13. [Accessing values in a mixed hashtable](PowerShell_Hashtable.ps1#L64)
14. [Creating and initializing a hashtable in one line](PowerShell_Hashtable.ps1#L70)
15. [Accessing and modifying values in a hashtable in one line](PowerShell_Hashtable.ps1#L73)
16. [Removing a key-value pair from a hashtable in one line](PowerShell_Hashtable.ps1#L76)
17. [Checking if a key exists in a hashtable in one line](PowerShell_Hashtable.ps1#L79)
18. [Iterating over a hashtable in one line](PowerShell_Hashtable.ps1#L82)
19. [Merging two hashtables in one line](PowerShell_Hashtable.ps1#L85)
20. [Accessing values in a nested hashtable in one line](PowerShell_Hashtable.ps1#L88)
21. [Accessing values in a mixed hashtable in one line](PowerShell_Hashtable.ps1#L91)

## Commands

### Get the current date and time
```powershell
$currentDate = Get-Date

