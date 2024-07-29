#!/bin/bash
docker login -u 'aio' -p 'Harbor@aio01' harbor.4pd.io
base_image="harbor.4pd.io/sagegpt-aio/pk_platform/torch-benchmark:py311-53d98e3"
model_list="model.list"
if [ -f $model_list ]
then
    while IFS= read -r model_name
    do
        if [ ! -z "$model_name" ]
        then
            printf '%s\n' "$model_name"
                image_name="${base_image}-${model_name}"
                echo "$image_name"
                docker push ${image_name}
        fi
    done < "$model_list"
else
    echo "model.list not exists"
    exit 1
fi
