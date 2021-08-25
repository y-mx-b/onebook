#!/bin/sh

# README
pandoc ./README.org -t gfm -o ./README.md
# BookamrkManager struct
pandoc ./Documentation/org/Bookmark\ Manager/BookmarkManager.org -t gfm -o ./Documentation/Bookmark\ Manager/BookmarkManager.md
# ChromiumBookmarkManager struct
pandoc ./Documentation/org/Bookmark\ Manager/Extensions/Safari/SafariBookmarkManager.org -t gfm -o ./Documentation/Bookmark\ Manager/Extensions/Safari/SafariBookmarkManager.md
# SafariBookmarkManager struct
pandoc ./Documentation/org/Bookmark\ Manager/Extensions/Chromium/ChromiumBookmarkManager.org -t gfm -o ./Documentation/Bookmark\ Manager/Extensions/Chromium/ChromiumBookmarkManager.md

# center elements in table in README.md according to GitHub markdown
sed -i  '' -e 's/|-------------|-------------|-----------|------|/|-------------|:-----------:|:---------:|:----:|/g' README.md

# center elements in table in README.md physically
sed -i '' -e 's/| O           | X         | X    |/|      O      |     X     |   X  |/g' README.md
sed -i '' -e 's/| X           | X         | X    |/|      X      |     X     |   X  |/g' README.md
