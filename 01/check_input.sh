#!/bin/bash

# Проверяем кол-во аргументов
if [[ $# -ne 6 ]]; then
    echo "ERROR!  Need 6 parametrs "
    exit 1
fi


# Проверяем является ли параметр Параметр 1 абсолютным путем &&  такой путь / такая папка существует
path=$(echo "$1" | sed 's:/$::')
if ! [[ -d "$path" ]]; then
  echo "ERROR! Path does NOT exist"
  exit 1
fi

if ! [[ $(realpath -s "$path") == "$path" ]]; then
  echo "ERROR! Path is NOT absolutely"
  exit 1
fi

# Проверяем Параметр 2 количество вложенных папок.
if ! [[ "$2" -gt 0 ]]; then
  echo "ERROR! Folder count is NOT! correct"
exit 1
fi

# Проверяем Параметр 3 список букв английского алфавита, используемый в названии папок (не более 7 знаков).
if ! [[ "$3" =~ ^[a-zA-Z]+$ ]]; then
  echo "ERROR! Characters is NOT! correct, use 'A-Z or a-z' characters "
exit 1
fi

if [[ ${#3} -gt 7 ]]; then
  echo "ERROR! Not more than 7 characters in name folder(A-Z or a-z) "
exit 1
fi

# Проверяем Параметр 4 количество файлов в каждой созданной папке.

if ! [[ "$4" -gt 0 ]]; then
  echo "ERROR! Folder count is NOT! correct"
exit 1
fi

# Проверка Параметр 5 мени файла с расширением (должен содержать точку)
if ! [[ $5 =~ \..+ ]]; then
  echo "ERROR! File name is not in the correct format (name.extension)"
  exit 1
fi

# Проверка Параметр 5  имени файла (не более 7 символов)
filename=$(basename "$5" | cut -d. -f1) 
if [[ ${#filename} -gt 7 ]]; then
  echo "ERROR! File name MORE than 7 characters"
exit 1
fi
# Проверка Параметр 5 расширения файла (не более 3 символов)
extension="${5##*.}"
if [[ ${#extension} -gt 3 ]]; then
  echo "ERROR! File extension is MORE than 3 characters"
exit 1
fi

# Проверка Параметр 5: имя файла и расширение должны состоять только из букв английского алфавита
if ! [[ "$filename" =~ ^[a-zA-Z]+$ && "$extension" =~ ^[a-zA-Z]+$ ]]; then
  echo "ERROR! Filename and extension should consist of only 'A-Z or a-z' characters"
  exit 1
fi

# Проверка Параметр 6 размер файлов (в килобайтах, но не более 100).
file_size="$6" 
if ! [[ "$file_size" =~ ^[0-9]+[kK][bB]$ ]]; then
  echo "ERROR! File size ERROR format, need xkb "
exit 1
fi
# Исправить!!!!!!

size_in_kb="${file_size%[kK][bB]}"  # Извлечение числовой части размера
if [[ "$size_in_kb" -gt 100 ]]; then
  echo "ERROR! File size limit is 100kb."
fi