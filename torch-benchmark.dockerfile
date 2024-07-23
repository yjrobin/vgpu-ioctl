# git clone --recurse-submodules -b main --single-branch https://github.com/pytorch/benchmark torch-benchmark
FROM python:3.11.9-bookworm
COPY torch-benchmark /workspace/torch-benchmark
WORKDIR /workspace/torch-benchmark
RUN pip install --pre --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu121
RUN apt update && apt install libgl1 -y && apt clean
RUN python install.py

# build : docker build -t torch-benchmark:py311-`cd torch-benchmark && git rev-parse --short HEAD` -f torch-benchmark.dockerfile .
# run :
# docker run -it --rm --gpus all torch-benchmark:py311-11cf319f bash