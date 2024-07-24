FROM harbor.4pd.io/sagegpt-aio/pk_platform/torch-benchmark:py311-53d98e3
COPY run_PASS_if_return_nonzero.sh run_PASS_if_return_zero.sh /scripts/
RUN apt install vim && apt clean
RUN pip install --no-cache-dir numba && python install.py BERT_pytorch