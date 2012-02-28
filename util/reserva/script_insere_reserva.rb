if __FILE__ == $0
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  
  i= 0
  retries = 100
  #dir = Dir.new "C:/Users/fernando/Desktop/Ofertas_Dados"
  #dir.each { |fileHtml|
  #  if (fileHtml != ".") and (fileHtml != "..")
     
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
  
  
  
  
        reservaVagas = []
  
        doc.xpath('//table[@class = "framecinza"]//tr/td/div[@align = "left"]/font').each do |node|
            subNodes= node.children
            reserv = []
            subNodes.each do |a|
              if a.to_s != "<br>"
                if (a.to_s =~ /[a-z]/)
                  reserv << a.to_s
                end
              end
            end
            reservaVagas << reserv
        end
        
        
        reservaVagas.each do |r|
            r.each do |res|
                reserva = Reserva.new
                    reserva.curso = res
                reserva.save
            end
        end
        
        puts i
        i=i+1
      
      end
  end
#    end
#  }
end