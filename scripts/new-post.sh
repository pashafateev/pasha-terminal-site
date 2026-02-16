#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  npm run post:new -- "Post Title" ["Post description"] ["tag1,tag2"]

Examples:
  npm run post:new -- "Shipping Beats Perfection"
  npm run post:new -- "Friday Notes" "Quick update on this week's progress" "notes,weekly"
USAGE
}

if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
  usage
  exit 0
fi

if [ "$#" -lt 1 ]; then
  usage
  exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Error: run this inside the git repo."
  exit 1
fi

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "Error: working tree is not clean. Commit/stash changes before creating a post."
  exit 1
fi

title="$1"
description="${2:-Quick placeholder description. Replace with your real summary.}"
tags_csv="${3:-notes}"
pub_date="$(date -u +%F)"

slug="$(printf '%s' "$title" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//')"
if [ -z "$slug" ]; then
  slug="post-$(date -u +%s)"
fi

branch="content/post-${slug}"
file="src/content/blog/${pub_date}-${slug}.md"

if [ -e "$file" ]; then
  echo "Error: post file already exists: $file"
  exit 1
fi

git switch -c "$branch"

declare -a tag_items=()
IFS=',' read -r -a raw_tags <<< "$tags_csv"
for raw_tag in "${raw_tags[@]}"; do
  trimmed="$(printf '%s' "$raw_tag" | sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//')"
  if [ -n "$trimmed" ]; then
    tag_items+=("\"$trimmed\"")
  fi
done

if [ "${#tag_items[@]}" -eq 0 ]; then
  tag_items+=("\"notes\"")
fi

tags_joined="$(IFS=', '; echo "${tag_items[*]}")"

cat > "$file" <<POST
---
title: "$title"
description: "$description"
pubDate: $pub_date
tags: [$tags_joined]
---

This post was created with the quick-post script.

Write your candid notes here.
POST

git add "$file"
git commit -m "Add blog post: $title"
git push -u origin "$branch"

if command -v gh >/dev/null 2>&1; then
  pr_body_file="$(mktemp)"
  cat > "$pr_body_file" <<PR
## Summary
- add new blog post: $title
- file: $file

## Verification
- npm run build
PR

  gh pr create \
    --base main \
    --head "$branch" \
    --title "content: add post '$title'" \
    --body-file "$pr_body_file"

  rm -f "$pr_body_file"
else
  echo "gh CLI not found; create PR manually:"
  echo "https://github.com/$(git config --get remote.origin.url | sed -E 's#(git@github.com:|https://github.com/)##; s/\.git$//')/compare/main...${branch}?expand=1"
fi
