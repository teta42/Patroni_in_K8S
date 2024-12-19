FROM python:3.8-slim
LABEL author="teta42"
LABEL version="1.0"
LABEL repo="https://github.com/teta42/Patroni_in_K8S"

EXPOSE 8008
EXPOSE 5432

# Обновление списка пакетов
RUN apt-get update

# Установка необходимых зависимостей
RUN apt-get install -y \
    wget \
    gnupg2 \
    lsb-release

# Добавление репозитория PostgreSQL
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list

# Обновление списка пакетов
RUN apt-get update

# Установка sudo и PostgreSQL
RUN apt-get install -y sudo \
    && apt-get install -y postgresql-12 postgresql-client-12

# Очистка кэша apt
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Установка зависимостей 
RUN pip install patroni==4.0.3 psycopg2-binary python-etcd PyYAML
RUN pip install kubernetes requests

# Копирование скриптов
COPY . /etc/

# Даю скриптам права на выполнение
RUN chmod +x /etc/start.sh
RUN chmod +x /etc/pod_name.py
RUN chmod +x /etc/change_labels.py

# Установка точки входа
CMD [ "./etc/start.sh" ]