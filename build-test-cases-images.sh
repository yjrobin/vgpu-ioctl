#!/bin/bash
base_image="harbor.4pd.io/sagegpt-aio/pk_platform/torch-benchmark:py311-53d98e3"
model_list="model.list"
if [ -f $model_list ]
then
    while IFS= read -r model_name
    do
        printf '%s\n' "$model_name"
        image_name="${base_image}-${model_name}"
        echo "$image_name"
        docker build --build-arg MODEL_NAME=${model_name} -t ${image_name} -f build-test-cases-image.dockerfile .
    done < "$model_list"
else
    echo "model.list not exists"
    exit 1
fi