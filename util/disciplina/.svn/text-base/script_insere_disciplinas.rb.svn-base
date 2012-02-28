if __FILE__ == $0
  
    
    require 'rubygems'
    require 'nokogiri'
    require 'open-uri'
    
cont = 0
retries = 100
#dir = Dir.new "C:/Users/fernando/Desktop/Ofertas_Dis"
  
  #dir.each { |fileHtml|
  
   # if (fileHtml != ".") and (fileHtml != "..") and (fileHtml != "script_insere_disciplinas.rb") and (fileHtml != "script_atualiza_disciplina.rb")
        
   Departamento.all.each do |depto|
     
     puts cont
     cont = cont + 1
     
   codigo = depto.codigo
        #doc = Nokogiri::HTML(File.open("C:/Users/fernando/Desktop/Ofertas_Dados/#{fileHtml}"))
        
        begin
          url = "http://www.matriculaweb.unb.br/matriculaweb/graduacao/oferta_dis.aspx?cod=#{codigo}"
        rescue SystemCallError
          puts "Não foi possivel se conectar a página"
          retries = retries - 1;
          if retries > 0
            puts "Tentando novamente..."
            retry
          end
        end
        
        doc = Nokogiri::HTML(open(url), nil, 'utf-8')
        
        
        arrayNodes = []
        #esse comando pega do arquivo codigo, sigla, nome, codigo, sigla, nome... repetidamente
        #e vai guardando tudo isso em array
        doc.xpath('//table[@class = "FrameCinza"]//tr[@class = "PadraoMenor"]/td').each do |node|
            if node.text != ""
                arrayNodes << node.text
            end
        end
    
        num = (arrayNodes.count)/2
    
        j = 0
        num.times do |i|
            d = Disciplina.new
                d.codigo = arrayNodes[j]
                d.nome = arrayNodes[j+1]
                j = j + 2  
            d.save
        end

   end     
   # end
  #}

    
end