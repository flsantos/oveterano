if __FILE__ == $0
    
require 'rubygems'
require 'nokogiri'
require 'open-uri'

cont = 0
retries = 100

=begin
  dir = Dir.new "C:/Users/fernando/Desktop/Ofertas_Dados"
  
  dir.each { |fileHtml|
  
    
    if (fileHtml != ".") and (fileHtml != "..")
    
      doc = Nokogiri::HTML(File.open("C:/Users/fernando/Desktop/Ofertas_Dados/#{fileHtml}"))
    
=end    
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
          professores = [] #array de array de professores
         
          doc.xpath('//table[@class = "framecinza"]//tr/td[@class = "padraomenor"]/center').each do |node|
              subNodes= node.children
              prof = []
              subNodes.each do |a|
                if a.to_s != "<br>"
                  prof << a.to_s
                end       
              end
              professores << prof
          end
          
          professores.each do |lista|
              lista.each do |prof|
                  prof = prof.strip
                  professor = Professor.find_by_nome(prof)
                  if (professor == nil)
                    p = Professor.new
                        p.nome = prof
                    p.save
                  end
                  
              end
          end
          
          
        end
    end
    
    
    
    
    

      
      
      
    
    
#    end 
#  }


end