# onebook

A universal bookmark manager (heavy WIP, nothing works).

## Introduction

### Downloading

#### Binary

#### Homebrew

#### Mint

#### Building from Source

NOTE: Requires `git` and the Swift Package Manager.

First, download the GitHub repository using the following command:

```sh
$ git clone https://github.com/luardemin/onebook.git
```

Then, build with `swift build` or run with `swift run onebook <subcommand>`.

### Basic Usage

Make sure `onebook` is on your path, then run:

```sh
$ onebook init
```

Help message:

```
OVERVIEW: A universal bookmark management utility.

USAGE: onebook <subcommand>

OPTIONS:
  -h, --help              Show help information.

SUBCOMMANDS:
  import                  Import bookmarks from a browser.
  init                    Initialize the program.

  See 'onebook help <subcommand>' for detailed help.
```

## TODO

### Functionality

- [X] Implement Chromium bookmark parsing
- [ ] Implementing Chromium bookmark data storage
- [-] Implmenting config file

### Browser support

- [ ] Chromium
- [ ] Chrome
- [ ] Safari
- [ ] Firefox
- [ ] Qutebrowser
