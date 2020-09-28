# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


d = Diary.create(title: "Diary 1", expiration: nil, kind: :is_public)
d = Diary.create(title: "Diary 1", expiration: nil, kind: :is_private)
d = Diary.create(title: "Diary 1", expiration: Time.now + 10.minutes, kind: :is_private)
d = Diary.create(title: "Diary 1", expiration: Time.now + 10.minutes, kind: :is_private)