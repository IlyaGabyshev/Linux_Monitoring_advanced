#!/bin/bash
log_file="file_log.txt"
name_characters_set="$2"
name_characters_set_without_ext="${name_characters_set%.*}"
name_length="${#name_characters_set_without_ext}"
size="$4"
num_files="$3"
path="$1"
date="$(date +'%d%m%y')"

# Функция создания файла
create_file() {
  source check_disk.sh
  local file_name_local="$1"
  local size="$2"
  while [ -e "$path/$file_name_local" ]; do
    file_name_local="${name_characters_set:0:1}${file_name_local}"
  done
path=$(echo "$path" | awk '{ gsub("//", "/"); print }')
file_name_local=$(echo "$file_name_local" | sed 's#^/##')  # Удаляем слеш в начале имени файла, если он есть
fallocate -l "$size" "$path$file_name_local"
log_file="file_log.txt"
echo "FILE_PATH:"$path$file_name_local" | CREATE DATA: $(stat -c %y "$path$file_name_local") | SIZE: $size" >> "$log_file"
}

 # Здесь просто получение строки имени из 4 символов и вызов функции создания файла
if [[ $name_length -eq 1 ]]; then
characters_number_one="${name_characters_set:0:1}"
  # file_name="${characters_number_one}${characters_number_one}${characters_number_one}${name_characters_set}_${date}"
  file_name="${characters_number_one}${characters_number_one}${characters_number_one}${name_characters_set}"
  file_name=$(echo "$file_name" | sed 's/\./_'$date'&/')
  
  for ((i=0; i<num_files; i++)); do
  create_file "$file_name" "$size"
  done  
fi

if [[ $name_length -eq 2 ]]; then
  characters_number_one="${name_characters_set:0:1}"
 file_name="${characters_number_one}${characters_number_one}${name_characters_set}"
 file_name=$(echo "$file_name" | sed 's/\./_'$date'&/')
  for ((i=0; i<num_files; i++)); do
    create_file "$file_name" "$size" 
  done
fi

if [[ $name_length -eq 3 ]]; then
  characters_number_one="${name_characters_set:0:1}"
  file_name="${characters_number_one}${name_characters_set}"
  file_name=$(echo "$file_name" | sed 's/\./_'$date'&/')
  for ((i=0; i<num_files; i++)); do
    create_file "$file_name" "$size"
  done
fi

if [[ $name_length -ge 4 ]]; then
  file_name="${name_characters_set}"
  file_name=$(echo "$file_name" | sed 's/\./_'$date'&/')
  for ((i=0; i<num_files; i++)); do
    create_file "$file_name" "$size"
  done
fi
