#!/bin/bash
rm -rf /tmp/vgpulock && mkdir -p /tmp/vgpulock && chmod a+w /tmp/vgpulock
sudo rm -rf /usr/share/vgpu && sudo cp vgpu /usr/share/ -r
# docker run -it --rm --gpus 'device=0' \
#     -e CUDA_DEVICE_MEMORY_LIMIT=2048m \
#     -e LD_PRELOAD=/usr/local/vgpu/libvgpu.so \
#     -v /usr/share/vgpu/libvgpu.so:/usr/local/vgpu/libvgpu.so \
#     -v /tmp/vgpulock:/tmp/vgpulock \
#     nvcr.io/nvidia/pytorch:24.02-py3 \
#     bash

