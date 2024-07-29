#!/bin/bash
bash /scripts/run_PASS_if_return_zero.sh
ret=$?
if [ $ret -eq 0 ] 
then
    output_device=`nvidia-smi --query-accounted-apps=gpu_name,max_memory_usage --format=csv | tail -n 1 | cut -d "," -f 1 | cut -d " " -f 2`
    usage=`nvidia-smi --query-accounted-apps=gpu_name,max_memory_usage --format=csv | tail -n 1 | cut -d "," -f 2 | cut -d " " -f 2`
    echo $usage > /results/${output_device}.usage
else
    echo "run failed with ret = $ret"
    exit $ret
fi