#!/usr/bin/env sh

WORKDIR=$(dirname "$(readlink -f "$0")")
cd "$WORKDIR"

git remote set-url origin git@github.com:devrtc0/sanctum.sanctorum.git
git remote add gitlab git@gitlab.com:devrtc0/sanctum.sanctorum.git
git remote add codeberg git@codeberg.org:devrtc0/sanctum.sanctorum.git
git remote add flic git@gitflic.ru:devrtc0/sanctum-sanctorum.git
