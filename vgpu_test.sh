docker run -it --rm --name yj-vgpu-test \
    --gpus 'device=0' \
    -e CUDA_DEVICE_MEMORY_LIMIT=2048m \
    -e LD_PRELOAD=/usr/local/vgpu/libvgpu.so \
    -v /usr/share/vgpu/libvgpu.so:/usr/local/vgpu/libvgpu.so \
    -v /tmp/vgpulock:/tmp/vgpulock \
    -v $HOME/benchmark:/benchmark \
    nvcr.io/nvidia/pytorch:24.02-py3 \
    bash

docker run -it --rm --name yj-vgpu-test \
    --gpus all \
    -e CUDA_DEVICE_MEMORY_LIMIT=1000m \
    -e LD_PRELOAD=/usr/local/vgpu/libvgpu.so \
    -v /usr/share/vgpu/libvgpu.so:/usr/local/vgpu/libvgpu.so \
    -v /tmp/vgpulock:/tmp/vgpulock \
    -v `pwd`/results:/results \
    --shm-size 1g \
    harbor.4pd.io/sagegpt-aio/pk_platform/torch-benchmark:py311-53d98e3-test-BERT_pytorch-yj \
    bash /scripts/run_PASS_if_return_nonzero.sh

docker run -it --rm --name yj-vgpu-test \
    --gpus all \
    -e CUDA_DEVICE_MEMORY_LIMIT=512m \
    -e LD_PRELOAD=/usr/local/vgpu/libvgpu.so \
    -v /usr/share/vgpu/libvgpu.so:/usr/local/vgpu/libvgpu.so \
    -v /tmp/vgpulock:/tmp/vgpulock \
    -v `pwd`/results:/results \
    --shm-size 1g \
    harbor.4pd.io/sagegpt-aio/pk_platform/torch-benchmark:py311-53d98e3-test-BERT_pytorch-yj \
    bash /scripts/run_PASS_if_return_nonzero.sh

# 'vm': {'vmid': 'd0-470', 'ip': '172.28.103.41'}
# 'vm': {'vmid': 'd0-471', 'ip': '172.28.103.42'}
