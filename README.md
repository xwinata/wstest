# Go Multi-Module Repository Learning System

A hands-on learning system that demonstrates how to organize multiple Go modules within a single repository with independent versioning. This project shows how breaking changes in one module don't force upgrades in other modules, enabling selective upgrades.

## 🎯 What Problem Does This Solve?

### The Forced Upgrade Problem

In traditional single-module repositories, when any part of your codebase has breaking changes, ALL consumers must upgrade simultaneously. This creates:

- **Coordination overhead** - All teams must upgrade at once
- **Risk amplification** - One breaking change affects everything  
- **Development bottlenecks** - Can't ship improvements without breaking changes
- **Version lock-in** - Consumers stuck on old versions to avoid breaks

### The Multi-Module Solution

With independent modules, consumers can:
- ✅ Get bug fixes without breaking changes
- ✅ Upgrade modules selectively based on their needs
- ✅ Stay on stable versions while others adopt new features
- ✅ Reduce coordination overhead across teams

## 📚 Learning Journey

This repository demonstrates the concepts through a practical example with two simple modules:

### mathutils
- **Module Path**: `github.com/xwinata/wstest/mathutils`
- **Purpose**: Provides simple mathematical operations
- **Functions**: Add, Multiply, Version

### stringutils  
- **Module Path**: `github.com/xwinata/wstest/stringutils`
- **Purpose**: Provides simple string operations
- **Functions**: HelloWorld, Reverse, Version

## 🚀 Quick Start

### 1. Explore the Workspace Development Experience

```bash
# Clone and explore the repository
git clone https://github.com/xwinata/wstest.git
cd wstest

# See the workspace configuration
cat go.work

# Build modules using workspace
go build ./mathutils
go build ./stringutils

# Test workspace development
go run -c 'package main; import ("fmt"; "github.com/xwinata/wstest/mathutils"); func main() { fmt.Println("Add(5,3):", mathutils.Add(5, 3)) }'
```

### 2. Explore External Consumer Patterns

```bash
# Test first consumer (conservative upgrade strategy)
cd consumer-app
GOWORK=off go run main.go

# Test second consumer (adopts breaking changes)
cd ../another-consumer  
GOWORK=off go run main.go
```

### 3. Explore Version History

```bash
# See all module versions
git tag --list

# See version progression
git log --oneline --decorate --graph
```

## 📖 Versioning Timeline & Examples

This project demonstrates a realistic versioning scenario:

### Phase 1: Initial Release
```bash
mathutils/v1.0.0    # Initial math functions
stringutils/v1.0.0  # Initial string functions
```

### Phase 2: Bug Fix (Patch Release)
```bash
mathutils/v1.0.1    # Fixed bug in Add function
stringutils/v1.0.0  # No changes needed
```

**Consumer Choice**: Get the bug fix without any other changes
```go
// In external consumer's go.mod
require (
    github.com/xwinata/wstest/mathutils v1.0.1    // Bug fix version
    github.com/xwinata/wstest/stringutils v1.0.0  // Avoid breaking changes
)
```

### Phase 3: Breaking Change (Major Release)
```bash
mathutils/v1.0.1      # Still stable
stringutils/v2.0.0    # BREAKING: HelloWorld(name, greeting string)
```

**Consumer Choice**: Different consumers can make different decisions
- **Conservative**: Stay on stringutils v1.0.0, get mathutils v1.0.1
- **Progressive**: Adopt stringutils v2.0.0, get mathutils v1.0.1

## 🔍 Step-by-Step Learning Guide

### Step 1: Understand the Repository Structure
```
wstest/
├── go.work                    # Workspace for local development
├── mathutils/                 # Independent module
├── stringutils/               # Independent module  
├── consumer-app/              # External consumer (conservative)
├── another-consumer/          # External consumer (progressive)
└── WORKSPACE_DEVELOPMENT.md   # Development workflow guide
```

### Step 2: Compare Development vs External Usage

**Development (with workspace)**:
```bash
# Uses latest local code automatically
go run test_example.go
```

**External usage (published versions)**:
```bash
# Uses specific published versions
GOWORK=off go run main.go
```

### Step 3: Explore Selective Upgrades

1. **Check current consumer versions**:
   ```bash
   cd consumer-app && cat go.mod
   cd ../another-consumer && cat go.mod
   ```

2. **See how they handle the same modules differently**:
   - `consumer-app`: mathutils v1.0.1 + stringutils v1.0.0
   - `another-consumer`: mathutils v1.0.1 + stringutils v2.0.0

3. **Run both to see the difference**:
   ```bash
   cd consumer-app && GOWORK=off go run main.go
   cd ../another-consumer && GOWORK=off go run main.go
   ```

### Step 4: Understand Version Constraints

Explore different version constraint strategies:

```go
// Exact version (most restrictive)
github.com/xwinata/wstest/mathutils v1.0.1

// Minor version range (patch updates only)  
github.com/xwinata/wstest/mathutils v1.0

// Major version range (minor and patch updates)
github.com/xwinata/wstest/mathutils v1
```

## 🛠️ Commands for Exploration

### Version Exploration
```bash
# List all available versions
git tag --list

# See what changed between versions
git diff mathutils/v1.0.0 mathutils/v1.0.1 -- mathutils/

# See commit history for a module
git log --oneline -- mathutils/
```

### Dependency Management
```bash
# See current dependencies
go list -m all

# Update to specific version
go get github.com/xwinata/wstest/mathutils@v1.0.1

# See available versions
go list -m -versions github.com/xwinata/wstest/mathutils
```

### Workspace vs External Testing
```bash
# Test with workspace (development)
go run example.go

# Test without workspace (external consumer)
GOWORK=off go run example.go

# Build specific module
go build ./mathutils
```

## 🎓 Key Learning Outcomes

After exploring this repository, you'll understand:

1. **Multi-module organization** - How to structure independent modules
2. **Selective upgrades** - How consumers can choose versions independently  
3. **Breaking change isolation** - How changes in one module don't affect others
4. **Workspace development** - How to develop multiple modules efficiently
5. **Semantic versioning** - How to version modules appropriately
6. **Consumer strategies** - Different approaches to dependency management

## 📋 Next Steps

1. **Read** `WORKSPACE_DEVELOPMENT.md` for detailed development workflows
2. **Read** `EXTERNAL_CONSUMERS.md` for consumer patterns and strategies
3. **Experiment** with creating your own modules and consumers
4. **Practice** selective upgrades with different version combinations

## 🤝 Contributing

This is a learning repository. Feel free to:
- Add more example modules
- Create additional consumer scenarios  
- Improve documentation
- Add more complex versioning examples

The goal is to make multi-module concepts accessible and practical for Go developers.