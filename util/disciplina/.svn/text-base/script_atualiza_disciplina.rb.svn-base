

require 'rubygems'
require 'nokogiri'
require 'date'


cont = 0
retries = 100
  #dir = Dir.new "C:/Users/fernando/Desktop/Ofertas_Dados"
  
  #dir.each { |fileHtml|
    
   #if (fileHtml != ".") and (fileHtml != "..")
    
    
      #doc = Nokogiri::HTML(File.open("C:/Users/fernando/Desktop/Ofertas_Dados/#{fileHtml}"))
  
    Departamento.all.each do |depto|
        Disciplina.find_all_by_departamento_id(depto.id).each do |disc|
          
          begin
              doc = Nokogiri::HTML(open("http://www.matriculaweb.unb.br/matriculaweb/graduacao/oferta_dados.aspx?cod=#{disc.codigo}&dep=#{depto.codigo}"), nil, 'utf-8')
          rescue SystemCallError
          puts "Não foi possivel se conectar a página"
          retries = retries - 1;
              if retries > 0
                puts "Tentando novamente..."
                retry
              end
          end
            puts cont
            cont = cont + 1
        
            depto = ""
            codDisc = ""
            creditos = ""
            nome = ""
            campus = ""
        
            doc.xpath('//table[@class = "framecinza"]//font/strong/a').each do |node|
              depto = node.text
              
              arrayDepto = depto.split
              arrayDepto.shift
              arrayDepto.shift
              depto = arrayDepto.join(" ")
              break
           end
          
          
          
            
            doc.xpath('//table[@class = "framecinza"]//td//font/b').each do |node|
              if node.text.match(/\d{6}/)
                codDisc = node.text
                
              end
            end
            
            doc.xpath('//table[@class = "framecinza"]//td/font').each do |node|
              if node.text.match(/\d{3}-\d{3}-\d{3}-\d{3}/)
                creditos = node.text
              
              end
            end
            
            doc.xpath('//table[@class = "framecinza"]//td/font/a').each do |node|
              nome = node.text
              
            end
            
            doc.xpath('//table[@class = "framecinza"]//tr[@class = "padraomenorbranco"]//td/b').each do |node|
              if node.text.include?("Campus:")
                campus = node.text
                campus["Campus:"] = ""
              end
            end
      
       
          
      
              disc = Disciplina.find_by_codigo(codDisc)
      
              if(disc != nil)
                id_campus = nil
                campus_obj = Campus.find_by_nome(campus)
                if campus_obj != nil
                    id_campus = campus_obj.id
                end
                
                id_depto = nil
                depto_obj = Departamento.find_by_nome(depto)
                if depto_obj != nil
                    id_depto = depto_obj.id
                end
                
                disc.creditos = creditos
                disc.departamento_id = id_depto
                
                disc.campi << Campus.find(id_campus) 
                
                disc.save
            end
          
        end
    end
    #end

  #}

  
