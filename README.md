# onebook

A universal bookmark manager (heavy WIP).

Current state:

-   Can import bookmarks from Chromium and Safari (nested folders
    working).
    -   Haven't decided how to organize imported bookmarks for sure
-   Can manually add and remove bookmarks
    -   No bash/zsh completions as of yet (will be added eventually)

## Table of Contents

-   [Introduction](#introduction)
    -   [Why Create Onebook?](#why-create-onebook)
    -   [How Does It Work?](#how-does-it-work)
-   [Downloading](#downloading)
    -   [Mint](#mint)
    -   [Building From Source](#building-from-source)
-   [Basic Usage](#basic-usage)
-   [TODO](#todo)
    -   [Documentation](#documentation)
    -   [Functionality](#functionality)
        -   [Importing](#importing)
        -   [Configuration](#configuration)
    -   [Browser Support](#browser-support)
    -   [Miscellaneous](#miscellaneous)

## Introduction

### Why Create Onebook?

I use a lot of browsers. I regularly switch between Safari, Qutebrowser,
and Ungoogled Chromium (and sometimes Firefox as well) with little rhyme
or reason. But then, sometimes, you also want to be able to access all
your bookmarks from each browser without having to manually import and
export, or use different tools to import and export. Sometimes you also
just want to be able to hit a button and open a website, any website you
want.

The ability to easily import to and export from a single, local source,
and manage your bookmarks right from there, as well as quickly open your
bookmarks in a browser.

There is, naturally, a tool that does this.
[Buku](https://github.com/jarun/buku). But it doesn't natively support
Safari, and there are other browsers that it can't automatically import
from. Also, it's written in Python, and you must extend its capabilites
in Python (or perhaps write a wrapper for its library in another
language). Also, because it uses
[SQLite](https://sqlite.org/index.html), it is incredibly fast, but you
have to be able to parse SQLite databases in order to interact with the
data yourself, without Buku.

(I'm sure there are other tools out there, and I'm sure Buku is an
incredible bookmark manager as well. It just didn't suit me all too
well, and I thought creating a bookmark manager I'd like would be an
interesting project.)

Enter Onebook.

Just like [pass](https://www.passwordstore), the standard Unix password
manager, Onebook uses the filesystem to store its data in a very UNIX-y
way (perhaps I'll consider adding encryption to bookmarks as well,
though I don't see why that'd be necessary). That way, anyone can create
scripts to interact with the data in just about any language. Python,
Perl, JavaScript, or just plain shell—all of it works just as well.
Anything that can interact with files and directories will be just as
capable.

### How Does It work?

**NOTE: This description may not be accurate, as Onebook is still under
heavy** **development. Please refer to the information under
[Functionality](#functionality) in order to** **get an accurate grasp of
where Onebook is currently at.**

First, Onebook will parse bookmarks from any browser of your choosing.
Since each browser has its own method for storing bookmarks, there is a
lot of work that goes into writing parsers for each browser's bookmark
system.

Onebook will also be able to take Netscape-style HTML bookmark files
(just about every browser allows you to export to Netscape-compatible
HTML).

Bookmarks are aggregated and managed under a storage directory
(`~/.bookmarks/` by default).

Bookmark folders are made into folders on the filesystem, while
individual bookmarks are stored as files with the bookmark's title as
the file's name. Any data pertaining to the bookmark will be stored
within the file (currently, in TOML).

You will be able to edit this data manually, or through Onebook.

You can then export bookmarks from Onebook to any of the formats
supported browsers use to store their own bookmarks, or to HTML. You
will also be able to automatically sync bookmarks between browsers with
a single command: `onebook sync`.

## Downloading

### [Mint](https://github.com/yonaskolb/Mint)

Download mint and run the following command.

    mint install luardemin/onebook

### Building From Source

**NOTE: Requires [git](https://github.com/git/git) and the [Swift
Package Manager](https://swift.org/package-manager/).**

First, download the GitHub repository using the following command:

    git clone https://github.com/luardemin/onebook.git

Then do `cd onebook` to enter the directory. You can then build with
`swift
build` or run with `swift run onebook <subcommand>`.

## Basic Usage

Make sure `onebook` is on your
[path](https://www.putorius.net/set-path-variable-linux.html), then run:

    onebook init

To display the help message:

    $ onebook -h

    OVERVIEW: A universal bookmark management utility.

    USAGE: onebook <subcommand>

    OPTIONS:
      -h, --help              Show help information.

    SUBCOMMANDS:
      import                  Import bookmarks from a browser.
      init                    Initialize the program.

      See 'onebook help <subcommand>' for detailed help.

## TODO

### Documentation

-   [x]
    [Back-End](./Documentation/Bookmark Manager/BookmarkManager.md)
    -   Very much in-progress, nowhere near complete
-   [x] Manpage
    -   Will write a script to automatically install it
    -   Someday soon
-   [x] Incredibly cryptic help message (will be expanded once more
    functionality is implemented)
    -   a Unix classic, along with [beatifully uninformative error
        messages](https://www.gnu.org/fun/jokes/ed-msg.html)

### Functionality

-   [ ] Direct bookmark management (WIP)
    -   [x] Adding bookmarks
    -   [ ] Removing bookmarks
    -   [ ] Moving bookmarks
    -   [ ] Purging empty bookmark folders
    -   [ ] Clearing all bookmarks
-   [ ] [Importing bookmarks](#importing)
    -   In-progress, code must be refactored to handle nested folders (I
        forgot about those)
-   [ ] Exporting bookmarks
-   [ ] Syncing bookmarks
-   [ ] Backups (for browsers and aggregate storage)
-   [ ] [Configuration](#configuration) (shell commands to set
    preferences in a plist?)

1.  Importing

    -   [x] Chromium
        -   [x] Implement Chromium bookmark parsing
        -   [x] Implementing Chromium bookmark data storage
    -   [x] Chrome
        -   Literally the same as Chromium, I just need to change
            file/directory paths
    -   [x] Safari
        -   [x] Implement Safari bookmark parsing
        -   [x] Implement Safari bookmark data storage
    -   [x] Brave
        -   Also literally the same as Chromium
    -   [ ] Firefox (this might take a while, I *really* don't want to
        have to learn SQL)
        -   [ ] Implement Firefox bookmark parsing
        -   [ ] Implement Firefox bookmark data storage
    -   [ ] Qutebrowser (shouldn't be that bad)
        -   [ ] Implement Qutebrowser bookmark parsing
        -   [ ] Implement Qutebrowser bookmark data storage
    -   [ ] Min (this will take a long time)
        -   [ ] Implement Min bookmark parsing
        -   [ ] Implement Min bookmark data storage

2.  Configuration

    -   [ ] Implement config file
        -   [ ] Set default browser for import/export
        -   [ ] Set custom storage directory
        -   [ ] Set default browsers to sync
    -   [ ] Allow for relocation of bookmark directory

### Browser support

**Ordered by priority**

| Browser     | Import From | Export To | Sync |
|-------------|:-----------:|:---------:|:----:|
| Chromium    |      O      |     X     |   X  |
| Chrome      |      O      |     X     |   X  |
| Safari      |      O      |     X     |   X  |
| Brave       |      O      |     X     |   X  |
| Edge        |      X      |     X     |   X  |
| Qutebrowser |      X      |     X     |   X  |
| Firefox     |      X      |     X     |   X  |
| Min         |      X      |     X     |   X  |

### Operating System Support

**Ordered by priority**

| Operating System | Compiles | Functional |
|------------------|:--------:|:----------:|
| macOS            |     O    |      O     |
| Ubuntu           |     O    |      O     |
| Windows          |     ?    |      ?     |

**Note: I can't get Windows to compile for me. If anyone can, that'd be
a great** **help.**

### Miscellaneous

-   [ ] An install script
-   [ ] Maybe a homebrew formula?
-   [ ] bash/zsh autocomplete
