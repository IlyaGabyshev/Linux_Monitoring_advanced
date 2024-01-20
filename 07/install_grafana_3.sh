#!/bin/bash

# Устанавливаем Grafana

# 1. Обновляем утилиты:
sudo apt-get install -y apt-transport-https
sudo apt-get install -y software-properties-common wget
sudo apt-get install -y adduser libfontconfig1 musl

# 2. Скачиваем последнюю версию Grafana:
# wget https://dl.grafana.com/oss/release/grafana_10.1.0_amd64.deb

# 3. Распаковываем скачанный deb архив:
sudo dpkg -i grafana_10.1.0_amd64.deb

sudo apt-get update
sudo apt-get install grafana

# 4. Запускаем Grafana:
sudo systemctl start grafana-server
sudo systemctl enable grafana-server


# Подключаем интерфейсы Prometheus и Grafana:

# 1. Создаём SSH туннель к ВМ для Prometheus и Grafana:
ssh -L 9090:localhost:9090 -L 3000:localhost:3000 il@127.0.0.1 -p54321
# 2. Переходим в Prometheus по адресу: http://localhost:9090
# 3. Переходим в Grafana по адресу: http://localhost:3000 (логин и пароль по-умолчанию admin).

# Добавляем Prometheus в качестве data source для Grafana:

# 1. Логинмся в Grafana и переходим в найстройки.
# 2. Нажимаем "Data Sources", потом "Add data source."
# 3. Выбираем "Prometheus".
# 4. В поле URL вводим http://localhost:9090.
# 5. Нажимаем "Save & Test" для сохранения.

# Создаём новый дашборд с отображением ЦПУ, доступной оперативной памяти, свободное место и кол-во операций ввода/вывода на жестком диске:

# 1. Нажимаем в Grafana на "+" и выбираем "Dashboard."
# 2. Нажимаем на "Add new panel."
# 3. Конфигурируем каждую панель с помощью PromQL запросов:
#    CPU Usage: 100 - (avg by (instance) (irate(node_cpu_seconds_total{mode="idle"}[1m])) * 100)
#    Available RAM: node_memory_MemAvailable_bytes
#    Free Disk Space: node_filesystem_free_bytes
#    I/O Operations: rate(node_disk_io_time_seconds_total[1m])
# 4. Настраиваем визуализацию и сохраняемся.
