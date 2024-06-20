#!/bin/sh
echo -ne '\033c\033]0;StupidTestGame\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/stupid_test_game.x86_64" "$@"
