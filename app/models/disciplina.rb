class Disciplina < ActiveRecord::Base
  belongs_to :departamento
  has_and_belongs_to_many :campi
  has_and_belongs_to_many :fluxos
  has_and_belongs_to_many :curriculos
  
  has_many :ofertas
  has_many :posts
  
  has_many :assets, :as => :attachable, :dependent => :destroy
  
  
  
  
  validates_length_of( :nome, :maximum => 255, :message => " inválido!")
  
  validates_presence_of(:codigo, :message => " é obrigatório!")
  #validates_presence_of(:departamento_id, :message => " é obrigatório!")
  validates_presence_of(:nome, :message => " é obrigatório!")
  #validates_presence_of(:creditos, :message => " é obrigatório!")
  
  validates_uniqueness_of(:codigo, :message => " já existente!")
  validates_uniqueness_of(:nome, :message => " já existente!")
  
  

  def professores
      Professor.find_by_sql "Select * From professores
      Inner Join ofertas_professores On ofertas_professores.professor_id = professores.id
      Inner Join ofertas On ofertas_professores.oferta_id = ofertas.id
      AND ofertas.disciplina_id = #{id}"
  end


   def self.find_disciplinas(disciplinasearch, page)
       Disciplina.find(:all,
                       #:select => " disciplinas.*, ((disciplinas.votos_like / ( disciplinas.votos_like + disciplinas.votos_dislike )) *10) AS nota ",
                       :joins => "INNER JOIN departamentos ON departamentos.id = disciplinas.departamento_id
                                  INNER JOIN ofertas ON ofertas.disciplina_id = disciplinas.id
                                  INNER JOIN ofertas_professores ON ofertas_professores.oferta_id = ofertas.id
                                  INNER JOIN professores ON professores.id = ofertas_professores.professor_id",
                       :conditions => ["disciplinas.codigo LIKE ? OR
                                        disciplinas.nome   LIKE ? OR
                                        departamentos.id = disciplinas.departamento_id AND departamentos.nome LIKE ? OR
                                        professores.nome LIKE ? OR
                                        departamentos.sigla LIKE ?",
                                        "%#{disciplinasearch}%","%#{disciplinasearch}%","%#{disciplinasearch}%","%#{disciplinasearch}%","%#{disciplinasearch}%"],
                       :order => " departamentos.sigla "                
                     #  :group => " disciplinas.id ",
                     #  :order => " nota desc "
                      ).uniq.paginate(:per_page => 10, :page => page)


  end
=begin
  scope :com_nota, select("disciplinas.*").
    select(" ((disciplinas.votos_like / ( disciplinas.votos_like + disciplinas.votos_dislike )) *10) AS nota ").
    joins("INNER JOIN departamentos ON departamentos.id = disciplinas.departamento_id
                                  INNER JOIN ofertas ON ofertas.disciplina_id = disciplinas.id
                                  INNER JOIN ofertas_professores ON ofertas_professores.oferta_id = ofertas.id
                                  INNER JOIN professores ON professores.id = ofertas_professores.professor_id").
    conditions(["disciplinas.codigo LIKE ? OR
                                        disciplinas.nome   LIKE ? OR
                                        departamentos.id = disciplinas.departamento_id AND departamentos.nome LIKE ? OR
                                        professores.nome LIKE ? OR
                                        departamentos.sigla LIKE ?",
                                        "%#{disciplinasearch}%","%#{disciplinasearch}%","%#{disciplinasearch}%","%#{disciplinasearch}%","%#{disciplinasearch}%"]).
    group("disciplinas.id").
    order(" nota desc ")
=end
  
end
