#!/bin/sh
eval "$(jq -r '@sh "used=\(.context_window.total_input_tokens // "") total=\(.context_window.context_window_size // "") dir=\(.workspace.current_dir // .cwd // "")"')"
dir=${dir:-$(pwd)}

R='\033[0m' DIM='\033[2m'
# Nerd Font git-branch glyph (U+F418), matching the starship prompt.
BRANCH_ICON='\357\220\230'

if top=$(git -C "$dir" rev-parse --show-toplevel 2>/dev/null); then
  # Detached HEAD (rebases, bisects) has no branch name, so show the commit instead.
  branch=$(git -C "$dir" branch --show-current)
  branch=${branch:-@$(git -C "$dir" rev-parse --short HEAD)}
  git -C "$dir" diff --quiet HEAD 2>/dev/null || branch="$branch*"
  printf "\033[1;36m%s$R \033[35m$BRANCH_ICON %s$R" "$(basename "$top")" "$branch"
else
  printf "\033[1;36m%s$R" "$(basename "$dir")"
fi

if [ -n "$used" ] && [ -n "$total" ]; then
  pct=$((used * 100 / total))
  if [ "$pct" -ge 80 ]; then color='\033[31m'
  elif [ "$pct" -ge 50 ]; then color='\033[33m'
  else color='\033[32m'; fi
  printf " $DIM|$R $color%dk$R $DIM(%d%%)$R" "$((used / 1000))" "$pct"
fi
