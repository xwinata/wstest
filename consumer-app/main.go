package main

import (
	"fmt"
	"github.com/xwinata/wstest/mathutils"
	"github.com/xwinata/wstest/stringutils"
)

func main() {
	fmt.Println("=== External Consumer Application ===")
	fmt.Println()
	
	// Use mathutils functions
	fmt.Println("Using mathutils:")
	result := mathutils.Add(10, 5)
	fmt.Printf("  mathutils.Add(10, 5) = %d\n", result)
	fmt.Printf("  mathutils.Version() = %s\n", mathutils.Version())
	fmt.Println()
	
	// Use stringutils functions
	fmt.Println("Using stringutils:")
	greeting := stringutils.HelloWorld("External User")
	fmt.Printf("  stringutils.HelloWorld(\"External User\") = %s\n", greeting)
	fmt.Printf("  stringutils.Version() = %s\n", stringutils.Version())
	fmt.Println()
	
	fmt.Println("This consumer uses:")
	fmt.Println("  - mathutils v1.0.1 (upgraded for bug fix)")
	fmt.Println("  - stringutils v1.0.0 (no changes needed)")
}