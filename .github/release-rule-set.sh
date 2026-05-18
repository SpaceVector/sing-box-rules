#!/bin/bash

set -euo pipefail

: "${GITHUB_REPOSITORY:?GITHUB_REPOSITORY is required}"
: "${GITHUB_TOKEN:?GITHUB_TOKEN is required}"

REMOTE_URL="https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"

release_rule_set() {
  local source_dir="$1"
  local branch="$2"

  git -C "$source_dir" init
  git -C "$source_dir" config --local user.email "41898282+github-actions[bot]@users.noreply.github.com"
  git -C "$source_dir" config --local user.name "github-actions[bot]"
  git -C "$source_dir" remote add origin "$REMOTE_URL"
  git -C "$source_dir" branch -M "$branch"
  git -C "$source_dir" add .
  git -C "$source_dir" commit -m "Update rule-set"
  git -C "$source_dir" push -f origin "$branch"
}

release_rule_set sing-geoip/rule-set rule-set-geoip
release_rule_set sing-geosite/rule-set rule-set-geosite
