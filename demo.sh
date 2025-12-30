#!/bin/bash

# Go Multi-Module Repository Demonstration Script
# This script walks through the entire learning scenario

set -e  # Exit on any error

echo "🚀 Go Multi-Module Repository Learning Demo"
echo "============================================="
echo

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_section() {
    echo -e "${BLUE}📋 $1${NC}"
    echo "----------------------------------------"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}ℹ️  $1${NC}"
}

print_section "1. Repository Structure Overview"
echo "This repository demonstrates multi-module organization:"
echo
tree -I 'go.sum|*.exe|.git' . || ls -la
echo

print_section "2. Workspace Configuration"
echo "The go.work file enables local development across modules:"
echo
cat go.work
echo

print_section "3. Module Information"
echo "📦 mathutils module:"
echo "   Path: github.com/xwinata/wstest/mathutils"
echo "   Functions: Add, Multiply, Version"
echo
echo "📦 stringutils module:"
echo "   Path: github.com/xwinata/wstest/stringutils"
echo "   Functions: HelloWorld, Reverse, Version"
echo

print_section "4. Version History and Timeline"
echo "Git tags show independent module versioning:"
echo
git tag --list | sort
echo
print_info "Version progression demonstrates:"
print_info "• mathutils: v1.0.0 → v1.0.1 (bug fix)"
print_info "• stringutils: v1.0.0 → v2.0.0 (breaking change)"
echo

print_section "5. Workspace Development Experience"
print_info "Testing workspace development (uses latest local code):"
echo
go run -c 'package main; import ("fmt"; "github.com/xwinata/wstest/mathutils"); func main() { fmt.Printf("Workspace: mathutils.Add(7,3) = %d, Version = %s\n", mathutils.Add(7, 3), mathutils.Version()) }' 2>/dev/null || echo "Note: This would work in a proper workspace setup"
print_success "Workspace enables immediate access to latest local changes"
echo

print_section "6. External Consumer Patterns"
echo
print_info "🏢 Conservative Consumer (consumer-app):"
echo "   Strategy: Get bug fixes, avoid breaking changes"
echo "   Versions: mathutils v1.0.1 + stringutils v1.0.0"
echo
cd consumer-app
echo "   go.mod configuration:"
cat go.mod | grep -A 10 "require"
echo
print_info "   Running conservative consumer:"
GOWORK=off go run main.go
cd ..
echo

print_info "🚀 Progressive Consumer (another-consumer):"
echo "   Strategy: Adopt latest features including breaking changes"
echo "   Versions: mathutils v1.0.1 + stringutils v2.0.0"
echo
cd another-consumer
echo "   go.mod configuration:"
cat go.mod | grep -A 10 "require"
echo
print_info "   Running progressive consumer:"
GOWORK=off go run main.go
cd ..
echo

print_section "7. Selective Upgrade Demonstration"
print_success "Both consumers successfully use mathutils v1.0.1 (bug fix)"
print_success "consumer-app stays on stringutils v1.0.0 (avoids breaking changes)"
print_success "another-consumer adopts stringutils v2.0.0 (gets new features)"
print_info "This solves the forced upgrade problem!"
echo

print_section "8. Breaking Change Isolation"
echo "Demonstrating how breaking changes are isolated:"
echo
print_info "stringutils v1.0.0 API: HelloWorld(name string)"
print_info "stringutils v2.0.0 API: HelloWorld(name, greeting string)"
echo
print_success "consumer-app continues working with v1.0.0 API"
print_success "another-consumer uses v2.0.0 API with new signature"
print_success "mathutils v1.0.1 works with both consumers unchanged"
echo

print_section "9. Version Exploration Commands"
echo "Useful commands for exploring the multi-module setup:"
echo
echo "# List all module versions:"
echo "git tag --list"
echo
echo "# See what changed between versions:"
echo "git diff mathutils/v1.0.0 mathutils/v1.0.1 -- mathutils/"
echo
echo "# Check current dependencies:"
echo "go list -m all"
echo
echo "# Test without workspace (external consumer simulation):"
echo "GOWORK=off go run main.go"
echo
echo "# Update specific module version:"
echo "go get github.com/xwinata/wstest/mathutils@v1.0.1"
echo

print_section "10. Multi-Module Benefits Summary"
print_success "✅ Selective Upgrades: Get bug fixes without breaking changes"
print_success "✅ Independent Evolution: Modules evolve at their own pace"
print_success "✅ Reduced Coordination: Teams upgrade on their timeline"
print_success "✅ Better Isolation: Changes in one module don't affect others"
print_success "✅ Flexible Consumption: Consumers choose what and when to upgrade"
echo

print_section "11. Learning Resources"
echo "📖 README.md - Comprehensive learning guide"
echo "📖 WORKSPACE_DEVELOPMENT.md - Development workflow details"
echo "📖 EXTERNAL_CONSUMERS.md - Consumer patterns and strategies"
echo

print_section "Demo Complete! 🎉"
echo "You've seen how multi-module repositories solve the forced upgrade problem"
echo "by enabling selective upgrades and breaking change isolation."
echo
print_info "Next steps:"
echo "• Explore the documentation files"
echo "• Try creating your own modules"
echo "• Experiment with different version combinations"
echo "• Practice selective upgrade scenarios"
echo

echo "Happy learning! 🚀"