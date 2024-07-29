#!/bin/bash
if [ -d '/results' ] 
then
	cd /workspace/torch-benchmark && python run.py -d cuda -t eval BERT_pytorch
	ret=$?
	echo "$ret"
	if [ $ret -eq 0 ]
	then
		echo "FAIL" > /results/test_case_yj.log
	else
		echo "PASS" > /results/test_case_yj.log
	fi
else
	echo "output folder /results must exists"
	exit 1
fi