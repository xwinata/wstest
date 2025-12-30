# Go Workspace Development Experience

This document explains how Go workspaces enable efficient local development across multiple modules and how this differs from external usage.

## What is a Go Workspace?

A Go workspace (defined by `go.work`) allows you to work on multiple modules simultaneously as if they were a single project, while maintaining their independence for external consumers.

## Our Workspace Setup

```
wstest/
├── go.work                    # Workspace configuration
├── mathutils/                 # Independent module
│   ├── go.mod
│   └── math.go
├── stringutils/               # Independent module  
│   ├── go.mod
│   └── strings.go
├── consumer-app/              # External consumer (not in workspace)
└── another-consumer/          # External consumer (not in workspace)
```

### go.work Configuration

```go
go 1.21

use (
    ./mathutils
    ./stringutils
)
```

## Workspace Development vs External Usage

### 1. Local Development (With Workspace)

When developing within the workspace:

```bash
# All modules use latest local versions automatically
go run test_workspace.go

# Build any module using local dependencies
go build ./mathutils
go build ./stringutils

# Changes in one module immediately available to others
# No need to publish tags or manage versions during development
```

**Benefits:**
- Immediate access to latest changes across modules
- No version management during development
- Fast iteration cycles
- Unified development experience

### 2. External Usage (Without Workspace)

External consumers work with published versions:

```bash
# Must disable workspace to simulate external usage
GOWORK=off go run main.go

# External consumers specify exact versions in go.mod
require (
    github.com/xwinata/wstest/mathutils v1.0.1
    github.com/xwinata/wstest/stringutils v1.0.0
)
```

**Characteristics:**
- Uses published Git tags and versions
- Explicit version constraints in go.mod
- Stable, predictable dependencies
- Can choose different versions per module

## Development Workflow Examples

### Making Changes and Testing Locally

1. **Edit a module** (e.g., add new function to mathutils):
   ```bash
   # Edit mathutils/math.go
   # Add: func Subtract(a, b int) int { return a - b }
   ```

2. **Test immediately** in workspace:
   ```bash
   # Create test file that uses the new function
   go run test_new_feature.go
   # Works immediately - no versioning needed
   ```

3. **Verify external consumers still work**:
   ```bash
   cd consumer-app
   GOWORK=off go run main.go
   # Still uses published v1.0.1 - unaffected by local changes
   ```

### Publishing Changes

1. **Commit and tag** when ready:
   ```bash
   git add mathutils/math.go
   git commit -m "Add Subtract function to mathutils"
   git tag mathutils/v1.1.0
   git push origin mathutils/v1.1.0
   ```

2. **External consumers can upgrade**:
   ```bash
   cd consumer-app
   GOWORK=off go get github.com/xwinata/wstest/mathutils@v1.1.0
   ```

## Key Differences Summary

| Aspect | Workspace Development | External Usage |
|--------|----------------------|----------------|
| **Version Resolution** | Latest local code | Published Git tags |
| **Dependency Updates** | Automatic | Manual via `go get` |
| **Isolation** | Shared development | Independent versions |
| **Speed** | Instant changes | Requires publishing |
| **Stability** | Development versions | Stable releases |

## Commands for Exploring

### Workspace Commands
```bash
# Sync workspace modules
go work sync

# Edit workspace modules
go work edit -use ./new-module

# Build within workspace
go build ./mathutils
```

### External Consumer Commands
```bash
# Disable workspace for testing
GOWORK=off go run main.go

# Update specific module version
GOWORK=off go get github.com/xwinata/wstest/mathutils@v1.0.1

# Check current dependencies
go list -m all
```

### Version Exploration
```bash
# List all available tags
git tag --list

# See version history
git log --oneline --decorate --graph

# Compare versions
git diff mathutils/v1.0.0 mathutils/v1.0.1 -- mathutils/
```

## Best Practices

1. **Use workspace for development** - Fast iteration and testing
2. **Test external usage** - Regularly verify with `GOWORK=off`
3. **Version thoughtfully** - Follow semantic versioning
4. **Document breaking changes** - Help consumers make informed decisions
5. **Maintain backward compatibility** - When possible, avoid breaking changes

This dual approach gives you the best of both worlds: fast development iteration and stable external consumption.