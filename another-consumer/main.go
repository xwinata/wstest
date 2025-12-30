package main

import (
	"fmt"
	"github.com/xwinata/wstest/mathutils"
	stringutils "github.com/xwinata/wstest/stringutils/v2"
)

func main() {
	fmt.Println("=== Another External Consumer Application ===")
	fmt.Println("This consumer adopts the latest versions including breaking changes")
	fmt.Println()
	
	// Use mathutils v1.0.1 (latest with bug fix)
	fmt.Println("Using mathutils v1.0.1:")
	result := mathutils.Add(20, 15)
	fmt.Printf("  mathutils.Add(20, 15) = %d\n", result)
	fmt.Printf("  mathutils.Version() = %s\n", mathutils.Version())
	fmt.Println()
	
	// Use stringutils v2.0.0 (with breaking changes)
	fmt.Println("Using stringutils v2.0.0 (with breaking changes):")
	greeting1 := stringutils.HelloWorld("Developer", "Welcome")
	greeting2 := stringutils.HelloWorld("User", "Greetings")
	fmt.Printf("  stringutils.HelloWorld(\"Developer\", \"Welcome\") = %s\n", greeting1)
	fmt.Printf("  stringutils.HelloWorld(\"User\", \"Greetings\") = %s\n", greeting2)
	fmt.Printf("  stringutils.Version() = %s\n", stringutils.Version())
	fmt.Println()
	
	fmt.Println("This consumer demonstrates:")
	fmt.Println("  - Using mathutils v1.0.1 (latest bug fix)")
	fmt.Println("  - Using stringutils v2.0.0 (adopting breaking changes)")
	fmt.Println("  - Different consumers can make different version choices")
}