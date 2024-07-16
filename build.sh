#!/bin/bash
rm -rf build && mkdir build
gcc -o build/vgpu_ioctl vgpu_ioctl.c
