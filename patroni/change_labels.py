import requests, os
from kubernetes import client, config
from time import sleep

def get_pod_role() -> str:
    try:
        response = requests.get('http://localhost:8008/patroni')
        if response.status_code == 200:
            return response.json()["role"]
        else:
            print(f"Сервер вернул статус: {response.status_code}")
    except requests.exceptions.RequestException as e:
        print(f"Ошибка при подключении к серверу: {e}")

def change_labels(pod_name, namespace, v1, statys):
    # Получение текущих меток пода
    pod = v1.read_namespaced_pod(name=pod_name, namespace=namespace)
    labels = pod.metadata.labels

    # Добавление новой метки
    labels['role'] = statys
    pod.metadata.labels = labels

    # Обновление пода с новыми метками
    v1.patch_namespaced_pod(name=pod_name, namespace=namespace, body=pod)


sleepness = int(os.environ['SLEEPNESS'])
pod_name = os.environ['POD_NAME']
namespace = os.environ['POD_NAMESPACE']

# Загрузка конфигурации из пода
config.load_incluster_config()
v1 = client.CoreV1Api()

sleep(5)
while True:
    statys = get_pod_role()
    if statys != None:
        change_labels(pod_name, namespace, v1, statys)
    sleep(sleepness)