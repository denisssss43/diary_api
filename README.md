# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version: 2.7.0p0 (2019-12-25)

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Список команд:

```
docker-compose up   # запускает в контейнерах postgres и redis
rails db:migrate    # только в первый раз для миграции
rails db:seed       # если нужно чем-то заполнить БД
bundle exec sidekiq     # запускает проверку каждые 20 мин, первый раз сразу (config/sidekiq.yml)
bundle exec rails server    # запускает сервер rails
```


Файл docker-compose:
```
db:
    image: postgres
    container_name: api_pg
    environment: 
        - POSTGRES_DB=api
        - POSTGRES_USER=sa
        - POSTGRES_PASSWORD=1111
    ports: 
        - 5432:5432

redis:
    image: redis
    restart: always
    container_name: api_rd
    ports: 
        - 6379:6379
```





Available requests:
```
GET /domain     # просмотр всех доменов. без параметров

POST /domain    # добавление домена. пример { "domain": "https://change.org" }

PUT /domain     # изменение домена. пример { "id": 5, "https://github.com/"}

DELETE /domain  # удаление домена. пример { "id": 3 }


GET /status     # просмотр всей информации. без параметров


web: /sidekiq   # панель sidekiq. пароль и логин "admin" (config/initializers/sidekiq.rb)

```

Response example /status:
```
[
    {
        "id": 8,
        "domain": "https://youtube.com",
        "created_at": "2020-02-21T17:38:22.027Z",
        "updated_at": "2020-02-21T17:48:17.587Z",
        "status_is_fine": true,
        "current_state": "all fine",
        "expire_days": 61
    },
    {
        "id": 7,
        "domain": "https://thissitedoesneventexist.com/",
        "created_at": "2020-02-21T17:25:14.954Z",
        "updated_at": "2020-02-21T17:42:44.283Z",
        "status_is_fine": false,
        "current_state": "Non-SSL error",
        "expire_days": -1
    },
    {
        "id": 6,
        "domain": "https://untrusted-root.badssl.com/",
        "created_at": "2020-02-21T17:25:14.942Z",
        "updated_at": "2020-02-21T17:48:17.761Z",
        "status_is_fine": false,
        "current_state": "certificate verify failed (self signed certificate in certificate chain)",
        "expire_days": -1
    }
]
```