#!/bin/bash

# Установка Prometheus

# 1. Создаем системного пользователя для Prometheus:
sudo useradd --system --no-create-home --shell /bin/false prometheus

# 2. Скачиваем последнюю версию Prometheus:
# wget https://github.com/prometheus/prometheus/releases/download/v2.37.9/prometheus-2.37.9.linux-amd64.tar.gz

# 3. Распаковываем скачанный архив:
tar -xvf prometheus-2.37.9.linux-amd64.tar.gz

# 4. Создаем директории хранения данных и конфигурационных файлов:
sudo mkdir -p /data /etc/prometheus

# 5. Переходим в директорию распакованного архива:
cd prometheus-2.37.9.linux-amd64/

# 6. Перемещаем файлы:
sudo mv prometheus promtool /usr/local/bin/
sudo mv consoles/console_libraries/ /etc/prometheus
sudo mv prometheus.yml /etc/prometheus/prometheus.yml

# 7. Даем права созданному системному пользователю:
sudo chown -R prometheus:prometheus /etc/prometheus/ /data/

# 8. Удаляем бинарный файл prometheus:
cd ../ 
rm -rf prometheus*

# 9. Создаем сервисный файл Prometheus systemd и добавляем следующее содержимое в сервисный файл:
sudo nano /etc/systemd/system/prometheus.service

cat <<EOF >/etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
User=prometheus
Group=prometheus
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/prometheus \
  --config.file /etc/prometheus/prometheus.yml \
  --storage.tsdb.path /data \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries \
  --web.listen-address=0.0.0.0:9090 \
  --web.enable-lifecycle

[Install]
WantedBy=multi-user.target
EOF

# 10. Запускаем Prometheus:
sudo systemctl enable prometheus
sudo systemctl start prometheus
sudo systemctl status prometheus

