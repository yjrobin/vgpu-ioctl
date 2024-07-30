#!/bin/bash
base_image="harbor.4pd.io/sagegpt-aio/pk_platform/torch-benchmark:py311-53d98e3"
model_list=${1:-"model.list"}
if [ -f $model_list ]
then
    while IFS= read -r model_name
    do
        if [ ! -z "$model_name" ]
        then
            printf '%s\n' "$model_name"
                image_name="${base_image}-${model_name}"
                echo "$image_name"
                DOCKER_BUILDKIT=0 docker build --build-arg MODEL_NAME=${model_name} -t ${image_name} -f build-test-cases-image.dockerfile .
        fi
    done < "$model_list"
else
    echo "$model_list not exists"
    exit 1
fi
