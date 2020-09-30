Список команд:
```
# запускает контейнеры docker-compose
docker-compose up   

# запускает миграцию в db
# результат миграции описан в 'db\schema.rb'
rails db:migrate 

# первичные данные для проверки работы API
rails db:seed 

# запуск rails-сервера (API)
bundle exec rails s 

# запускает sidekiq 
# отработка воркеров описаных в 'app\workers'
# параметры запуска описаны в 'config/sidekiq.yml'
bundle exec sidekiq 
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

---Модель




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