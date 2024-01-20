#!/bin/bash

# Проверяем кол-во аргументов
if ! [[ $# -eq 1 ]]; then
    echo "ERROR!  Need 1 parametrs. Read tusk! "
    exit 1
fi

# Проверяем Параметр 3 список букв английского алфавита, используемый в названии папок (не более 7 знаков).
if ! [[ "$1" -eq 1 || "$1" -eq 2 || "$1" -eq 3 || "$1" -eq 4 ]]; then
  echo "ERROR! Characters is NOT! correct, use '1 - 4' characters "
exit 1
fi
