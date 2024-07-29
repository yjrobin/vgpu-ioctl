FROM harbor.4pd.io/sagegpt-aio/pk_platform/torch-benchmark:py311-53d98e3
ARG MODEL_NAME
RUN pip install --no-cache-dir numba && python install.py $MODEL_NAME
COPY ./scripts /scripts
RUN sed -i "s/{{model}}/${MODEL_NAME}/g" /scripts/run_test.sh
ENV MODEL_IN_IMAGE $MODEL_NAME
# docker build -t harbor.4pd.io/sagegpt-aio/pk_platform/torch-benchmark:py311-53d98e3-yj -f test_case_yj.dockerfile .