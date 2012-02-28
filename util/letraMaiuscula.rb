class String
  alias_method :old_rapidito_upcase, :upcase
  def upcase
    self.gsub( /\303[\240-\277]/ ) do
      |match|
      match[0].chr + (match[1] - 040).chr
    end.old_rapidito_upcase
  end
  
  alias_method :old_rapidito_downcase, :downcase
  def downcase
    self.gsub( /\303[\200-\237]/ ) do
      |match|
      match[0].chr + (match[1] + 040).chr
    end.old_rapidito_downcase
  end
end
#Rodar isso em professor, disciplina e Departamento
Curso.all.each do |z|
	array = z.nome.split(" ")
	array.each do |word|
		word[0,1] = word[0,1].upcase
		word[1, word.size] = word[1, word.size].downcase
	end
	z.nome = array.join(" ")
	puts z.nome
	
	z.save
end  
Professor.all.each do |z|
  array = z.nome.split(" ")
  array.each do |word|
    word[0,1] = word[0,1].upcase
    word[1, word.size] = word[1, word.size].downcase
  end
  z.nome = array.join(" ")
  puts z.nome
  
  z.save
end

Disciplina.all.each do |z|
  array = z.nome.split(" ")
  array.each do |word|
    word[0,1] = word[0,1].upcase
    word[1, word.size] = word[1, word.size].downcase
  end
  z.nome = array.join(" ")
  puts z.nome
  
  z.save
end

Departamento.all.each do |z|
  array = z.nome.split(" ")
  array.each do |word|
    word[0,1] = word[0,1].upcase
    word[1, word.size] = word[1, word.size].downcase
  end
  z.nome = array.join(" ")
  puts z.nome
  
  z.save
end