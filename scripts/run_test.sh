#!/bin/bash
# usage: run_test.sh <eval | train> <0 | 1>
# example: run_test.sh eval 0  // run the task "eval" for the model, expect to have return code "0"
#          run_test.sh train 1  // run the task "train" for the model, expect to have return code "1"
if [ "$#" -ne 2 ]
then
	echo "input invalid"
	exit 1
fi
if [ -d '/results' ] 
then
	cd /workspace/torch-benchmark && python run.py -d cuda -t $1 {{model}}
	ret=$?
	echo "$ret"
	if [ $ret -ne $2 ]
	then
		echo "FAIL" > /results/test_case_yj.log
	else
		echo "PASS" > /results/test_case_yj.log
	fi
else
	echo "output folder /results must exists"
	exit 1
fi