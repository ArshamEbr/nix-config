#!/bin/bash
DEVICE=$1
MOUNT_POINT="/media/mtp-$DEVICE"

mkdir -p "$MOUNT_POINT"
jmtpfs -device="$DEVICE" "$MOUNT_POINT"
