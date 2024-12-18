FROM python:3.8-slim

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

# Установка необходимых Python библиотек
RUN pip install patroni==4.0.3 psycopg2-binary python-etcd PyYAML

# Копирование скрипта
COPY pat/ /etc/
# COPY pg_hba.conf /etc/postgresql/12/main/pg_hba.conf
# COPY pg_hba.conf /var/lib/postgresql/data/pg_hba.conf

COPY change_labels.py /app/change_labels.py

RUN pip install kubernetes requests

# Убедитесь, что скрипт имеет права на выполнение
RUN chmod +x /app/change_labels.py

# Установка прав на скрипт
RUN chmod +x /etc/start.sh

# Установка точки входа
CMD [ "./etc/start.sh" ]