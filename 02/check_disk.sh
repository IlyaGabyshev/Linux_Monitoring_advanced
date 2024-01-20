#!/bin/bash

MIN_FREE_SPACE_GB=1
FREE_SPACE=$(df -BG / | awk 'NR==2 {print $4}' | tr -d 'G')
if  [ "$FREE_SPACE" -le "$MIN_FREE_SPACE_GB" ]; then
echo NO SPACE 4 linux monitoring_2 !!!


# Завершение отсчета времени + вывод
end_time=$(date +"%Y-%m-%d %H:%M:%S.%N") # перенести в логи
end_time_count=$(date +%s.%N)
echo start_time:$start_time 
echo end_time:$end_time 
execution_time=$(echo "$end_time_count - $start_time_count" | bc ) # перенести в логи
LC_NUMERIC=C printf "Script execution time (in seconds) = %.2f\n" $execution_time # перенести в логи
echo "start_time: $start_time | end_time: $end_time | execution_time: $execution_time " >> "$log_file"

exit 1
fi

