

require 'rubygems'
require 'nokogiri'
require 'open-uri'
    
urlBuscaFluxo = "http://www.matriculaweb.unb.br/matriculaweb/graduacao/fluxo.aspx?cod="    

cont = 0
retries = 100
   Habilitacao.all.each do |habil|
     
     
     
     puts cont
     cont = cont + 1
    
        begin
            doc = Nokogiri::HTML(open("#{urlBuscaFluxo}#{habil.codigo}"), nil, 'utf-8')
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
        doc.xpath('//table[@class = "FrameCinza"]//tr[@class = "padraomenor"]/td').each do |node|
            if node.text != ""
                if node.text =~ /\d{6}/
                    arrayNodes << node.text[/\d{6}/]
                end
            end
        end
    
    
        f = Fluxo.new
            arrayNodes.each do |i|
                if (Disciplina.find_by_codigo(i) != nil)
                    f.disciplinas << Disciplina.find_by_codigo(i)  
                end
            end
        f.save
        
        h = Habilitacao.find_by_codigo(habil.codigo)
            h.fluxo_id = f.id
        h.save

   end