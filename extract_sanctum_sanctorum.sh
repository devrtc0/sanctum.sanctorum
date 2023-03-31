#!/usr/bin/env sh

COLORS="true"
enable_colors() {
    ALL_OFF="\e[1;0m"
    BOLD="\e[1;1m"
    GREEN="${BOLD}\e[1;32m"
    BLUE="${BOLD}\e[1;34m"

    PACMAN_COLORS='--color=always'
    PACCACHE_COLORS=''
    MAKEPKG_COLORS=''
}
info() {
    local mesg=$1; shift
    printf "${BLUE}  ->${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@"
}
error() {
    local mesg=$1; shift
    printf "${RED}==> ERROR:${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@"
}
msg() {
    local mesg=$1; shift
    printf "\n${GREEN}==>${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@"
}
[ "$COLORS" = "true" ] && enable_colors



if [ $# -eq 0 ]; then
	error 'password required'
	exit -1
fi
PASSWORD="$1"

HASH=$(printf '%s' "$PASSWORD" | shasum -a 512 | awk '{ print $1 }')
HASH=${HASH:0:64}
if [ "$HASH" != '2b54c788564c6d81101e834ce39f0e9a2b6281f3f504894c89228550ecebec68' ]; then
	error "wrong password"
	exit -1
fi

WORKDIR=$(dirname "$(readlink -f "$0")")
TARGET="$WORKDIR/.sanctum.sanctorum"

msg 'extracting sanctum.sanctorum'
printf 'U2FsdGVkX180Q8cix9aK/qAAXO94e2puaQ8DcWNmtvcqapUZ9hd5yyi8MQ0lwsftT1PWl93nzsi3E9Ug1loScw==\n' | openssl aes-256-cbc -a -d -pbkdf2 -pass "pass:$PASSWORD" -out "$TARGET"
