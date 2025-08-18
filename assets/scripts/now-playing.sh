#!/bin/bash

escape_markup() {
    local text="$1"
    text="${text//&/&amp;}"
    text="${text//</&lt;}"
    text="${text//>/&gt;}"
    echo "$text"
}

title=$(playerctl metadata title 2>/dev/null)
artist=$(playerctl metadata artist 2>/dev/null)

if [ -n "$title" ]; then
    output="$title"
    if [ -n "$artist" ]; then
        output="$artist - $title"
    fi
    escape_markup "$output"
else
    echo ""
fi
