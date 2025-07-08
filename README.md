# tty-airdrop

**tty-airdrop** is a lightweight command-line tool for macOS that allows you to send files over AirDrop directly from the terminal.

## Features

- Send files to nearby Apple devices via AirDrop
- No need to open Finder or use GUI manually
- Easy to integrate into scripts or automation tools

## Requirements

- macOS 10.10 or later
- AirDrop must be enabled

## Build

```bash
# Compiling
swiftc main.swift -o airdrop -framework AppKit  

# Move the compiled binary to a directory in your PATH
sudo mv airdrop /usr/local/bin

# (Optional) Disable certain input methods if you encounter issues 
echo "export IMKInputEnabled=NO" >> ~/.bashrc
source ~/.bashrc
```



## Usage

```bash
airdrop <file>
```


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.