# Contributing to PowerShell Basics Guide 🤝

First off, thank you for considering contributing to this guide! It's community members like you that make PowerShell Basics Guide such a great resource.

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior.

## How Can I Contribute?

### 1. Report Bugs 🐛

Found an error or unclear explanation? Please create an issue with:

- **Clear description** of the problem
- **What you expected** to happen
- **What actually happened**
- **Your PowerShell version** (run `$PSVersionTable`)
- **Relevant code snippet** if applicable

### 2. Suggest Improvements 💡

Have ideas for new topics or better explanations? 

- Suggest new PowerShell topics to cover
- Propose improvements to existing content
- Recommend additional examples
- Suggest better organization

### 3. Submit Code Changes 📝

Want to add examples or fix issues? Follow these steps:

#### Setup

1. **Fork the repository**
   ```bash
   # Click "Fork" on GitHub
   ```

2. **Clone your fork**
   ```powershell
   git clone https://github.com/YOUR-USERNAME/PowerShell-Basics-Guide.git
   cd PowerShell-Basics-Guide
   ```

3. **Create a branch**
   ```powershell
   git checkout -b feature/your-feature-name
   ```

#### Making Changes

1. **Follow the existing code style**
   - Use consistent indentation (4 spaces)
   - Use meaningful variable names
   - Add comments explaining complex logic
   - Keep lines reasonably short

2. **Test your changes**
   ```powershell
   # Run the script to verify it works
   .\01-Variables\01-Variables-Basics.ps1
   ```

3. **Document your changes**
   - Update README files if needed
   - Add inline comments
   - Include practical examples

### 4. Improve Documentation 📚

Documentation improvements are always welcome:

- Fix typos
- Clarify explanations
- Add examples
- Improve README files
- Add new FAQs

## Contribution Guidelines

### Code Style

```powershell
# ✅ Good - Clear and well-documented
function Get-UserInfo {
    <#
    .SYNOPSIS
    Retrieves user information
    
    .PARAMETER UserId
    The user ID to look up
    #>
    param(
        [Parameter(Mandatory=$true)]
        [int]$UserId
    )
    
    # Validate input
    if ($UserId -le 0) {
        throw "UserId must be positive"
    }
    
    # Get user data
    $userData = @{
        Id = $UserId
        Name = "User $UserId"
    }
    
    return $userData
}
```

```powershell
# ❌ Bad - Unclear and undocumented
function GetUser($u) {
    $x = @{Id = $u; Name = "User $u"}
    return $x
}
```

### File Naming Conventions

- **PowerShell Scripts**: `NN-Descriptive-Name.ps1` (e.g., `01-Variables-Basics.ps1`)
- **README Files**: `README.md` in each topic folder
- **Numbered Folders**: `NN-TopicName` (e.g., `01-Variables`)

### Commit Messages

Write clear, descriptive commit messages:

```powershell
# ✅ Good
git commit -m "Add array slicing examples to DataStructures"
git commit -m "Fix null check validation in Variables section"
git commit -m "Update README with contribution guidelines"

# ❌ Bad
git commit -m "updates"
git commit -m "stuff"
git commit -m "fix"
```

### Pull Request Process

1. **Update documentation** if you've added/changed functionality
2. **Test your changes** thoroughly
3. **Keep commits clean** - One logical change per commit
4. **Write a clear PR description**:
   - What changes you made
   - Why you made them
   - Any related issues

5. **Be patient** - We'll review and provide feedback

### PR Checklist

Before submitting, ensure:

- [ ] Code runs without errors
- [ ] Follows style guidelines
- [ ] Comments explain complex logic
- [ ] README updated if needed
- [ ] Examples are practical and tested
- [ ] No duplicate content

## What We're Looking For

### New Topic Scripts

If adding new content:

1. **Follow the existing structure**
   ```
   NN-TopicName/
   ├── NN-Subtopic.ps1
   ├── NN-Subtopic.ps1
   └── README.md
   ```

2. **Include comprehensive examples**
   - Basic usage
   - Advanced features
   - Common patterns
   - Best practices

3. **Add detailed comments**
   ```powershell
   # Section Header
   # ==============================================================================
   # Explanation of what this section covers
   
   # Example 1: Basic usage
   $example = "value"
   ```

4. **Document in README**
   - File descriptions
   - Key concepts
   - Quick reference
   - Best practices

### Bug Fixes

- Clear explanation of the bug
- Before/after demonstration
- Test that the fix works
- No breaking changes

### Documentation Updates

- Improves clarity
- Fixes inaccuracies
- Adds missing information
- Better examples

## Review Process

1. **Automated Checks** - Tests run automatically
2. **Code Review** - Team members review
3. **Feedback** - We may suggest changes
4. **Approval** - Approved changes are merged

## Questions?

- 📧 [Email](mailto:rajatkhonde@gmail.com)
- 💬 [Create a Discussion](https://github.com/rajat-khonde/PowerShell-Basics-Guide/discussions)
- 🔗 [LinkedIn](https://www.linkedin.com/in/rajat-khonde-450b46119/)

## Areas We Need Help With

- ⭐ PowerShell 7+ specific features
- ⭐ Advanced function examples
- ⭐ Complete error handling section
- ⭐ Real-world automation examples
- ⭐ Module creation examples
- ⭐ Performance optimization tips

## Recognition

Contributors will be recognized in:
- README acknowledgments
- Commit history
- Pull request comments

## Additional Notes

### Testing Your Scripts

Always test before submitting:

```powershell
# Run the script
.\01-Variables\01-Variables-Basics.ps1

# Check for errors
if ($?) { Write-Host "Success!" } else { Write-Host "Failed!" }

# Test with different scenarios
# Consider edge cases
# Verify output format
```

### Common Mistakes to Avoid

- ❌ Hardcoded paths (use relative paths)
- ❌ Assumptions about OS (use cross-platform code)
- ❌ Scripts that require special permissions without noting it
- ❌ Missing error handling
- ❌ Undocumented functions

## Diversity and Inclusion

We welcome contributions from people of all backgrounds and experience levels. Our goal is to create an inclusive, supportive community where everyone can learn and contribute.

---

**Thank you for making PowerShell Basics Guide better!** 🎉

Your contributions help others learn PowerShell and build better automation solutions.

Happy coding! 💻
