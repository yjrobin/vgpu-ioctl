#!/bin/bash
cd /workspace/torch-benchmark && python run.py -d cuda -t eval BERT_pytorch
ret=$?
echo "$ret"
if [ $ret -ne 0 ]
then
	echo "FAIL" > /results/test_case_yj.log
else
	echo "PASS" > /results/test_case_yj.log
fi
