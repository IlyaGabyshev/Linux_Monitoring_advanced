#!/bin/bash
source check.sh


    if [[ $1 -eq 1 ]]; then #Все записи, отсортированные по коду ответа 13 поле смотри 

        goaccess -f $(pwd)/../04/log_1 $(pwd)/../04/log_2 $(pwd)/../04/log_3 $(pwd)/../04/log_4 $(pwd)/../04/log_5  -o log_1.html --log-format=COMBINED
        goaccess -f $(pwd)/../04/log_1 $(pwd)/../04/log_2 $(pwd)/../04/log_3 $(pwd)/../04/log_4 $(pwd)/../04/log_5 --log-format=COMBINED


    fi

    if [[ $1 -eq 2 ]]; then # Все уникальные IP, встречающиеся в записях  игнорируем пауков 5 поле смотри
        goaccess -f $(pwd)/../04/log_1 $(pwd)/../04/log_2 $(pwd)/../04/log_3 $(pwd)/../04/log_4 $(pwd)/../04/log_5 -o log_2.html --log-format=COMBINED --ignore-crawlers -c      
        goaccess -f $(pwd)/../04/log_1 $(pwd)/../04/log_2 $(pwd)/../04/log_3 $(pwd)/../04/log_4 $(pwd)/../04/log_5 --log-format=COMBINED --ignore-crawlers -c

    fi


    if [[ $1 -eq 3 ]]; then # 3 Все запросы с ошибками (код ответа - 4хх или 5хх)  13 поле смотри 
        goaccess -f $(pwd)/../04/log_1 $(pwd)/../04/log_2 $(pwd)/../04/log_3 $(pwd)/../04/log_4 $(pwd)/../04/log_5 -o log_3.html --log-format=COMBINED --ignore-crawlers --ignore-status=200 --ignore-status=201
        goaccess -f $(pwd)/../04/log_1 $(pwd)/../04/log_2 $(pwd)/../04/log_3 $(pwd)/../04/log_4 $(pwd)/../04/log_5 --log-format=COMBINED --ignore-crawlers --ignore-status=200 --ignore-status=201 

    fi

    if [[ $1 -eq 4 ]]; then #Все уникальные IP, которые встречаются среди ошибочных запросов
     goaccess -f $(pwd)/../04/log_1 $(pwd)/../04/log_2 $(pwd)/../04/log_3 $(pwd)/../04/log_4 $(pwd)/../04/log_5 -o log_4.html--log-format=COMBINED --ignore-crawlers --ignore-status=200 --ignore-status=201 
     goaccess -f $(pwd)/../04/log_1 $(pwd)/../04/log_2 $(pwd)/../04/log_3 $(pwd)/../04/log_4 $(pwd)/../04/log_5 --log-format=COMBINED --ignore-crawlers --ignore-status=200 --ignore-status=201
    fi






