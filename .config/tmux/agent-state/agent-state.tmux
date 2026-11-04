#!/usr/bin/env bash
# Replaces #{claude_dots} in the window status formats with one colored dot per
# pane in the window that has Claude Code state (see bin/claude-state).

dir=$(cd "$(dirname "$0")" && pwd)

dot=$(printf '\xe2\x97\x8f')
dots="#{P:#{?#{@claude_state},#[fg=#{@claude_color}#,nobold] $dot,}}"

for option in window-status-format window-status-current-format; do
  format=$(tmux show -gv "$option")
  tmux set -g "$option" "${format//'#{claude_dots}'/$dots}"
done

# Green means "finished and not yet seen", so looking at the pane demotes it.
tmux set-hook -g pane-focus-in "if -F '#{==:#{@claude_state},done}' 'run-shell -b \"$dir/bin/claude-state idle #{pane_id}\"'"
