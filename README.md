# ClickHouse Single-Node · Helm-чарт

Helm-чарт для развёртывания одного узла ClickHouse в Kubernetes

## Содержание
- [Возможности](#возможности)
- [Требования](#требования)
- [Настройка (values.yaml)](#настройка-valuesyaml)
- [Быстрый старт](#быстрый-старт)
- [Управление релизовом](#управление-релизом)
- [Подключение](#подключение)
- [Удаление](#удаление)


## Возможности
- Single-node ClickHouse (без ZooKeeper)
- Выбор версии через `imageTag`
- Пользователи и пароли в `values.yaml` (хэши генерируются автоматически)
- Хранилище: `emptyDir` (тесты) или `PVC` (прод)
- Минимальная, понятная структура чарта

## Требования
- Kubernetes ≥ 1.19  
- Helm ≥ 3.8  
- Default StorageClass при использовании PVC

## Настройка (values.yaml)

| Параметр       | Описание                         |
|----------------|----------------------------------|
| `imageTag`     | версия ClickHouse                |
| `storage.type` | тип хранилища: `emptyDir` или `pvc` |
| `storage.size` | размер PVC при `type: pvc`       |
| `users`        | список пользователей             |


## Быстрый старт
```bash
git clone https://github.com/nastasiadanilova/clickhouse-k8n.git
cd clickhouse-k8n

# Тестовый запуск
helm install mych .
```

## Управление релизом
```bash
helm status mych
helm list
helm upgrade mych . --set imageTag=25.11.2-alpine
helm uninstall mych    # PVC остаётся
```

## Подключение
```bash
kubectl port-forward svc/mych-clickhouse 8123:8123 9000:9000
curl "http://127.0.0.1:8123/?query=SELECT%20version()"

clickhouse-client \
  --host 127.0.0.1 \
  --port 9000 \
  --user admin \
  --password SuperSecret123
```

## Удаление

```bash
helm uninstall mych
kubectl delete pvc data-mych-clickhouse   # удалить данные (опционально)
```
