  

  #O FORMATO DESSE SCRIPT DEVE ESTAR EM UTF-8 (SEM BOM)

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'date'
require 'time'


dias_da_semana = ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"]

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

class HorarioAula

  attr_accessor :dias #array de string
  attr_accessor :horarios #array de string
  
  #exemplo: [ 1(segunda), 3(quarta)], [ 10:00, 11:50, 10:00, 11:50]
  def initialize(dias, horarios)
    @dias, @horarios = dias, horarios
  end
end


cont = 0
retries = 100
  #****************************************************CONFIGURE AQUI O DIRETORIO ONDE ESTÃO OS .HTML
  #Nessa pasta só devem estar os arquivos do tipo dados_oferta...
  dir = Dir.new "C:/Users/fernando/Desktop/Dados/Ofertas_Dados"
  
  dir.each { |fileHtml|
    
    if (fileHtml != ".") and (fileHtml != "..")
    
      doc = Nokogiri::HTML(File.open("C:/Users/fernando/Desktop/Dados/Ofertas_Dados/#{fileHtml}"))
  
  
=begin  
  Departamento.all.each do |dpto|
      Disciplina.find_all_by_departamento_id(dpto.id).each do |disc|
        
      begin  
         doc = Nokogiri::HTML(open("http://www.matriculaweb.unb.br/matriculaweb/graduacao/oferta_dados.aspx?cod=#{disc.codigo}&dep=#{dpto.codigo}"), nil, 'utf-8')
      rescue SystemCallError
          puts "Não foi possivel se conectar a página"
          retries = retries - 1;
          if retries > 0
            puts "Tentando novamente..."
            retry
          end
        end
=end        
        
  
      depto = ""
      codDisc = ""
      creditos = ""
      nome = ""
      campus = ""   
      turma = [] #array de string (caracteres)
      vagas = [] #array de arrays de Integer-> guarda vagas totais, vagas ocupadas e vagas disponíveis
      turno = [] #array de strings, Diurno, Noturno, Ambos
      horarios = [] #array de arrays do tipo Date(alterado) -> guarda o dia, horario e duração de cada aula  
      professores = [] #array de array de professores
      reservaVagas = [] #array de strings(reserva/vagas ex: Ciências Sociais(Diurno)/40)
 
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

      doc.xpath('//table[@class = "framecinza"]//tr/td/div[@class = "titulo"]/font/b').each do |node|
        turma << node.text
      end

      doc.xpath('//table[@class = "framecinza"]//tr/td/b/font').each do |node|
      
        t = node.text
          t['Vagas: '] = ""
          t['Ocup.: '] = ""
          t['Disp.: '] = ""
        arrayIn = t.split
        
        vagas << arrayIn
      end
      
      doc.xpath('//table[@class = "framecinza"]//tr/td/div/font').each do |node|
        if node.text.downcase == "Diurno".downcase || node.text.downcase == "Ambos".downcase || node.text.downcase == "Noturno".downcase
          turno << node.text
        end
      end
      
      doc.xpath('//table[@class = "framecinza"]//tr/td[@class = "padrao"]').each do |node|
          

        node.child.remove
        text = node.to_s.gsub(/<\/?[^>]*>/, "")
        diasdeAula = []
        horariosdeAula = []

          dias_da_semana.each do |dia_da_semana|
            while text.include?(dia_da_semana)
              diasdeAula << dia_da_semana
              text[dia_da_semana] = ""
            end
          end
          
          while text =~ /\d{2}:\d{2}/
            horariosdeAula << text[/\d{2}:\d{2}/] 
            text[/\d{2}:\d{2}/]  = ""
          end
          horarios << HorarioAula.new(diasdeAula, horariosdeAula)  
      end

      

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

      doc.xpath('//table[@class = "framecinza"]//tr/td/div[@align = "left"]/font').each do |node|
      
          subNodes= node.children
          
          reserv = []
          subNodes.each do |a|
            if a.to_s != "<br>"
              #if (a.to_s =~ /[a-z]/)
                reserv << a.to_s
                
              #end
            end
          end
          reservaVagas << reserv
      end
      
=begin      
puts depto
puts codDisc
puts creditos
puts nome
puts campus
turma.each do |t|
  puts "#{t} "
end
turno.each do |t|
  puts "#{t} "
end
vagas.each do |vag|
  vag.each do |v|
    puts "#{v} "
  end
end
reservaVagas.each do |r|
  puts "#{r} "
end

puts "\n\n*********************************************************\n\n"
=end      
      
       
      vazias = 0
      semdisc = 0
     
      


      if codDisc != "" and depto != ""
          disciplina_id = nil
          disciplina = nil
          disciplina = Disciplina.find_by_codigo(codDisc)
          if disciplina != nil        
              disciplina_id = disciplina.id
          end
          
          if (disciplina_id != nil)
              turma.count.times { |i| #se a disciplina existe no meu banco, entao mando percorrer todas as ofertas dela
             
                  oferta = Oferta.new
                  
                  oferta.disciplina_id = disciplina_id
                  oferta.turma = turma[i]
                  oferta.turno = turno[i]
                  
                  v = vagas[i]
                  oferta.vagas_totais = v[0]
                  oferta.vagas_ocup = v[1]
                  oferta.vagas_disp = v[2]
                  
                  
                  reservas = []
                  if reservaVagas.count != 0
                      reservaVagas[i].each do |x|
                        if Reserva.find_by_curso(x) != nil
                            reservas << Reserva.find_by_curso(x)
                        end
                      end
                          oferta.reservas = reservas
                  end
                  
                  profs = []
                  professores[i].each do |x|
                      if (Professor.find_by_nome(x) != nil)
                          profs << Professor.find_by_nome(x)
                      end
                  end
                  oferta.professores = profs
             
                  horariosaulas = []
                  horarios[i].each do |horario|
                      a = horario.dias
                      b = horario.horarios
                      diaa = 0
                      j = 0
                      a.each do |x|
                          diaa = getDia(x)
                          hora_ini = b[j]
                          hora_fim = b[j+1]
                          if (Horario.find_by_dia_and_horario_ini_and_horario_fim(diaa, hora_ini, hora_fim) != nil)
                            horariosaulas << Horario.find_by_dia_and_horario_ini_and_horario_fim(diaa, hora_ini, hora_fim)
                          end
                          j = j + 2
                      end
                  end
                  oferta.horarios = horariosaulas
                 
             
                  
                  oferta.save
              }      
          else
              semdisc = semdisc + 1
          end
      else
          vazias = vazias + 1
      end
      
        
      
      
      

    
      cont = cont + 1
      puts cont
    end
  }
  
    #end 
  #end