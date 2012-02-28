

require 'rubygems'
require 'nokogiri'
require 'open-uri'

retries = 100

urlBuscaCurso = "http://www.matriculaweb.unb.br/matriculaweb/graduacao/curso_rel.aspx?cod="

Campus.all.each do |campus|

    begin
      doc = Nokogiri::HTML(open("#{urlBuscaCurso}#{campus.id}"), nil, 'utf-8')
    rescue SystemCallError
      puts "Não foi possivel se conectar a página"
      retries = retries - 1;
      if retries > 0
        puts "Tentando novamente..."
        retry
      end
    end
    
    arrayNodes = []
    #esse comando pega do arquivo codigo, sigla, nome, codigo, sigla, nome... repetidamente
    #e vai guardando tudo isso em array
    doc.xpath('//table[@class = "FrameCinza"]//tr[@class = "PadraoMenor"]/td').each do |node|
        arrayNodes << node.text      
    end

    num = (arrayNodes.count)/4
    
    j = 0
    num.times do |i|
      c = Curso.new
            c.modalidade = arrayNodes[j]
            c.codigo = arrayNodes[j+1]
            c.nome = arrayNodes[j+2]
            c.turno = arrayNodes[j+3] 
            c.campus_id = campus.id
            j = j + 4  
        c.save
      
    end
end