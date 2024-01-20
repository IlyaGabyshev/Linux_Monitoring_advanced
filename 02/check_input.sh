#!/bin/bash

# Проверяем кол-во аргументов
if [[ $# -ne 3 ]]; then
    echo "ERROR!  Need 3 parametrs "
    exit 1
fi

# Проверяем Параметр 1 список букв английского алфавита, используемый в названии папок (не более 7 знаков).
if ! [[ "$1" =~ ^[a-zA-Z]+$ ]]; then
  echo "ERROR! Characters is NOT! correct, use 'A-Z or a-z' characters "
exit 1
fi

if [[ ${#1} -gt 7 ]]; then
  echo "ERROR! Not more than 7 characters in name folder(A-Z or a-z) "
exit 1
fi


# Проверка Параметр 2 мени файла с расширением (должен содержать точку)
if ! [[ $2 =~ \..+ ]]; then
  echo "ERROR! File name is not in the correct format (name.extension)"
  exit 1
fi

# Проверка Параметр 2  имени файла (не более 7 символов)
filename=$(basename "$2" | cut -d. -f1) 
if [[ ${#filename} -gt 7 ]]; then
  echo "ERROR! File name MORE than 7 characters"
exit 1
fi
# Проверка Параметр 2 расширения файла (не более 3 символов)
extension="${2##*.}"
if [[ ${#extension} -gt 3 ]]; then
  echo "ERROR! File extension is MORE than 3 characters"
exit 1
fi

# Проверка Параметр 2: имя файла и расширение должны состоять только из букв английского алфавита
if ! [[ "$filename" =~ ^[a-zA-Z]+$ && "$extension" =~ ^[a-zA-Z]+$ ]]; then
  echo "ERROR! Filename and extension should consist of only 'A-Z or a-z' characters"
  exit 1
fi

# Проверка Параметр 3 размер файлов (в MB, но не более 100).
file_size="$3" 
if ! [[ "$file_size" =~ ^[0-9]+[mM][bB]$ ]]; then
  echo "ERROR! File size ERROR format, need xMb "
exit 1
fi
# Исправить!!!!!!

size_in_mb="${file_size%[mM][bB]}"  # Извлечение числовой части размера
if [[ "$size_in_mb" -gt 100 ]]; then
  echo "ERROR! File size limit is 100mb."
  exit 1
fi

# путь к скрипту "bin" или "sbin"
current_directory=$(pwd)
if [[ $current_directory == *"bin"* || $current_directory == *"sbin"* ]]; then
    echo "ERROR! No "bin" or "sbin" in address!"
    exit 1
fi
