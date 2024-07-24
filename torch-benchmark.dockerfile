# git clone --recurse-submodules -b main --single-branch https://github.com/pytorch/benchmark torch-benchmark
FROM harbor.4pd.io/sagegpt-aio/pk_platform/python:3.11.9-bullseye
COPY torch-benchmark /workspace/torch-benchmark
WORKDIR /workspace/torch-benchmark
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye main contrib" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-updates main contrib" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bullseye-backports main contrib" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/debian-security bullseye-security main contrib" >> /etc/apt/sources.list
RUN apt update && apt install libgl1 -y && apt clean
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
RUN pip install --no-cache-dir torch torchvision torchaudio --index-url https://mirror.sjtu.edu.cn/pytorch-wheels/cu121
# https://download.pytorch.org/whl/nightly/cu121
ENV HF_ENDPOINT=https://hf-mirror.com
# RUN python install.py

# build : docker build -t harbor.4pd.io/sagegpt-aio/pk_platform/torch-benchmark:py311-`cd torch-benchmark && git rev-parse --short HEAD` -f torch-benchmark.dockerfile .
# run :
# docker run -it --rm --gpus all torch-benchmark:py311-11cf319f bash
# nvidia-smi --query-accounted-apps=gpu_name,gpu_uuid,pid,time,gpu_util,mem_util,max_memory_usage --format=csv