# Go Multi-Module Repository Learning System

This repository demonstrates how to organize multiple Go modules within a single repository with independent versioning. It shows how breaking changes in one module don't force upgrades in other modules, allowing selective upgrades.

## Repository Structure

```
go-multimodule-learning/
├── go.work                    # Workspace for local development
├── mathutils/                 # Math utilities module
│   ├── go.mod
│   ├── math.go
│   └── math_test.go
├── stringutils/               # String utilities module
│   ├── go.mod
│   ├── strings.go
│   └── strings_test.go
└── README.md                  # This file
```

## Modules

### mathutils
- **Module Path**: `github.com/xwinata/wstest/mathutils`
- **Purpose**: Provides simple mathematical operations
- **Functions**: Add, Multiply, Version

### stringutils
- **Module Path**: `github.com/xwinata/wstest/stringutils`
- **Purpose**: Provides simple string operations
- **Functions**: HelloWorld, Reverse, Version

## Learning Objectives

This system demonstrates:

1. **Multi-Module Repository Setup**: How to organize multiple independent modules in one repository
2. **Independent Versioning**: How modules can be versioned independently using Git tags
3. **Breaking Change Isolation**: How breaking changes in one module don't affect others
4. **Selective Upgrades**: How consumers can upgrade specific modules without being forced to upgrade all dependencies
5. **Workspace Development**: How `go.work` enables efficient local development across modules

## Getting Started

1. **Local Development**: Use `go.work` for development across all modules
2. **External Usage**: External consumers import specific module versions via `go.mod`
3. **Version Management**: Each module uses semantic versioning with module-prefixed Git tags

## External Consumer Examples

External applications can consume these modules by importing specific versions:

```go
// In external consumer's go.mod
require (
    github.com/xwinata/wstest/mathutils v1.0.1    // Bug fix version
    github.com/xwinata/wstest/stringutils v1.0.0  // Avoid breaking changes
)
```

This demonstrates the core benefit: getting bug fixes in mathutils without being forced to adopt breaking changes in stringutils.