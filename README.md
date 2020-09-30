# API
Реализовано API, через которое можно создавать дневники с записями.

### Список команд:
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

### Docker-compose:
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

### Модель:
Файл 'db\schema.rb':
```
create_table "diaries", force: :cascade do |t|
  t.string "title"
  t.datetime "expiration"
  t.integer "kind"
  t.datetime "created_at", precision: 6, null: false
  t.datetime "updated_at", precision: 6, null: false
end

create_table "notes", force: :cascade do |t|
  t.text "text"
  t.datetime "created_at", precision: 6, null: false
  t.datetime "updated_at", precision: 6, null: false
end
```

Модель дневника (Diary):
```
validates :expiration, inclusion: { in: [nil], message: 'is_public diaries can be only nil' }, if: :is_public?
validates :title, presence: true 
validates :kind, presence: true
enum kind: {is_public:0, is_private:1}
has_many :notes, dependent: :destroy
```

Модель страницы (Note):
```
belongs_to :diary
```

### Seed:
Файл seed: 'db\seeds.rb'
```
d = Diary.create(title: "Diary 1", expiration: nil, kind: :is_public)
d.notes.create(text: "diary_1-note_1: text...")
d.notes.create(text: "diary_1-note_2: text...")
d.notes.create(text: "diary_1-note_3: text...")

d = Diary.create(title: "Diary 2", expiration: nil, kind: :is_private)
d.notes.create(text: "diary_2-note_1: text...")
d.notes.create(text: "diary_2-note_2: text...")
d.notes.create(text: "diary_2-note_3: text...")

d = Diary.create(title: "Diary 3", expiration: Time.now + 10.minutes, kind: :is_private)
d.notes.create(text: "diary_3-note_1: text...")
d.notes.create(text: "diary_3-note_2: text...")
d.notes.create(text: "diary_3-note_3: text...")

d = Diary.create(title: "Diary 4", expiration: Time.now + 10.minutes, kind: :is_private)
d.notes.create(text: "diary_4-note_1: text...")
d.notes.create(text: "diary_4-note_2: text...")
d.notes.create(text: "diary_4-note_3: text...")
```

### API:

Список запросов Diary CRUD:
```
GET     /api/v1/diaries         api/v1/diaries#index
GET     /api/v1/diaries/:id     api/v1/diaries#show
POST    /api/v1/diaries/:id     api/v1/diaries#create
PUT     /api/v1/diaries/:id     api/v1/diaries#update
DELETE  /api/v1/diaries/:id     api/v1/diaries#delete
```
Формат приема Diary API:
```
{
    "title": "...", # Название дневника
    "expiration": "...", # Дата, после которой дневник будет удален
    "kind": "..." # Тип дневника [is_public,is_private]
}
```
Формат отдачи Diary API:
```
{
    "id": ..., # id дневника
    "title": "...", # Название дневника
    "expiration": "...", # Дата, после которой дневник будет удален
    "kind": "...", # Тип дневника [is_public,is_private]
    "created_at": "...", # Дата создания
    "updated_at": "..." # Дата изменения
}
```

Список запросов Note CRUD:
```
GET     /api/v1/notes           api/v1/notes#index
GET     /api/v1/notes/:id       api/v1/notes#show
POST    /api/v1/notes/:id       api/v1/notes#create
PUT     /api/v1/notes/:id       api/v1/notes#update
DELETE  /api/v1/notes/:id       api/v1/notes#delete
```
Формат приема Note API:
```
{
    "text": "...", # Текст страницы
    "diary_id": "..." # Ссылка на дневник, за которым закреплена страница
}
```
Формат отдачи Note API:
```
{
    "id": ..., # id страницы
    "text": "...", # Текст страницы
    "created_at": "", # Дата создания
    "updated_at": "", # Дата изменения
    "diary_id": ... # Ссылка на дневник, за которым закреплена страница
}
```

Список остальных запросов:
```
        # Панель sidekiq
        # Пароль и логин: "admin"
        # Инициализация "config/initializers/sidekiq.rb"
        /sidekiq                Sidekiq::Web
```



### Sidekiq:
Параметры запуска воркера 'config/sidekiq.yml': 
```
:schedule:
    DestroyExpirationWorker:
      every: ['10m', first_in: '0s']
```
Воркер 'destroy_expiration_worker' удаляеть дневники у которых ```expiration < Time.now```:
```
include Sidekiq::Worker
sidekiq_options retry: false
def perform
    puts Time.now
    diaries = Diary.where(["expiration < ?", Time.now])
    diaries.each do |d| 
        d.destroy
    end
end
```