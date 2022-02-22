package main

import (
	"fmt"
	"strings"
)

const (
	styleOpen  = "<style>"
	styleClose = "</style>"
)

// removeStyleSection removes everything that's in <style>
func removeStyleSection(file, data string) string {
	lines := strings.Split(data, "\n")
	start, end := -1, -1
	for i, line := range lines {
		if strings.Contains(line, styleOpen) {
			start = i
		}
		if strings.Contains(line, styleClose) {
			end = i
		}
	}
	if start == -1 || end == -1 {
		fmt.Printf("[STYLES] %s: failed to find style section\n", file)
		return data
	}
	// Asciidoctor styling is somewhat around 400+ lines of styling
	if end-start < 400 {
		fmt.Printf("[STYLES] %s: asciidoctor style not found\n", file)
		return data
	}
	fmt.Printf("[STYLES] %s: deleted %d lines of extra styling\n", file, end-start)
	return strings.Join(append(lines[:start], lines[end+1:]...), "\n")
}
