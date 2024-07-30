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
                echo "get gpu usage in $image_name"
                docker run --rm --gpus all -v `pwd`/${HOSTNAME}:/results $image_name /scripts/get_max_vmem_usage.sh eval
                docker run --rm --gpus all -v `pwd`/${HOSTNAME}:/results $image_name /scripts/get_max_vmem_usage.sh train
        fi
    done < "$model_list"
else
    echo "$model_list not exists"
    exit 1
fi
