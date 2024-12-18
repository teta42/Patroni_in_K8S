#!/bin/sh

# Запускаем первый скрипт Python в фоновом режиме
python /etc/pod_name.py &

# Запускаем Patroni и второй скрипт Python в фоновом режиме
sudo -u postgres patroni /etc/patroni.yml & python /app/change_labels.py