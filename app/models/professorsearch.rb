class Professorsearch < ActiveRecord::Base
  
def professores(page)
  @professores ||= find_professores(page)
end

private

def find_professores(page)
  Professor.find(:all, :joins => 
                      "INNER JOIN ofertas_professores ON ofertas_professores.professor_id = professores.id
                       INNER JOIN ofertas ON ofertas_professores.oferta_id = ofertas.id
                       INNER JOIN disciplinas ON ofertas.disciplina_id = disciplinas.id
                       INNER JOIN departamentos ON disciplinas.departamento_id = departamentos.id",
                       :conditions => conditions).uniq.paginate(:per_page => 10, :page => page)
end

def nome_conditions
  ["professores.nome LIKE ?", "%#{nome}%"]
end

def disciplina_conditions
  ["disciplinas.nome LIKE ?", "%#{nome}%"]
end

def departamento_conditions
  ["departamentos.nome LIKE ?", "%#{nome}%"]
end

def sigla_conditions
  ["departamentos.sigla LIKE ?", "%#{nome}%"]
end


def conditions
  #-----------> COLOCAR O AND AKI NO JOIN (.join(' AND ')) CASO ADICIONE MAIS UMA CONDICAO
  [conditions_clauses.join(' OR '), *conditions_options]
end

def conditions_clauses
  conditions_parts.map { |condition| condition.first }
end

def conditions_options
  conditions_parts.map { |condition| condition[1..-1] }.flatten
end

def conditions_parts
  private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
end
  

  
  
  
end
