#!/bin/sh


echo "Process bench"
./pipe_ipc_proc.16k.out  1>./pipe_ipc_proc.16k.csv
./pipe_ipc_proc.20k.out  1>./pipe_ipc_proc.20k.csv
./pipe_ipc_proc.24k.out  1>./pipe_ipc_proc.24k.csv
./pipe_ipc_proc.28k.out  1>./pipe_ipc_proc.28k.csv
./pipe_ipc_proc.32k.out  1>./pipe_ipc_proc.32k.csv
./pipe_ipc_proc.40k.out  1>./pipe_ipc_proc.40k.csv
./pipe_ipc_proc.48k.out  1>./pipe_ipc_proc.48k.csv
./pipe_ipc_proc.56k.out  1>./pipe_ipc_proc.56k.csv
./pipe_ipc_proc.64k.out  1>./pipe_ipc_proc.64k.csv
./pipe_ipc_proc.80k.out  1>./pipe_ipc_proc.80k.csv
./pipe_ipc_proc.96k.out  1>./pipe_ipc_proc.96k.csv
./pipe_ipc_proc.112k.out 1>./pipe_ipc_proc.112k.csv
./pipe_ipc_proc.128k.out 1>./pipe_ipc_proc.128k.csv
./pipe_ipc_proc.160k.out 1>./pipe_ipc_proc.160k.csv
./pipe_ipc_proc.192k.out 1>./pipe_ipc_proc.192k.csv
./pipe_ipc_proc.224k.out 1>./pipe_ipc_proc.224k.csv
./pipe_ipc_proc.256k.out 1>./pipe_ipc_proc.256k.csv
./pipe_ipc_proc.320k.out 1>./pipe_ipc_proc.320k.csv
./pipe_ipc_proc.384k.out 1>./pipe_ipc_proc.384k.csv
./pipe_ipc_proc.448k.out 1>./pipe_ipc_proc.448k.csv
./pipe_ipc_proc.512k.out 1>./pipe_ipc_proc.512k.csv

echo "Thread bench"
./pipe_ipc_thd.16k.out  1>./pipe_ipc_thd.16k.csv
./pipe_ipc_thd.20k.out  1>./pipe_ipc_thd.20k.csv
./pipe_ipc_thd.24k.out  1>./pipe_ipc_thd.24k.csv
./pipe_ipc_thd.28k.out  1>./pipe_ipc_thd.28k.csv
./pipe_ipc_thd.32k.out  1>./pipe_ipc_thd.32k.csv
./pipe_ipc_thd.40k.out  1>./pipe_ipc_thd.40k.csv
./pipe_ipc_thd.48k.out  1>./pipe_ipc_thd.48k.csv
./pipe_ipc_thd.56k.out  1>./pipe_ipc_thd.56k.csv
./pipe_ipc_thd.64k.out  1>./pipe_ipc_thd.64k.csv
./pipe_ipc_thd.80k.out  1>./pipe_ipc_thd.80k.csv
./pipe_ipc_thd.96k.out  1>./pipe_ipc_thd.96k.csv
./pipe_ipc_thd.112k.out 1>./pipe_ipc_thd.112k.csv
./pipe_ipc_thd.128k.out 1>./pipe_ipc_thd.128k.csv
./pipe_ipc_thd.160k.out 1>./pipe_ipc_thd.160k.csv
./pipe_ipc_thd.192k.out 1>./pipe_ipc_thd.192k.csv
./pipe_ipc_thd.224k.out 1>./pipe_ipc_thd.224k.csv
./pipe_ipc_thd.256k.out 1>./pipe_ipc_thd.256k.csv
./pipe_ipc_thd.320k.out 1>./pipe_ipc_thd.320k.csv
./pipe_ipc_thd.384k.out 1>./pipe_ipc_thd.384k.csv
./pipe_ipc_thd.448k.out 1>./pipe_ipc_thd.448k.csv
./pipe_ipc_thd.512k.out 1>./pipe_ipc_thd.512k.csv
