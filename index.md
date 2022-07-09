## About
If you live in a country whose language doesn't use the common and well-known latin alphabet, you have probably seen movie players or streamers that couldn't show your subtitles correctly.

By automatically identifying the encoding of your subtitles, AutoSubFixer can fix the encoding to the most common encoding (UTF-8), which is globally supported by most modern media players.

![Common encoding problems in subtitles](https://github.com/mmgordon82/AutoSubFixer/raw/main/assets/about1.png)

### Features:

* 💻 Automatically Identify Encoding (up to 100% confidence)
* ⚡ Lightweight and Portable (1.2MB, single file, no need to install anything)
* 😎 Supports Windows, Linux and Mac OS
* 🖖🏻 Easy to Use (Just drag-and-drop a text file to the executable or its shortcut)
* 📜 Open Source (MIT License)
* ⌨ Supports Command Line Interface (for fine tuning)

<br />

![Common encoding problems in subtitles](https://github.com/mmgordon82/AutoSubFixer/raw/main/assets/usage1.gif)

<!-- GETTING STARTED -->
## Getting Started

Setting up AutoSubFixer is super easy and only takes a minute.

### Installation (Windows)
1. Download the installer from [GitHub](https://github.com/mmgordon82/AutoSubFixer/releases/latest) (`...-Installer-win.exe`).
2. Run it and follow the instructions.
3. That's it.

### Installation (Linux & MacOS)


Download the zip from [https://github.com/mmgordon82/AutoSubFixer/releases/latest](https://github.com/mmgordon82/AutoSubFixer/releases/latest) and unzip: 
```sh
unzip AutoSubFixer-*.zip
chmod +x autosubfixer
```

Then run the executable:
```sh
./autosubfixer  
```

(Optional) For persistence, you can move it to /usr/local/bin:
```sh
sudo mv autosubfixer /usr/local/bin/
```

## Usage

### Send-To (Windows Only - for installed versions)
![Send-To](https://github.com/mmgordon82/AutoSubFixer/raw/main/assets/usage2.png)
1. Right-click the file you want to fix and select "Send to".
2. Select `AutoSubFixer` or `AutoSubFixer (Overwrite)`.

_NOTE: The difference between `AutoSubFixer` and `AutoSubFixer (Overwrite)` is that the later will overwrite the original file._

### Drag-and-drop (Windows Only)
You can also drag-and-drop your text files to the executable or its shortcut.
![Drag-and-Drop](https://github.com/mmgordon82/AutoSubFixer/raw/main/assets/usage3.gif)


### Command-line Interface
```sh
$ .\autosubfixer --help
Usage of autosubfixer:
  -debug
        Print debug information (and save to a .log file in current working directory)
  -from-encoding string
        Manually set the source encoding to convert from (e.g windows-1255, utf-8) (default "auto")
  -override
        Override the original file with the converted file
```

#### Simple usage
Auto-detects the encoding, and creates a new file `file-encoded.srt` in the same directory.
```sh
$ .\autosubfixer file.srt
```

#### Specify source-encoding
In cases where it doesn't correctly detect the encoding, you can specify the source encoding manually (e.g. windows-1255, ISO-8859-8):
```sh
$ .\autosubfixer -from-encoding windows-1255 file.srt
```

#### Override the original file
If you don't want to create the new `*-encoded` file, you can use `-override` to overwrite the original file (can't be undone):
```sh
$ .\autosubfixer -override file.srt
```

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

