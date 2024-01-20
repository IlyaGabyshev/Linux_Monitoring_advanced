#!/bin/bash

# Устанавливаем Node Exporter

# 1. Создаем системного пользователя для Node_exporter:
sudo useradd --system --no-create-home --shell /bin/false node_exporter

# 2. Скачиваем последнюю версию Node_exporter:
wget https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz

# 3. Распаковываем скачанный архив:
tar -xzf node_exporter-1.6.1.linux-amd64.tar.gz

# 4. Переходим в директорию распакованного архива:
cd node_exporter-1.6.1.linux-amd64

# 5. Перемещаем файлы:
sudo cp node_exporter /usr/local/bin/
# Создаем сервисный файл node_exporter.service systemd и добавляем следующее содержимое в сервисный файл:
sudo rm -rf /etc/systemd/system/node_exporter.service
sudo touch /etc/systemd/system/node_exporter.service

cat <<EOF >/etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
User=node_exporter
Group=node_exporter
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/node_exporter \
    --collector.logind

ExecReload=/bin/kill -HUP $MAINPID

[Install]
WantedBy=multi-user.target
EOF

sudo chmod +x /usr/local/bin/

# Запускаем Node Exporter
sudo systemctl enable node_exporter
sudo systemctl start node_exporter
sudo systemctl status node_exporter

# Создаем статичную цель для Node Exporter:
sudo rm -rf /etc/prometheus/prometheus.yml
sudo touch /etc/prometheus/prometheus.yml

cat <<EOF >/etc/prometheus/prometheus.yml
# - job_name: "node_export"
#   static_configs:
#     - targets: ["localhost:9100"]

global:
  scrape_interval: 15s
  evaluation_interval: 15s
  # ... other global configuration ...

alerting:
  alertmanagers:
    - static_configs:
        - targets:
          # - alertmanager:9093

rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"

scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["localhost:9090"]

  - job_name: "node_export"
    static_configs:
      - targets: ["localhost:9100"]



EOF

