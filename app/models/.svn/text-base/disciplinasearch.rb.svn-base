class Disciplinasearch < ActiveRecord::Base
  

  
def disciplinas(page)
  @disciplinas ||= find_disciplinas(page)
end

private

def find_disciplinas(page)
  Disciplina.find(:all, :joins => "inner join departamentos on departamentos.id = disciplinas.departamento_id 
                                   inner join ofertas on ofertas.disciplina_id = disciplinas.id
                                   inner join ofertas_professores on ofertas_professores.oferta_id = ofertas.id 
                                   inner join professores on professores.id = ofertas_professores.professor_id",
                        :conditions => conditions).uniq.paginate(:per_page => 10, :page => page)
end

def codigo_conditions
  ["disciplinas.codigo LIKE ?", "%#{nome}%"]
end

def nome_conditions
  ["disciplinas.nome LIKE ?", "%#{nome}%"] 

end

def departamento_conditions
  ["departamentos.id = disciplinas.departamento_id AND departamentos.nome LIKE ?", "%#{nome}%"]
end

def professor_conditions
  ["professores.nome LIKE ?", "%#{nome}%"]
end

def conditions
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
