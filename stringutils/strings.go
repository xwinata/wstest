package stringutils

import "fmt"

// HelloWorld returns a customizable greeting message
func HelloWorld(name, greeting string) string {
	return fmt.Sprintf("%s, %s!", greeting, name)
}

// Reverse returns the reversed string
func Reverse(s string) string {
	runes := []rune(s)
	for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
		runes[i], runes[j] = runes[j], runes[i]
	}
	return string(runes)
}

// Version returns the module version
func Version() string {
	return "v2.0.0"
}