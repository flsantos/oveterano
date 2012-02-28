    require 'rubygems'
    require 'nokogiri'
    require 'open-uri'
    require 'date'
    require 'time'
    
    url = "C:/Users/fernando/Desktop/Dados"
    
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
  
  
class HorarioAula

  attr_accessor :dias #array de string
  attr_accessor :horarios #array de string
  
  #exemplo: [ 1(segunda), 3(quarta)], [ 10:00, 11:50, 10:00, 11:50]
  def initialize(dias, horarios)
    @dias, @horarios = dias, horarios
  end
end



#*************************INSERE OS CAMPUS NO BANCO****************************************

    c = Campus.new
      c.nome = "Darcy Ribeiro"
      c.save
      
    c = Campus.new
      c.nome = "Planaltina"
      c.save
      
    c = Campus.new
      c.nome = "Ceilândia"
      c.save
      
    c = Campus.new
      c.nome = "Gama"
      c.save
      
      
      
      
      
      
      
      
      
      
#*************************INSERE OS DEPARTAMENTOS NO BANCO****************************************








    #Para executar esse script deve-se: Ir na pasta do projeto, e executar o comando ruby script/console para executar
    #o console, então copie o código abaixo e cole no console que se abrirá!



dir = Dir.new "#{url}/Dados_Departamento"
  
    dir.each { |fileHtml|
  
    if (fileHtml != ".") and (fileHtml != "..")
        

    doc = Nokogiri::HTML(File.open("#{url}/Dados_Departamento/#{fileHtml}"))

    
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
    
}
  
    







#*************************INSERE AS DISCIPLINAS NO BANCO****************************************





cont = 0
retries = 100
dir = Dir.new "#{url}/Ofertas_Dis"
  
  dir.each { |fileHtml|
  
    if (fileHtml != ".") and (fileHtml != "..")
     
     puts cont
     cont = cont + 1

        doc = Nokogiri::HTML(File.open("#{url}/Ofertas_Dis/#{fileHtml}"))
       
        
        
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

   }





#******ATUALIZA DISCIPLINAS********************************************


cont = 0
retries = 100
dir = Dir.new "#{url}/Ofertas_Dados"
  
  dir.each { |fileHtml|
    
   if (fileHtml != ".") and (fileHtml != "..")
    
    
      doc = Nokogiri::HTML(File.open("#{url}/Ofertas_Dados/#{fileHtml}"))
  
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
    }









#*************************INSERE OS HORARIOS NO BANCO****************************************



#OBS: Nesse script, o horario de uma aula é guardado da seguinte forma:
# Se temos uma aula, por exemplo, no horario de Terça e Quinta das 10:00 ás 11:50, 
# o programa irá guardar 4 datas, uma Terça ás 10 (2011-08-2 10:00), Terça as 11:50 (2011-08-2 11:50) e assim
# por diante. Ou seja, ele guarda o dia da semana de acordo com um dia do mês fixado no mes 08 de 2011.
#Pois nesse mes o domingo  é dia 7, segunda é dia 1, terça dia 2.... e assim vai


cont = 0
retries = 100

  #******************************************************CONFIGURE AQUI O DIRETORIO ONDE ESTÃO OS .HTML
  #Nessa pasta só devem estar os arquivos do tipo dados_oferta...
dir = Dir.new "#{url}/Ofertas_Dados"
  dir.each { |fileHtml|
    
    if (fileHtml != ".") and (fileHtml != "..")
    

    
      doc = Nokogiri::HTML(File.open("#{url}/Ofertas_Dados/#{fileHtml}"))

      
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
  }
  
  
  
  
  
#*************************INSERE AS RESERVAS NO BANCO****************************************



  i= 0
  retries = 100
dir = Dir.new "#{url}/Ofertas_Dados"
  dir.each { |fileHtml|
    if (fileHtml != ".") and (fileHtml != "..")
     

          
       doc = Nokogiri::HTML(File.open("#{url}/Ofertas_Dados/#{fileHtml}"))

  
  
  
  
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
  }




#*************************INSERE OS PROFESSORES NO BANCO****************************************




cont = 0
retries = 100


  dir = Dir.new "#{url}/Ofertas_Dados"
  
  dir.each { |fileHtml|
  
    
    if (fileHtml != ".") and (fileHtml != "..")
    
      doc = Nokogiri::HTML(File.open("#{url}/Ofertas_Dados/#{fileHtml}"))

               
                
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
    }




#*************************INSERE AS OFERTAS NO BANCO****************************************






cont = 0
retries = 100
  #******************************************************CONFIGURE AQUI O DIRETORIO ONDE ESTÃO OS .HTML
  #Nessa pasta só devem estar os arquivos do tipo dados_oferta...
dir = Dir.new "#{url}/Ofertas_Dados"
  
  dir.each { |fileHtml|
    
    if (fileHtml != ".") and (fileHtml != "..")
    
      doc = Nokogiri::HTML(File.open("#{url}/Ofertas_Dados/#{fileHtml}"))
  
        
        
  
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
                  horarios.each do |horario|
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
    #end
  #}
  
    end 
  }
  
  
  
  
  
  
  
#*************************INSERE OS CURSOS NO BANCO****************************************



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





#*************************INSERE AS HABILITACOES NO BANCO**********************************




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
    

urlBuscaHabilitacao = "http://www.matriculaweb.unb.br/matriculaweb/graduacao/curso_dados.aspx?cod="
    
cont = 0
retries = 100

   Curso.all.each do |curso|
     
       puts cont
       cont = cont + 1

        begin
            doc = Nokogiri::HTML(open("#{urlBuscaHabilitacao}#{curso.codigo}"), nil, 'utf-8')
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
        doc.xpath('//table[@class = "FrameCinza"]//tr[@class = "PadraoBranco"]/td').each do |node|
            if node.text != ""
                array = node.text.split("-")
                
                cod = array.shift
                nome = array.to_s.strip.upcase
              
              
                arrayNodes << cod
                arrayNodes << nome
            end
        end
    
        num = (arrayNodes.count)/2
    
        j = 0
        num.times do |i|
            h = Habilitacao.new
                h.codigo = arrayNodes[j]
                h.nome = arrayNodes[j+1]
                h.curso_id = curso.id
                j = j + 2  
            h.save
        end
   end



#*************************INSERE OS FLUXOS E ATUALIZA AS HABILITACOES NO BANCO*************





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






#*************************INSERE OS CURRICULOS E ATUALIZA AS HABILITACOES NO BANCO*********




urlBuscaFluxo = "http://www.matriculaweb.unb.br/matriculaweb/graduacao/curriculo.aspx?cod="    

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
        doc.xpath('//table[@class = "FrameCinza"]//tr/td').each do |node|
            if node.text != ""
                if node.text =~ /\d{6}/
                    arrayNodes << node.text[/\d{6}/]
                end
            end
        end
    
    

        c = Curriculo.new
            arrayNodes.each do |i|
                if (Disciplina.find_by_codigo(i) != nil)
                    c.disciplinas << Disciplina.find_by_codigo(i)  
                end
            end
        c.save
        
        h = Habilitacao.find_by_codigo(habil.codigo)
            h.curriculo_id = c.id
        h.save

   end