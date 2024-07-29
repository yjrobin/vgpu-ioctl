#!/bin/bash
nvidia-smi --query-accounted-apps=max_memory_usage --format=csv | tail -n 1 | cut -d " " -f 1
