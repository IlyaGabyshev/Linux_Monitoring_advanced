#!/bin/bash

clear
log_file="file_log.txt"

# Запуск отсчета времени
start_time=$(date +"%Y-%m-%d %H:%M:%S.%N") # перенести в логи
start_time_count=$(date +%s.%N)

# Проверка правильности введения параметров
source check_input.sh

#Cоздание папок с файлами 
source folder_generator.sh

# для защиты команды
#cp file_log.txt /media/sf_project/DO4_LinuxMonitoring_v2.0-1/src/02
#bash main.sh tttjhg oopz.www 11Mb
#rm -r */ && rm file_log.txt 
#ssh il@127.0.0.1 -p1234