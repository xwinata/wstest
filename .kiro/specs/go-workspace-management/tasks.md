# Implementation Plan: Go Multi-Module Repository Learning System

## Overview

This implementation plan creates a simple Go multi-module repository learning system with two independent modules (`mathutils` and `stringutils`) and external consumer applications. The tasks demonstrate independent versioning, breaking changes, and selective upgrades through simple, clear examples.

## Tasks

- [x] 1. Set up multi-module repository structure
  - Create repository with separate go.mod files for mathutils and stringutils
  - Initialize go.work file for local development
  - Create basic directory structure and README
  - _Requirements: 1.1, 1.2, 1.3, 1.4_

- [ ]* 1.1 Write property test for multi-module repository structure
  - **Property 1: Multi-Module Repository Structure**
  - **Validates: Requirements 1.1, 1.2, 1.3, 1.4**

- [x] 2. Implement mathutils module
  - [x] 2.1 Create mathutils module with go.mod
    - Initialize module with `go mod init github.com/xwinata/wstest/mathutils`
    - Create math.go with Add(a, b int) int function
    - Create Multiply(a, b int) int function
    - Add Version() string function returning "v1.0.0"
    - _Requirements: 2.1, 2.4_

  - [x] 2.2 Add mathutils to workspace
    - Update go.work to include ./mathutils
    - Verify module builds correctly
    - _Requirements: 1.3_

  - [ ]* 2.3 Write unit tests for mathutils
    - Test Add function with various inputs
    - Test Multiply function with various inputs
    - Test Version function returns correct version
    - _Requirements: 2.1_

- [x] 3. Implement stringutils module
  - [x] 3.1 Create stringutils module with go.mod
    - Initialize module with `go mod init github.com/xwinata/wstest/stringutils`
    - Create strings.go with HelloWorld(name string) string function
    - Create Reverse(s string) string function
    - Add Version() string function returning "v1.0.0"
    - _Requirements: 2.2, 2.4_

  - [x] 3.2 Add stringutils to workspace
    - Update go.work to include ./stringutils
    - Verify module builds correctly
    - _Requirements: 1.3_

  - [ ]* 3.3 Write unit tests for stringutils
    - Test HelloWorld function with various names
    - Test Reverse function with various strings
    - Test Version function returns correct version
    - _Requirements: 2.2_

- [ ]* 3.4 Write property test for simple module functionality
  - **Property 2: Simple Module Functionality**
  - **Validates: Requirements 2.1, 2.2, 2.3, 2.4**

- [x] 4. Create initial module versions and tags
  - [x] 4.1 Tag initial versions
    - Commit initial mathutils and stringutils implementations
    - Create Git tag mathutils/v1.0.0
    - Create Git tag stringutils/v1.0.0
    - Push tags to demonstrate initial versioning
    - _Requirements: 3.1, 3.2_

  - [ ]* 4.2 Write property test for independent versioning
    - **Property 3: Independent Versioning**
    - **Validates: Requirements 3.1, 3.2, 3.3, 3.4**

- [x] 5. Create external consumer application
  - [x] 5.1 Set up external consumer directory
    - Create ../consumer-app/ directory outside main repository
    - Initialize with `go mod init github.com/external-user/consumer-app`
    - _Requirements: 7.1, 7.2_

  - [x] 5.2 Implement consumer application
    - Create main.go that imports both mathutils and stringutils
    - Use mathutils.Add() and stringutils.HelloWorld() functions
    - Show version information from both modules
    - Configure go.mod to use mathutils v1.0.0 and stringutils v1.0.0
    - _Requirements: 2.3, 7.3_

  - [ ]* 5.3 Write unit tests for external consumer
    - Test that consumer correctly uses both modules
    - Verify version constraints are respected
    - _Requirements: 7.1_

- [x] 6. Checkpoint - Verify basic functionality
  - Ensure both modules build and test successfully
  - Verify external consumer works with initial versions
  - Test workspace development experience
  - Ask the user if questions arise

- [x] 7. Simulate bug fix in mathutils
  - [x] 7.1 Introduce and fix bug in mathutils
    - Temporarily introduce a bug in Add function (e.g., return a + b + 1)
    - Fix the bug and update Version() to return "v1.0.1"
    - Commit changes and tag as mathutils/v1.0.1
    - _Requirements: 5.1_

  - [x] 7.2 Demonstrate selective upgrade
    - Update consumer-app to use mathutils v1.0.1
    - Keep stringutils at v1.0.0 to show independence
    - Verify consumer gets bug fix without other changes
    - _Requirements: 5.3, 5.4_

- [x] 8. Simulate breaking change in stringutils
  - [x] 8.1 Introduce breaking change
    - Change HelloWorld(name string) to HelloWorld(name, greeting string)
    - Update implementation to use custom greeting
    - Update Version() to return "v2.0.0"
    - Commit changes and tag as stringutils/v2.0.0
    - _Requirements: 4.1, 4.2_

  - [x] 8.2 Show breaking change isolation
    - Verify that consumer-app still works with stringutils v1.0.0
    - Demonstrate that mathutils v1.0.1 is unaffected by stringutils changes
    - Show how consumer can choose to stay on v1.0.0 to avoid breaking changes
    - _Requirements: 4.3, 4.4_

  - [ ]* 8.3 Write property test for breaking change isolation
    - **Property 4: Breaking Change Isolation**
    - **Validates: Requirements 4.1, 4.2, 4.3, 4.4**

- [x] 9. Create second external consumer with different version choices
  - [x] 9.1 Set up another external consumer
    - Create ../another-consumer/ directory
    - Initialize with `go mod init github.com/another-user/another-consumer`
    - _Requirements: 7.1_

  - [x] 9.2 Implement consumer with different version strategy
    - Use mathutils v1.0.1 (latest with bug fix)
    - Use stringutils v2.0.0 (adopt breaking changes)
    - Show how to handle the new HelloWorld signature
    - Demonstrate that different consumers can make different version choices
    - _Requirements: 7.4_

  - [ ]* 9.3 Write property test for selective upgrade capability
    - **Property 5: Selective Upgrade Capability**
    - **Validates: Requirements 5.1, 5.2, 5.3, 5.4**

- [ ] 10. Document workspace development experience
  - [ ] 10.1 Create development workflow documentation
    - Document how go.work enables local development
    - Show difference between workspace development and external usage
    - Provide examples of making changes and testing locally
    - _Requirements: 6.1, 6.2, 6.3, 6.4_

  - [ ]* 10.2 Write property test for workspace development experience
    - **Property 6: Workspace Development Experience**
    - **Validates: Requirements 6.1, 6.2, 6.3, 6.4**

- [ ] 11. Create comprehensive learning documentation
  - [ ] 11.1 Create main README with learning guide
    - Explain the problem multi-modules solve
    - Document the versioning timeline and examples
    - Provide step-by-step guide for understanding the concepts
    - Include commands for exploring different scenarios

  - [ ] 11.2 Document external consumer patterns
    - Show different go.mod configuration strategies
    - Explain version constraint syntax
    - Provide migration guidance for breaking changes
    - Include troubleshooting common issues

  - [ ]* 11.3 Write property test for external consumer simulation
    - **Property 7: External Consumer Simulation**
    - **Validates: Requirements 7.1, 7.2, 7.3, 7.4**

- [ ] 12. Final validation and demonstration
  - [ ] 12.1 Verify complete learning scenario
    - Test all version combinations work correctly
    - Verify workspace development vs external usage
    - Validate that breaking changes are properly isolated
    - Confirm selective upgrades solve the forced upgrade problem

  - [ ] 12.2 Create demonstration script
    - Provide script that walks through the entire scenario
    - Show git tag history and version progression
    - Demonstrate building different consumer configurations
    - Include commands to explore the multi-module benefits

- [ ] 13. Final checkpoint - Complete system validation
  - Run all tests across modules and consumers
  - Verify all version scenarios work correctly
  - Test complete learning workflow from setup to advanced concepts
  - Ensure documentation clearly explains multi-module benefits
  - Ask the user if questions arise

## Notes

- Tasks marked with `*` are optional and can be skipped for faster MVP
- Each task references specific requirements for traceability
- Focus is on simple, clear examples that demonstrate core concepts
- External consumers show real-world usage patterns
- Property tests validate universal correctness properties
- Unit tests validate specific examples and functionality
- The implementation demonstrates practical multi-module repository benefits