#!/bin/bash
source check.sh

for i in {1..5}
do
    if [[ $1 -eq 1 ]]; then #Все записи, отсортированные по коду ответа
        awk '{print $0}' "../04/log_$i" | sort -k9,9n > "log_${i}_sorted_by_responce" 
    fi

    if [[ $1 -eq 2 ]]; then #Все уникальные IP, встречающиеся в записях
        awk '{print $1}' "../04/log_$i" | sort | uniq -c | awk '{print $2}' >> log_unic_${i}
    fi

    if [[ $1 -eq 3 ]]; then # 3 Все запросы с ошибками (код ответа - 4хх или 5хх)
    awk '$9 ~ /^4|^5/' "../04/log_$i" >> log_filtered_by_FAIL_responce_${i}
    fi

    if [[ $1 -eq 4 ]]; then #Все уникальные IP, которые встречаются среди ошибочных запросов
    # awk '$9 ~ /^4|^5/' "../04/log_$i" | sort | uniq -c | awk '{ $1=""; print $0 }' >> log_FAIL_responce_uic_IP_${i} #вывод все строки
    awk '$9 ~ /^4|^5/ {print $1}' "../04/log_$i" | sort -u >> log_FAIL_responce_unic_IP_${i}
    fi
done





