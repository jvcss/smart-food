#### Apply Migrations

```shell
python manage.py makemigrations
python manage.py migrate
```

#### Login

```shell
python manage.py runserver 0.0.0.0:8000
```

Go to `http://localhost:8000/admin`

#### Access REST API

```shell
http://127.0.0.1:8000/api
```

#### Test API 

```shell
python manage.py test
```