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
swiftc main.swift -o airdrop -framework AppKit  

sudo mv airdrop /usr/local/bin
```


## Usage

```bash
airdrop <file>
```