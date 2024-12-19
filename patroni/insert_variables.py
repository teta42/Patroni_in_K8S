import yaml
import os

path = '/etc/patroni.yml'

# Шаг 1: Загрузка данных из YML файла
with open(path, 'r') as file:
    config = yaml.safe_load(file)

pod_name = os.environ.get("POD_NAME")
pod_ip = os.environ.get("POD_IP")

# Шаг 2: Изменение нужных значений
config['name'] = pod_name
config['restapi']['connect_address'] = f'{pod_ip}:8008'
config['postgresql']['connect_address'] = f'{pod_ip}:5432'

# Шаг 3: Записывание обновлённых данных обратно в YML файл
with open(path, 'w') as file:
    yaml.dump(config, file)