#!/bin/bash
file_path="../02/file_log.txt"
    start_date=$2
    start_time=$3
    end_date=$4
    end_time=$5
# проверка корректности ввода временного промежутка correct
check_time() {
if ! [[ "$1" =~ ^[0-9]{4}-(0[1-9]|1[0-2])-([0-2][0-9]|3[0-1]) && "$2" =~ ^([0-1][0-9]|2[0-3]):[0-5][0-9]$ ]]; then
        echo "ERROR! Input CORRECT date and time of creation file in format YYYY-MM-DD HH:MM. Example: '2023-12-02 16:59'"
        exit 1
    fi
}

convert_date_in_sec() {
    local start_date="$1"
    local start_time="$2"
    local date_str="$start_date $start_time"
    date -d "$date_str" +%s
}


#Удаление по времени
delete_by_time() {
    if [ -e "$file_path" ]; then
        while IFS= read -r line; do
    if [[ $line =~ CREATE\ DATA:\ ([0-9]{4}-[0-9]{2}-[0-9]{2}\ [0-9]{2}:[0-9]{2}) ]]; then #достаем дату
    date_created="${BASH_REMATCH[1]}"
    date_created=$(convert_date_in_sec "$date_created")
    fi 
    date_start_sec=$(convert_date_in_sec "$start_date" "$start_time")
    date_end_sec=$(convert_date_in_sec "$end_date" "$end_time")
    if [[ "$date_created" > "$date_start_sec" && "$date_created" < "$date_end_sec" ]]; then #сравнение
    echo "File created at: $date_of_creation is in the specified time range."
    addr=$(echo "$line" | awk '/^FILE_PATH:/ {print $1}' | sed 's/FILE_PATH://') # достаем адерс до файла и удаляем фал пас
    rm -rf $addr
    fi
        done < "$file_path"
    else
        echo "Cannot find file: $file_path"
    fi
}

# УДАЛЕНИЕ ПО ЛОГ FILE
if [[ $1 -eq 1 ]]; then
    # Проверяем существование файла
    if [ -e "$file_path" ]; then
        # Читаем файл построчно
        while IFS= read -r line; do
            # Проверяем, начинается ли строка с "FOLDER_PATH:"
            if [ "${line#FOLDER_PATH:}" != "$line" ]; then
                address="${line#FOLDER_PATH:}"
                address="${address%% | CREATE DATA: *}"
                echo "rm -rf $address"
                rm -rf $address
            fi
        done < "$file_path"
    else
        echo "Cannot find file: $file_path"
    fi
fi

# УДАЛЕНИЕ ПО ВРЕМЕНИ bash main.sh 2 2023-12-02 16:59 2023-12-02 17:02
# введены все параметры
if [[ $1 -eq 2 && $# -eq 5 ]]; then
    check_time "$start_date" "$start_time"
    check_time "$end_date" "$end_time"
    delete_by_time "$date_start_str" "$date_end_str"    
    
fi

# введен только один параметр
if [[ $1 -eq 2 && $# -eq 1 ]]; then
    read -p "Input BEGINNING date and time of creation file in format YYYY-MM-DD HH:MM:" start_date start_time
    read -p "Input ENDING date and time of creation file in format YYYY-MM-DD HH:MM:" end_date end_time
    check_time "$start_date" "$start_time"
    check_time "$end_date" "$end_time"
    delete_by_time "$date_start_str" "$date_end_str"
fi

# УДАЛЕНИЕ ПО маске

if [[ $1 -eq 3 && $# -eq 2 ]]; then
    if [ -e "$file_path" ]; then
        while IFS= read -r line; do
            filename="$2" # Имя файла, переданное как второй аргумент
                if [[ "$line" == *"/$filename " || "$line" == *"/$filename |"* ]]; then #ищем файл в логах
                addr=$(echo "$line" | awk '/^FILE_PATH:/ {print $1}' | sed 's/FILE_PATH://') # достаем адерс до файла и удаляем фал пас
                rm -rf "$addr"
            fi
        done < "$file_path"
    else
        echo "Файл не найден: $file_path"
    fi
fi