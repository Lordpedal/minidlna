#!/bin/bash

set -euo pipefail

arch="$1"

case "$arch" in
amd64) base_image="balenalib/amd64-alpine:latest" ;;
i386) base_image="balenalib/i386-alpine:latest" ;;
arm) base_image="balenalib/armv7hf-alpine:latest" ;;
armv7) base_image="balenalib/armv7hf-alpine:latest" ;;
aarch64) base_image="balenalib/aarch64-alpine:latest" ;;
esac

sed "1cFROM $base_image" Dockerfile >"Dockerfile.$arch"
