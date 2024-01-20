# #!/bin/bash

folder_characters_set="$1"
folder_length="${#folder_characters_set}"
num_folders=$(shuf -i 1-100 -n 1)
path=$(pwd)
size="$3"
file_characters_set="$2"
date="$(date +'%d%m%y')"

# Функция для создания папки с уникальным именем
create_folder() {  
  num_files=$((1 + RANDOM % 240))
  local folder_name_local="$1"  
  while [ -d "$folder_name_local" ]; do
    folder_name_local="${folder_name_local:0:1}${folder_name_local}"    
  done  
  source check_disk.sh
  mkdir "$folder_name_local"    
  folder_path="$path/$folder_name_local"
  echo "FOLDER_PATH: $folder_path | CREATE DATA: $(stat -c %y "$folder_path")" >> "$log_file"
  bash make_file.sh "$path/$folder_name_local/" "$file_characters_set" "$num_files" "$size"
  }

#  Генерация имен для папок от 5 знаков,
if [[ $folder_length -eq 1 ]]; then
  folder_name="${folder_characters_set}${folder_characters_set}${folder_characters_set}${folder_characters_set}${folder_characters_set}_${date}" 
  for ((i=0; i<num_folders; i++)); do
    create_folder "$folder_name"    
  done
fi

if [[ $folder_length -eq 2 ]]; then
  characters_number_one="${folder_characters_set:0:1}"  
  folder_name="${characters_number_one}${characters_number_one}${characters_number_one}${folder_characters_set}_${date}"
  for ((i=0; i<num_folders; i++)); do  
    create_folder "$folder_name" 
  done
fi

if [[ $folder_length -eq 3 ]]; then
  characters_number_one="${folder_characters_set:0:1}"
  folder_name="${characters_number_one}${characters_number_one}${folder_characters_set}_${date}"
  for ((i=0; i<num_folders; i++)); do 
    create_folder "$folder_name"
  done
fi

if [[ $folder_length -eq 4 ]]; then 
characters_number_one="${folder_characters_set:0:1}" 
  folder_name="${characters_number_one}${folder_characters_set}_${date}"
  for ((i=0; i<num_folders; i++)); do  
    create_folder "$folder_name"
  done
fi

if [[ $folder_length -ge 5 ]]; then  
  folder_name="${folder_characters_set}_${date}"
  for ((i=0; i<num_folders; i++)); do 
    create_folder "$folder_name"
  done
fi

