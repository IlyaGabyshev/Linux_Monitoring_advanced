# #!/bin/bash
folder_characters_set="$3"
folder_length="${#folder_characters_set}"
num_folders="$2"
path="$1"
size="$6"
file_characters_set="$5"
num_files="$4"
date="$(date +'%d%m%y')"

# Функция для создания папки с уникальным именем
create_folder() {  
  local folder_name_local="$1"  
  while [ -d "$path$folder_name_local" ]; do
    folder_name_local="${folder_name_local:0:1}${folder_name_local}"
  done
  mkdir "$path/$folder_name_local"
  log_file="file_log.txt"
  echo "FOLDER_PATH: "$path$folder_name_local" | CREATE DATA: $(stat -c %y "$path$folder_name_local")" >> "$log_file"
  bash make_file.sh "$path/$folder_name_local/" "$file_characters_set" "$num_files" "$size"  
  }

#  Генерация имен для папок
if [[ $folder_length -eq 1 ]]; then
  folder_name="${folder_characters_set}${folder_characters_set}${folder_characters_set}${folder_characters_set}_${date}"

  for ((i=0; i<num_folders; i++)); do
    create_folder "$folder_name"
  done
fi

if [[ $folder_length -eq 2 ]]; then
  characters_number_one="${folder_characters_set:0:1}"  
  folder_name="${characters_number_one}${characters_number_one}${folder_characters_set}_${date}"
  for ((i=0; i<num_folders; i++)); do
    create_folder "$folder_name" 
  done
fi

if [[ $folder_length -eq 3 ]]; then
  characters_number_one="${folder_characters_set:0:1}"
  folder_name="${characters_number_one}${folder_characters_set}_${date}"
  for ((i=0; i<num_folders; i++)); do
    create_folder "$folder_name"
  done
fi

if [[ $folder_length -ge 4 ]]; then  
  folder_name="${folder_characters_set}_${date}"
  for ((i=0; i<num_folders; i++)); do
    create_folder "$folder_name"
  done
fi
