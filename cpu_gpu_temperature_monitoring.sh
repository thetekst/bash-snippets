#!/bin/bash
#
# . ~/bash/bash-snippets/cpu_gpu_temperature_monitoring.sh
COUNTER=1

PREV_GPU=0
CURRENT_GPU=0

PREV_CPU0=0
CURRENT_CPU0=0

PREV_CPU1=0
CURRENT_CPU1=0

function counter_log {
	echo "$1" > /home/$USER/wd320win/linux_temperature_monitoring/counter
}

function gpu_log {
	echo "$1" > /home/$USER/wd320win/linux_temperature_monitoring/gpu
}

function cpu0_log {
	echo "$1" > /home/$USER/wd320win/linux_temperature_monitoring/cpu0
}

function cpu1_log {
	echo "$1" > /home/$USER/wd320win/linux_temperature_monitoring/cpu1
}

function get_gpu {
	CURRENT_GPU=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)
	echo "GPU: $CURRENT_GPU"
	let CURRENT_GPU=$PREV_GPU+$CURRENT_GPU
	PREV_GPU=$CURRENT_GPU
}

function get_cpu0 {
	CURRENT_CPU0=$(cat /sys/class/thermal/thermal_zone0/temp | cut -c -2)
	echo "CPU 0: $CURRENT_CPU0"
	let CURRENT_CPU0=$PREV_CPU0+$CURRENT_CPU0
	PREV_CPU0=$CURRENT_CPU0
}

function get_cpu1 {
	CURRENT_CPU1=$(cat /sys/class/thermal/thermal_zone1/temp | cut -c -2)
	echo "CPU 1: $CURRENT_CPU1"
	let CURRENT_CPU1=$PREV_CPU1+$CURRENT_CPU1
	PREV_CPU1=$CURRENT_CPU1
}

while true; do
	get_gpu
	get_cpu0
	get_cpu1
	# expr 1240 / 20 

	echo "COUNTER: $COUNTER"
	
	counter_log $COUNTER
	gpu_log $CURRENT_GPU
	cpu0_log $CURRENT_CPU0
	cpu1_log $CURRENT_CPU1

	echo '----'
	echo 'the arithmetic mean'
	echo "GPU" `expr $CURRENT_GPU / $COUNTER`
	echo "CPU0" `expr $CURRENT_CPU0 / $COUNTER`
	echo "CPU1" `expr $CURRENT_CPU1 / $COUNTER`
	echo

	echo "Press [CTRL+C] to stop.."
	echo
	let COUNTER=COUNTER+1
	sleep 2
done

