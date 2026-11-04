#!/usr/bin/env bash
# Claude Code reads only ~/.claude/settings.json at user scope, so the tracked
# fragment and this machine's untracked fragment are merged into a regular file.
set -euo pipefail

dir="$HOME/.claude"
shared="$dir/settings.shared.json"
machine="$dir/settings.machine.json"
target="$dir/settings.json"

if [ -f "$machine" ]; then
  merged=$(jq -s '.[0] * .[1]' "$shared" "$machine")
else
  merged=$(jq . "$shared")
fi

# /config and plugin installs write straight to settings.json, so warn before
# discarding anything that never made it into a fragment.
if [ -f "$target" ] && ! diff -q <(jq -S . "$target") <(jq -S . <<<"$merged") >/dev/null; then
  diff -u --label current --label merged <(jq -S . "$target") <(jq -S . <<<"$merged") || true
  printf 'Overwrite %s? [y/N] ' "$target"
  read -r answer
  [ "$answer" = y ] || { echo "Aborted."; exit 1; }
fi

[ -L "$target" ] && rm "$target"
jq . <<<"$merged" >"$target.tmp" && mv "$target.tmp" "$target"
echo "Wrote $target"
