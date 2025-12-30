package mathutils

// Add returns the sum of two integers
func Add(a, b int) int {
	return a + b // Fixed: Removed the extra +1
}

// Multiply returns the product of two integers
func Multiply(a, b int) int {
	return a * b
}

// Version returns the module version
func Version() string {
	return "v1.0.1"
}