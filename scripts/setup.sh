#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p .tools/ox-hugo .tools/hugo
stage=$(mktemp -d)
trap 'rm -rf "$stage"' EXIT
curl -fsSL https://codeload.github.com/kaushalmodi/ox-hugo/tar.gz/b7dc44dc28911b9d8e3055a18deac16c3b560b03 -o "$stage/ox-hugo.tar.gz"
tar -xzf "$stage/ox-hugo.tar.gz" -C .tools/ox-hugo --strip-components=1
curl -fsSL https://raw.githubusercontent.com/kaushalmodi/tomelr/670e0a08f625175fd80137cf69e799619bf8a381/tomelr.el -o .tools/ox-hugo/tomelr.el
if [[ "$(uname -s)" == Linux && "$(uname -m)" == x86_64 ]]; then
  curl -fsSL https://github.com/gohugoio/hugo/releases/download/v0.166.0/hugo_0.166.0_linux-amd64.tar.gz -o "$stage/hugo.tar.gz"
  curl -fsSL https://github.com/gohugoio/hugo/releases/download/v0.166.0/hugo_0.166.0_checksums.txt -o "$stage/checksums.txt"
  (cd "$stage"; mv hugo.tar.gz hugo_0.166.0_linux-amd64.tar.gz; awk '$2 == "hugo_0.166.0_linux-amd64.tar.gz"' checksums.txt > selected.txt; test -s selected.txt; sha256sum -c selected.txt)
  tar -xzf "$stage/hugo_0.166.0_linux-amd64.tar.gz" -C .tools/hugo hugo
else
  echo 'Install Hugo 0.166.0 for your platform, then run make serve.'
fi
