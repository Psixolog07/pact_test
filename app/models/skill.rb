# Не знаю какой второй путь. Здесь явно проще в лоб поменять все упоминания.
# + миграция на смену в бд, но мы так не будем глубоко додумывать, код тз вообще не из "живого" аппа явно.
class Skill < ApplicationRecord
  has_many :user_skills
  has_many :users, through: :user_skills
end
