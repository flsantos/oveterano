class Post < ActiveRecord::Base
  validates_presence_of(:mensagem , :message => " é obrigatória!")
  validates_presence_of(:alias , :message => " é obrigatório!")
  validates_presence_of(:alias_id , :message => " é obrigatório!")
  
  belongs_to :disciplina
  belongs_to :professor
end
