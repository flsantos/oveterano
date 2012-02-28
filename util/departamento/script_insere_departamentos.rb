if __FILE__ == $0

    #Para executar esse script deve-se: Ir na pasta do projeto, e executar o comando ruby script/console para executar
    #o console, então copie o código abaixo e cole no console que se abrirá!

    require 'rubygems'
    require 'nokogiri'
    require 'open-uri'

retries = 100

    #doc = Nokogiri::HTML(File.open("util/departamento/oferta_dep822d.html"))
    begin
      doc = Nokogiri::HTML(open("http://www.matriculaweb.unb.br/matriculaweb/graduacao/oferta_dep.aspx?cod=1"), nil, 'utf-8')
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

    num = (arrayNodes.count)/3
    
    j = 0
    num.times do |i|
      d = Departamento.new
            d.codigo = arrayNodes[j]
            d.sigla = arrayNodes[j+1]
            d.nome = arrayNodes[j+2] 
            j = j + 3  
        d.save
      
    end
  
    begin
        doc = Nokogiri::HTML(open("http://www.matriculaweb.unb.br/matriculaweb/graduacao/oferta_dep.aspx?cod=2"), nil, 'utf-8')
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

    num = (arrayNodes.count)/3
    
    j = 0
    num.times do |i|
      d = Departamento.new
            d.codigo = arrayNodes[j]
            d.sigla = arrayNodes[j+1]
            d.nome = arrayNodes[j+2] 
            j = j + 3  
        d.save
      
    end
    
    begin
        doc = Nokogiri::HTML(open("http://www.matriculaweb.unb.br/matriculaweb/graduacao/oferta_dep.aspx?cod=3"), nil, 'utf-8')
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

    num = (arrayNodes.count)/3
    
    j = 0
    num.times do |i|
      d = Departamento.new
            d.codigo = arrayNodes[j]
            d.sigla = arrayNodes[j+1]
            d.nome = arrayNodes[j+2] 
            j = j + 3  
        d.save
      
    end
    begin
        doc = Nokogiri::HTML(open("http://www.matriculaweb.unb.br/matriculaweb/graduacao/oferta_dep.aspx?cod=4"), nil, 'utf-8')
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

    num = (arrayNodes.count)/3
    
    j = 0
    num.times do |i|
      d = Departamento.new
            d.codigo = arrayNodes[j]
            d.sigla = arrayNodes[j+1]
            d.nome = arrayNodes[j+2] 
            j = j + 3  
        d.save
      
    end
    
    
    
    
    
    
    
  

  
end