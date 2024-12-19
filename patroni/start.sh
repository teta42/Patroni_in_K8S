#!/bin/sh

# Запускаем скрипт для подстановки переменных
python /etc/pod_name.py &

# Даём права для смонтировонного каталога
sudo chmod 0700 /var/lib/postgresql/data
sudo chown -R postgres:postgres /var/lib/postgresql/data

# Запускаем Patroni и скрипт смены ролей
sudo -u postgres patroni /etc/patroni.yml & python /etc/change_labels.py