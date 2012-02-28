@overide
#O FORMATO DESSE SCRIPT DEVE ESTAR EM UTF-8 (SEM BOM)

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'date'


#OBS: Nesse script, o horario de uma aula é guardado da seguinte forma:
# O script roda nas ofertas procurando por horários diferentes, e então ele guarda
# por exemplo para a oferta Terça e Quinta das 10 as 11:50, ele irá guardar dois horarios:
# terça 10 as 11:50 e quinta das 10 as 11:50

dias_da_semana = ["Domingo", "Segunda", "Ter", "Quarta", "Quinta", "Sexta", "bado"]

def getDia(dia) 
  case dia
      when "Domingo"
          return 7
      when "Segunda"
          return 1
      when "Terça"
          return 2
      when "Quarta"
          return 3
      when "Quinta"
          return 4
      when "Sexta"
          return 5
      when "Sábado"
          return 6
  end
end
def getDiaSemanaModificado(dia) 
  case dia
      when "Domingo"
          return "Domingo"
      when "Segunda"
          return "Segunda"
      when "Ter"
          return "Terça"
      when "Quarta"
          return "Quarta"
      when "Quinta"
          return "Quinta"
      when "Sexta"
          return "Sexta"
      when "bado"
          return "Sábado"
  end
end

cont = 0
retries = 100

  #******************************************************CONFIGURE AQUI O DIRETORIO ONDE ESTÃO OS .HTML
  #Nessa pasta só devem estar os arquivos do tipo dados_oferta...
  #dir = Dir.new "C:/Users/fernando/Desktop/Dados/Ofertas_Dados"
  #dir.each { |fileHtml|
    
  #  if (fileHtml != ".") and (fileHtml != "..")
    
    
   Departamento.all.each do |depto|
      Disciplina.find_all_by_departamento_id(depto.id).each do |disc|
    
     # doc = Nokogiri::HTML(File.open("C:/Users/fernando/Desktop/Dados/Ofertas_Dados/#{fileHtml}"), nil, 'utf-8')
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
      
      horarios = [] #array de arrays do tipo Date(alterado) -> guarda o dia, horario e duração de cada aula  
     
     
      horariosdeAula = []
      doc.xpath('//table[@class = "framecinza"]//tr/td[@class = "padrao"]').each do |node|
          

        node.child.remove
        node.children.each do |child|
            if (child.last_element_child != nil)
                child.last_element_child.remove
            end
        end
        text = node.to_s.gsub(/<\/?[^>]*>/, "")
        
        
        
        diasdeAula = []
        horariosdeAula = []
        

          dias_da_semana.each do |dia_da_semana|
            while text.include?(dia_da_semana)
              diasdeAula << getDiaSemanaModificado(dia_da_semana)
              text[dia_da_semana] = ""
            end
          end
          
          while text =~ /\d{2}:\d{2}/
            horariosdeAula << text[/\d{2}:\d{2}/] 
            text[/\d{2}:\d{2}/]  = ""
          end  
      
      
          j = 0
          diasdeAula.each do |d|
                
              dia = getDia(d)
              
              hora_ini = horariosdeAula[j]    
              hora_fim = horariosdeAula [j+1]

              h = Horario.new
              h.dia = dia
              h.horario_ini = hora_ini
              h.horario_fim = hora_fim
              h.save
              
              j = j + 2
          end
      
      end
     

    end
   #end 
    
    puts cont
    cont = cont + 1
  end
  #}