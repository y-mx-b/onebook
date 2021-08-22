# onebook

A universal bookmark manager (heavy WIP).

Current state:

- Import bookmarks from Chromium and Safari.

## Introduction

### How does it work?

Bookmarks are aggregated and managed under a storage directory
(`~/.bookmarks/` by default). Bookmark folders are made into
folders on the file system, while individual bookmarks are
stored as files (same as [pass](https://www.passwordstore.org)). This allows
immense freedom, as anyone can create scripts to work with bookmarks in any
language that can manipulate the file system.

## Downloading

### [Mint](https://github.com/yonaskolb/Mint)

Download mint and run the following command.

```
mint install luardemin/onebook
```

### Building from Source

NOTE: Requires [git](https://github.com/git/git) and the [Swift Package Manager](https://swift.org/package-manager/).

First, download the GitHub repository using the following command:

```
git clone https://github.com/luardemin/onebook.git
```

Then do `cd onebook` to enter the directory. You can then build with
`swift build` or run with `swift run onebook <subcommand>`.

## Basic Usage

Make sure `onebook` is on your
[path](https://www.putorius.net/set-path-variable-linux.html), then run:

```
onebook init
```

To display the help message:

```
$ onebook help
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

- [ ] Direct bookmark management
  - [ ] Adding bookmarks
  - [ ] Removing bookmarks
  - [ ] Clearing all bookmarks
- [ ] [Importing bookmarks](#importing) (in-progress)
- [ ] Exporting bookmarks
- [ ] Syncing bookmarks
- [ ] [Configuration](#configuration)/Programmability (perhaps use JavaScript
for configuration?)

#### Importing

- [X] Chromium
  - [X] Implement Chromium bookmark parsing
  - [X] Implementing Chromium bookmark data storage
- [ ] Chrome
  - Literally the same as Chromium, I just need to change file/directory paths
- [X] Safari
  - [X] Implement Safari bookmark parsing
  - [X] Implement Safari bookmark data storage
- [ ] Firefox
  - [ ] Implement Firefox bookmark parsing
  - [ ] Implement Firefox bookmark data storage
- [ ] Qutebrowser
  - [ ] Implement Qutebrowser bookmark parsing
  - [ ] Implement Qutebrowser bookmark data storage

#### Configuration

- [ ] Implement config file
  - [ ] Set default browser
  - [ ] Set custom storage directory
  - [ ] Set browsers to sync

### Browser support

| Browser     | Import From | Export To | Sync |
|-------------|:-----------:|:---------:|:----:|
| Chromium    |      O      |     X     |   X  |
| Chrome      |      X      |     X     |   X  |
| Safari      |      O      |     X     |   X  |
| Firefox     |      X      |     X     |   X  |
