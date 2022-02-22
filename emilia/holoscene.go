package main

import (
	"fmt"
	"io/fs"
	"path/filepath"
	"regexp"
	"strconv"
	"strings"
	"time"
)

var (
	HEregex          = regexp.MustCompile(`(\d+);\s*(\d+)\s*H.E.`)
	HEParagraphRegex = regexp.MustCompile(`>(\d+;\s*\d+\s*H.E.)`)
)

// findHTMLs returns a slice of all html files in a given directory (recursively).
func findHTMLs(dir string) ([]string, error) {
	files := make([]string, 0, 32)
	err := filepath.Walk(dir, func(path string, info fs.FileInfo, err error) error {
		if err != nil {
			fmt.Println(err)
			return err
		}
		if !info.IsDir() && filepath.Ext(path) == ".html" {
			files = append(files, path)
		}
		return nil
	})
	return files, err
}

// convertHoloscene takes a Holoscene time (127; 12022 H.E.) to a time struct.
func convertHoloscene(HEtime string) *time.Time {
	matches := HEregex.FindAllStringSubmatch(HEtime, 1)
	// Not a good match, nothing found
	if len(matches) < 1 {
		return nil
	}
	// By the regex, we are guaranteed to have good numbers
	day, _ := strconv.Atoi(matches[0][1])
	year, _ := strconv.Atoi(matches[0][2])
	// Subtract the 10k holoscene years
	year -= 10000

	tt := time.Date(year, time.January, 0, 0, 0, 0, 0, time.Local)
	tt = tt.Add(time.Duration(day) * 24 * time.Hour)
	return &tt
}

func addHolosceneTitles(file, data string) string {
	// Match all paragraphs with holoscene time
	matches := HEParagraphRegex.FindAllStringSubmatch(data, -1)
	// No matches found, skip this file
	if len(matches) < 1 {
		//fmt.Println(file + " doesn't need replacements")
		return data
	}
	for _, match := range matches {
		HEtime := match[1]
		tt := convertHoloscene(HEtime)
		// Add the title to the paragraph
		data = strings.ReplaceAll(data,
			`>`+HEtime,
			` title="`+tt.Format(RFC_EMILY)+`">`+HEtime,
		)
	}
	fmt.Printf("%s: replaced %d \n", file, len(matches))
	return data

}
