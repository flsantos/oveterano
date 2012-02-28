class Professor < ActiveRecord::Base
  
  #  has_friendly_id :nome, :use_slug => false
  
    has_and_belongs_to_many :ofertas
    
    has_many :posts
  
    validates_presence_of(:nome, :message => " é obrigatório!")
    validates_uniqueness_of(:nome, :message => " já existente")
    
  def disciplinas
      Disciplina.find_by_sql "SELECT *
      FROM disciplinas
      INNER JOIN ofertas ON ofertas.disciplina_id = disciplinas.id
      INNER JOIN ofertas_professores ON ofertas.id = ofertas_professores.oferta_id
      AND ofertas_professores.professor_id = #{id}"
  end
    

  #Esse método tentar achar o departamento de um professor, ou seja, ver em qual departamento o professor mais oferece e disciplinas e retorna-lo
  #É um chute, pois não tenho a informação de relação entre professor e departamento
  def departamento_aprox
    result = Departamento.find_by_sql "SELECT DISTINCT departamentos.*
                              FROM departamentos
                              INNER JOIN disciplinas ON departamentos.id = disciplinas.departamento_id
                              INNER JOIN ofertas ON disciplinas.id = ofertas.disciplina_id
                              INNER JOIN ofertas_professores ON ofertas.id = ofertas_professores.oferta_id
                              WHERE ofertas_professores.professor_id = #{id}"

    if result.instance_of? Departamento
        result
    else
        if result.instance_of? Array
            most_common_value(result)
        end
    end
  end


  def self.find_professores(professorsearch, page)
       Professor.find(:all,
                      :joins =>"INNER JOIN ofertas_professores ON ofertas_professores.professor_id = professores.id
                                INNER JOIN ofertas ON ofertas_professores.oferta_id = ofertas.id
                                INNER JOIN disciplinas ON ofertas.disciplina_id = disciplinas.id
                                INNER JOIN departamentos ON disciplinas.departamento_id = departamentos.id",
                      :conditions => ["professores.nome LIKE ? OR
                                       disciplinas.nome LIKE ? OR
                                       departamentos.nome LIKE ? OR
                                       departamentos.sigla LIKE ?",
                                       "%#{professorsearch}%", "%#{professorsearch}%", "%#{professorsearch}%", "%#{professorsearch}%"],
                      :order => " departamentos.sigla "                                       
                     ).uniq.paginate(:per_page => 10, :page => page)
  end


  private
  def most_common_value(a)
    a.group_by do |e|
      e
    end.values.max_by(&:size).first
  end


end
