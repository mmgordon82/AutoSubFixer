package main

import (
	"bytes"
	"flag"
	"fmt"
	"github.com/olaure/chardet"
	"golang.org/x/net/html/charset"
	"io"
	"io/ioutil"
	"log"
	"os"
	"path"
	"strings"
	"time"
)

func main() {

	// Set up flags
	fromEncoding := flag.String("from-encoding", "auto", "Manually set the source encoding to convert from (e.g windows-1255, utf-8)")
	override := flag.Bool("override", false, "Override the original file with the converted file")
	debug := flag.Bool("debug", false, "Print debug information (and save to a .log file in current working directory)")
	flag.Parse()

	if *debug {
		//Set up logging
		logFileName := fmt.Sprintf("AutoSubfixer-%s.log", time.Now().Format("2006-01-02"))
		logFile, err := os.OpenFile(logFileName, os.O_CREATE|os.O_APPEND|os.O_RDWR, 0666)
		if err != nil {
			panic(err)
		}
		mw := io.MultiWriter(os.Stdout, logFile)
		log.SetOutput(mw)
	}

	// if there are no arguments, exit the program
	if len(flag.Args()) == 0 {
		log.Fatal("No files specified!")
	}

	// Handle Flags
	for _, arg := range flag.Args() {
		filePath := arg
		var destinationPath string

		// Determine the destination path
		if *override {
			destinationPath = filePath // in case we override the original file
		} else {
			fileExtension := path.Ext(filePath)
			fileName := filePath
			if fileExtension != "" {
				fileName = strings.TrimSuffix(filePath, fileExtension)
			}
			destinationPath = fmt.Sprintf("%s-encoded%s", fileName, fileExtension)
		}

		// Read file contents
		fileData, err := os.ReadFile(filePath)
		if err != nil {
			log.Panic(err)
		}

		// Get the source encoding (eg. windows-1255, utf-8)
		sourceEncoding := *fromEncoding
		if strings.ToLower(sourceEncoding) == "auto" {
			detected := chardet.DetectShortestUTF8(fileData)
			sourceEncoding = detected.Encoding
		}

		encoder, _ := charset.Lookup(sourceEncoding)
		if encoder == nil {
			log.Panic("Unsupported encoding")
		}

		// Convert to utf-8
		strBytes := []byte(fileData)
		byteReader := bytes.NewReader(strBytes)
		reader, _ := charset.NewReaderLabel(sourceEncoding, byteReader)
		convertedData, _ := ioutil.ReadAll(reader)

		// Write the converted file
		destFile, err := os.OpenFile(destinationPath, os.O_CREATE|os.O_WRONLY, 0666)
		if err != nil {
			log.Panic("Error opening destination file")
		}
		bytesWritten, err := destFile.Write(convertedData)
		if err != nil {
			log.Panic("Error writing destination file")
		}
		destFile.Close()
		log.Printf("Processed %s (%d bytes) to %s (%d bytes) - %s\n", filePath, len(fileData), destinationPath, bytesWritten, encoder)
	}
}
