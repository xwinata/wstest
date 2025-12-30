# External Consumer Patterns and Strategies

This document provides comprehensive guidance on how external consumers can effectively use multi-module repositories, including different go.mod configuration strategies, version constraint syntax, and migration guidance.

## 🎯 Consumer Strategies Overview

Different consumers can adopt different strategies based on their risk tolerance and feature needs:

| Strategy | Description | Use Case | Example |
|----------|-------------|----------|---------|
| **Conservative** | Minimize risk, avoid breaking changes | Production systems, stable APIs | mathutils v1.0.1 + stringutils v1.0.0 |
| **Progressive** | Adopt latest features, accept breaking changes | New projects, feature-rich applications | mathutils v1.0.1 + stringutils v2.0.0 |
| **Selective** | Mix strategies per module | Most common in practice | Latest for stable modules, conservative for risky ones |

## 📋 go.mod Configuration Strategies

### 1. Exact Version Pinning (Most Restrictive)

```go
module github.com/mycompany/myapp

go 1.21

require (
    github.com/xwinata/wstest/mathutils v1.0.1
    github.com/xwinata/wstest/stringutils v1.0.0
)
```

**Pros:**
- Completely predictable builds
- No surprise updates
- Perfect for production systems

**Cons:**
- Manual effort to get updates
- Miss security patches
- Can fall behind on improvements

### 2. Patch-Level Updates (Recommended)

```go
module github.com/mycompany/myapp

go 1.21

require (
    github.com/xwinata/wstest/mathutils v1.0    // Gets v1.0.x patches
    github.com/xwinata/wstest/stringutils v1.0  // Gets v1.0.x patches
)
```

**Pros:**
- Automatic security patches
- Bug fixes without breaking changes
- Good balance of stability and updates

**Cons:**
- Slight unpredictability
- Need to test patch updates

### 3. Minor Version Updates (More Flexible)

```go
module github.com/mycompany/myapp

go 1.21

require (
    github.com/xwinata/wstest/mathutils v1      // Gets v1.x.x updates
    github.com/xwinata/wstest/stringutils v1    // Gets v1.x.x updates
)
```

**Pros:**
- Get new features automatically
- Stay current with improvements
- Good for development environments

**Cons:**
- More potential for breaking changes
- Requires more testing
- Less predictable

### 4. Mixed Strategy (Most Common)

```go
module github.com/mycompany/myapp

go 1.21

require (
    // Stable module - allow minor updates
    github.com/xwinata/wstest/mathutils v1
    
    // Risky module - pin exact version
    github.com/xwinata/wstest/stringutils v1.0.0
    
    // Development dependency - latest
    github.com/some/dev-tool v2
)
```

## 🔧 Version Constraint Syntax

### Semantic Version Constraints

```go
// Exact version
github.com/xwinata/wstest/mathutils v1.0.1

// Patch level (>= 1.0.0, < 1.1.0)
github.com/xwinata/wstest/mathutils v1.0

// Minor level (>= 1.0.0, < 2.0.0)  
github.com/xwinata/wstest/mathutils v1

// Latest in major version
github.com/xwinata/wstest/mathutils latest
```

### Advanced Constraints

```go
// Minimum version
github.com/xwinata/wstest/mathutils v1.0.1

// Version ranges (using go.mod replace for complex scenarios)
replace github.com/xwinata/wstest/mathutils => github.com/xwinata/wstest/mathutils v1.0.1
```

### Major Version Handling

```go
// v1.x.x versions
github.com/xwinata/wstest/stringutils v1.0.0

// v2.x.x versions (note the /v2 suffix)
github.com/xwinata/wstest/stringutils/v2 v2.0.0
```

## 🚀 Migration Guidance for Breaking Changes

### Step 1: Assess the Breaking Change

Before migrating, understand what changed:

```bash
# Compare versions to see changes
git diff stringutils/v1.0.0 stringutils/v2.0.0 -- stringutils/

# Read release notes or commit messages
git log stringutils/v1.0.0..stringutils/v2.0.0 --oneline -- stringutils/
```

### Step 2: Plan Your Migration

**Option A: Stay on Old Version**
```go
// Keep using v1.0.0 - no changes needed
require github.com/xwinata/wstest/stringutils v1.0.0
```

**Option B: Migrate to New Version**
```go
// Adopt v2.0.0 - requires code changes
require github.com/xwinata/wstest/stringutils/v2 v2.0.0
```

### Step 3: Gradual Migration Strategy

1. **Create a feature branch**:
   ```bash
   git checkout -b migrate-stringutils-v2
   ```

2. **Update go.mod**:
   ```bash
   go get github.com/xwinata/wstest/stringutils/v2@v2.0.0
   go mod tidy
   ```

3. **Update imports**:
   ```go
   // Old import
   import "github.com/xwinata/wstest/stringutils"
   
   // New import
   import stringutils "github.com/xwinata/wstest/stringutils/v2"
   ```

4. **Update function calls**:
   ```go
   // Old API (v1.0.0)
   greeting := stringutils.HelloWorld("Alice")
   
   // New API (v2.0.0)
   greeting := stringutils.HelloWorld("Alice", "Hello")
   ```

5. **Test thoroughly**:
   ```bash
   go test ./...
   go build ./...
   ```

### Step 4: Rollback Plan

Always have a rollback plan:

```bash
# If migration fails, easily revert
git checkout main
git branch -D migrate-stringutils-v2

# Or revert go.mod changes
go get github.com/xwinata/wstest/stringutils@v1.0.0
go mod tidy
```

## 🛠️ Practical Examples

### Example 1: Conservative Consumer

```go
// consumer-app/go.mod
module github.com/external-user/consumer-app

go 1.21

require (
    github.com/xwinata/wstest/mathutils v1.0.1    // Get bug fix
    github.com/xwinata/wstest/stringutils v1.0.0  // Avoid breaking changes
)
```

```go
// consumer-app/main.go
package main

import (
    "fmt"
    "github.com/xwinata/wstest/mathutils"
    "github.com/xwinata/wstest/stringutils"
)

func main() {
    // Uses stable APIs
    result := mathutils.Add(10, 5)
    greeting := stringutils.HelloWorld("User")
    
    fmt.Printf("Result: %d, Greeting: %s\n", result, greeting)
}
```

### Example 2: Progressive Consumer

```go
// another-consumer/go.mod
module github.com/another-user/another-consumer

go 1.21

require (
    github.com/xwinata/wstest/mathutils v1.0.1        // Get bug fix
    github.com/xwinata/wstest/stringutils/v2 v2.0.0   // Adopt breaking changes
)
```

```go
// another-consumer/main.go
package main

import (
    "fmt"
    "github.com/xwinata/wstest/mathutils"
    stringutils "github.com/xwinata/wstest/stringutils/v2"
)

func main() {
    // Uses latest APIs including breaking changes
    result := mathutils.Add(20, 15)
    greeting := stringutils.HelloWorld("Developer", "Welcome")
    
    fmt.Printf("Result: %d, Greeting: %s\n", result, greeting)
}
```

## 🔍 Troubleshooting Common Issues

### Issue 1: Module Not Found

```
go: module github.com/xwinata/wstest/stringutils@v2.0.0: not found
```

**Solution**: Use correct v2 import path
```go
// Wrong
github.com/xwinata/wstest/stringutils v2.0.0

// Correct  
github.com/xwinata/wstest/stringutils/v2 v2.0.0
```

### Issue 2: Import Path Conflicts

```
package github.com/xwinata/wstest/stringutils/v2 is not in GOROOT
```

**Solution**: Use import alias
```go
import stringutils "github.com/xwinata/wstest/stringutils/v2"
```

### Issue 3: Version Constraint Conflicts

```
go: github.com/xwinata/wstest/mathutils@v1.0.0: reading at revision v1.0.0: unknown revision v1.0.0
```

**Solution**: Check available versions
```bash
go list -m -versions github.com/xwinata/wstest/mathutils
```

### Issue 4: Workspace Interference

```
current directory is contained in a module that is not one of the workspace modules
```

**Solution**: Disable workspace for external testing
```bash
GOWORK=off go run main.go
GOWORK=off go build
```

## 📊 Decision Matrix

Use this matrix to decide your upgrade strategy:

| Factor | Conservative | Progressive | Selective |
|--------|-------------|-------------|-----------|
| **Risk Tolerance** | Low | High | Medium |
| **Feature Needs** | Minimal | Latest | Mixed |
| **Team Size** | Large | Small | Medium |
| **Release Frequency** | Slow | Fast | Medium |
| **Testing Resources** | Limited | Extensive | Moderate |

## 🎯 Best Practices

### 1. Version Management
- **Pin production dependencies** to exact versions
- **Use ranges for development** dependencies
- **Review updates regularly** but don't auto-update
- **Test all updates** in staging first

### 2. Dependency Hygiene
- **Keep go.mod clean** - remove unused dependencies
- **Use go mod tidy** regularly
- **Vendor critical dependencies** for important projects
- **Document version choices** in comments

### 3. Migration Planning
- **Read release notes** before upgrading
- **Test in isolation** before full migration
- **Have rollback plans** ready
- **Migrate gradually** rather than all at once

### 4. Monitoring and Maintenance
- **Track security updates** for all dependencies
- **Monitor for deprecated versions**
- **Set up automated testing** for dependency updates
- **Review dependencies quarterly**

## 🔗 Useful Commands Reference

```bash
# List current dependencies
go list -m all

# Check for available updates
go list -u -m all

# Update specific module
go get github.com/xwinata/wstest/mathutils@v1.0.1

# Update to latest patch
go get github.com/xwinata/wstest/mathutils@latest

# See module information
go mod graph
go mod why github.com/xwinata/wstest/mathutils

# Clean up dependencies
go mod tidy
go mod verify
```

This comprehensive guide should help you make informed decisions about consuming multi-module repositories effectively.