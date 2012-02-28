class Campus < ActiveRecord::Base
  has_and_belongs_to_many :disciplinas
  has_many :cursos
  validates_presence_of(:nome)
  validates_uniqueness_of(:nome, :message => " já existente!")
end
