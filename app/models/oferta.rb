class Oferta < ActiveRecord::Base
    belongs_to :disciplina    
    has_and_belongs_to_many :reservas
    has_and_belongs_to_many :professores
    has_and_belongs_to_many :horarios
    has_and_belongs_to_many :grades
    
    
    validates_presence_of(:disciplina_id, :message => " é obrigatório!")
    
    validates_uniqueness_of(:disciplina_id, :scope => :turma, :message => " já existente!")

 
  #:horarios => [[1,'14:00','16:00'], [3, '14:00', '16:00']]
  def self.find_ofertas(restrictions = {})
    query = "SELECT DISTINCT ofertas.* FROM ofertas "
    
        #Adiciona o codigo sql para busca por horarios
        if !restrictions[:horarios].blank?
            query.concat "INNER JOIN horarios_ofertas ON horarios_ofertas.oferta_id = ofertas.id
                          INNER JOIN horarios ON horarios_ofertas.horario_id = horarios.id "
        end
        
        if !restrictions[:professor].blank? or !restrictions[:horarios].blank? or !restrictions[:campus].blank? or !restrictions[:departamento].blank? or !restrictions[:disciplina].blank? or !restrictions[:curso_fluxo].blank? or !restrictions[:curso_curriculo].blank?
            query.concat " WHERE "
        end
        
        
        #Adiciona o codigo sql para busca por horarios
        if !restrictions[:horarios].blank?
            query.concat " horarios_ofertas.oferta_id NOT IN ("
                          
            query.concat "SELECT DISTINCT ofertas.id FROM ofertas
                          INNER JOIN horarios_ofertas ON horarios_ofertas.oferta_id = ofertas.id
                          INNER JOIN horarios ON horarios_ofertas.horario_id = horarios.id 
                          WHERE "
                         
            n = 0
            query.concat "("
            restrictions[:horarios].each do |horario|
                query.concat " horarios.dia != #{horario[0]}"
                if restrictions[:horarios].count > n + 1
                      query.concat " AND "
                end
                n = n + 1
            end
            query.concat ")"
            
            
            query.concat " OR "
            
            n = 0
            query.concat "("
            restrictions[:horarios].each do |horario|
                query.concat " horarios.dia = #{horario[0]} AND ( horarios.horario_ini < '#{horario[1]}' OR horarios.horario_fim > '#{horario[2]}' ) "
                if restrictions[:horarios].count > n + 1
                    if restrictions[:horarios][n][0] == restrictions[:horarios][n+1][0]
                      query.concat " AND "
                    else
                      query.concat " OR "
                    end
                end
                n = n + 1
            end
            query.concat ")"
            query.concat ")"
        end
        
        
        if  !restrictions[:horarios].blank? and !restrictions[:professor].blank?
            query.concat " AND "
        end
        
        if !restrictions[:professor].blank?
          query.concat " ofertas.id IN "
          query.concat "("
          query.concat "SELECT ofertas.id
                        FROM ofertas
                        INNER JOIN ofertas_professores ON ofertas.id = ofertas_professores.oferta_id
                        INNER JOIN professores ON ofertas_professores.professor_id = professores.id
                        WHERE professores.nome LIKE '%#{restrictions[:professor]}%'"             
          query.concat ")"
        end
        
        if  (!restrictions[:professor].blank? or !restrictions[:horarios].blank?) and !restrictions[:campus].blank?
            query.concat " AND "
        end
      
        if !restrictions[:campus].blank?
          query.concat " ofertas.disciplina_id IN "
          query.concat "("
          query.concat "SELECT disciplinas.id
                        FROM disciplinas
                        INNER JOIN campi_disciplinas ON disciplinas.id = campi_disciplinas.disciplina_id
                        INNER JOIN campi ON campi_disciplinas.campus_id = campi.id
                        WHERE campi.nome LIKE '%#{restrictions[:campus]}%'"             
          query.concat ")"
        end
   
        if  (!restrictions[:professor].blank? or !restrictions[:horarios].blank? or !restrictions[:campus].blank?) and !restrictions[:departamento].blank?
            query.concat " AND "
        end
   
        if !restrictions[:departamento].blank?
          query.concat " ofertas.disciplina_id IN "
          query.concat "("
          query.concat "SELECT disciplinas.id
                        FROM disciplinas
                        INNER JOIN departamentos ON disciplinas.departamento_id = departamentos.id
                        WHERE departamentos.nome LIKE '%#{restrictions[:departamento]}%'"             
          query.concat ")"
        end
        
        
        if  (!restrictions[:professor].blank? or !restrictions[:horarios].blank? or !restrictions[:campus].blank? or !restrictions[:departamento].blank?) and !restrictions[:disciplina].blank?
            query.concat " AND "
        end
        
         
        if !restrictions[:disciplina].blank?
          query.concat " ofertas.disciplina_id IN "
          query.concat "("
          query.concat "SELECT disciplinas.id
                        FROM disciplinas
                        WHERE disciplinas.nome LIKE '%#{restrictions[:disciplina]}%'"             
          query.concat ")"
        end 
        
        if  (!restrictions[:professor].blank? or !restrictions[:horarios].blank? or !restrictions[:campus].blank? or !restrictions[:departamento].blank? or !restrictions[:disciplina].blank?) and !restrictions[:curso_fluxo].blank?
            query.concat " AND "
        end
         
        if !restrictions[:curso_fluxo].blank?
          query.concat " ofertas.disciplina_id IN "
          query.concat "("
          query.concat "SELECT disciplinas.id
                        FROM disciplinas
                        INNER JOIN disciplinas_fluxos ON disciplinas.id = disciplinas_fluxos.disciplina_id
                        INNER JOIN fluxos ON fluxos.id = disciplinas_fluxos.fluxo_id
                        INNER JOIN habilitacoes ON fluxos.habilitacao_id = habilitacoes.id
                        INNER JOIN cursos ON habilitacoes.curso_id = cursos.id
                        WHERE cursos.nome LIKE '%#{restrictions[:curso_fluxo]}%'"             
          query.concat ")"
        end 
        
        
        if  (!restrictions[:professor].blank? or !restrictions[:horarios].blank? or !restrictions[:campus].blank? or !restrictions[:departamento].blank? or !restrictions[:disciplina].blank? or !restrictions[:curso_fluxo].blank?) and !restrictions[:curso_curriculo].blank?
            query.concat " AND "
        end
        
   
        if !restrictions[:curso_curriculo].blank?
          query.concat " ofertas.disciplina_id IN "
          query.concat "("
          query.concat "SELECT disciplinas.id
                      FROM disciplinas
                      INNER JOIN curriculos_disciplinas ON disciplinas.id = curriculos_disciplinas.disciplina_id
                      INNER JOIN curriculos ON curriculos.id = curriculos_disciplinas.curriculo_id
                      INNER JOIN habilitacoes ON curriculos.habilitacao_id = habilitacoes.id
                      INNER JOIN cursos ON habilitacoes.curso_id = cursos.id
                      WHERE cursos.nome LIKE '%#{restrictions[:curso_curriculo]}%'"             
          query.concat ")"
        end  
        
        if  (!restrictions[:professor].blank? or !restrictions[:horarios].blank? or !restrictions[:campus].blank? or !restrictions[:departamento].blank? or !restrictions[:disciplina].blank? or !restrictions[:curso_fluxo].blank?) or !restrictions[:curso_curriculo].blank?
            query.concat " AND "
        else
            query.concat " WHERE "
        end
        
        query.concat " ofertas.oferta_atual = true "

        
        if !restrictions[:limit].blank?
          query.concat " LIMIT #{restrictions[:limit]}"
        end

   
        Oferta.find_by_sql(query)
                               
  end

  def campus
      sql = "SELECT DISTINCT campi.* FROM campi
             INNER JOIN campi_disciplinas ON campi.id = campi_disciplinas.campus_id
             INNER JOIN disciplinas ON campi_disciplinas.disciplina_id = disciplinas.id
             INNER JOIN ofertas ON disciplinas.id = ofertas.disciplina_id
             WHERE ofertas.id =#{id}"

      Campus.find_by_sql(sql)
  end
  
  
  
end
