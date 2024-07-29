FROM harbor.4pd.io/sagegpt-aio/pk_platform/torch-benchmark:py311-53d98e3
RUN pip install --no-cache-dir numba && python install.py BERT_pytorch
COPY run_PASS_if_return_nonzero.sh run_PASS_if_return_zero.sh get_max_vmem_usage.sh /scripts/

# docker build -t harbor.4pd.io/sagegpt-aio/pk_platform/torch-benchmark:py311-53d98e3-yj -f test_case_yj.dockerfile .