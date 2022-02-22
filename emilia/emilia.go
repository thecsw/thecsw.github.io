package main

import (
	"fmt"
	"io/ioutil"
	"log"
)

const (
	// CURR_DIR is the default directory we use.
	CURR_DIR = `.`

	RFC_EMILY = "Mon, 02 Jan 2006"
)

func main() {
	fmt.Println("Emily here! Getting the files...")
	// Get all the HTML files
	files, err := findHTMLs(CURR_DIR)
	if err != nil {
		log.Fatal(err)
	}
	// Check whether there are any files
	if len(files) < 1 {
		fmt.Println("Found no html files. Bailing out!")
		return
	}
	fmt.Printf("Found %d html files!\n", len(files))

	// Go through all the files
	for _, file := range files {
		data, err := ioutil.ReadFile(file)
		if err != nil {
			fmt.Println("Couldn't read " + file)
			continue
		}
		// Prepare the data to be written
		toWrite := string(data)

		// Add the holoscene title
		toWrite = addHolosceneTitles(file, toWrite)

		// flush the file
		if err := ioutil.WriteFile(file, []byte(toWrite), 0644); err != nil {
			fmt.Println(file + " failed flushing!")
			continue
		}
	}
	fmt.Println("chao")
}
