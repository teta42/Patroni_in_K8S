import yaml
import os

path = '/etc/patroni.yml'

# Шаг 1: Загрузите данные из YML файла
with open(path, 'r') as file:
    config = yaml.safe_load(file)

pod_name = os.environ.get("POD_NAME")
pod_ip = os.environ.get("POD_IP")

# Шаг 2: Измените нужное значение
config['name'] = pod_name
# Шаг 2.5: Измените нужное значение
config['restapi']['connect_address'] = f'{pod_ip}:8008'
config['postgresql']['connect_address'] = f'{pod_ip}:5432'

# Шаг 3: Запишите обновленные данные обратно в YML файл
with open(path, 'w') as file:
    yaml.dump(config, file)