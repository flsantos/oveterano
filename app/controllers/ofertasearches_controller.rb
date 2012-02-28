class OfertasearchesController < ApplicationController
  
  
  def index
  end

  def new
    if params[:campus] || params[:departamento] || params[:professor] || params[:curso_fluxo] ||  params[:curso_curriculo] || params[:disciplina] || params[:horarios]
        horarios = []
        if params[:horario]
            params[:horario].count.times do |x|
                horarios << params[:horario]["#{x}"]
            end
        end
        @grades = Grade.find_all_by_usuario_id(current_usuario.id) if logged_in?
        @ofertas = Oferta.find_ofertas(:campus          => params[:campus],
                                       :departamento    => params[:departamento],
                                       :professor       => params[:professor],
                                       :curso_fluxo     => params[:curso_fluxo],
                                       :curso_curriculo => params[:curso_curriculo],
                                       :disciplina      => params[:disciplina],
                                       :horarios        => horarios
                                       )
        @ofertas_sem_pag = @ofertas
       
    
        @ofertas = @ofertas.paginate(:per_page => 20, :page => params[:page])     
    end
    
  end


  def get_horario
    @ofertasearch = params[:ofertasearch]
    respond_to do |format|
      format.js
    end
  end
  
  #:horarios => [[1,'14:00','16:00'], [3, '14:00', '16:00']]
  def getgradedata
      horarios = []
      if params[:horario]
          params[:horario].count.times do |x|
              horarios << params[:horario]["#{x}"]
          end
      end
      
      eventosHash = []
      i=1
      horarios.each do |horario|
        date = encontraDiaCerto(horario[0].to_i)
        inicio = Time.local(date.year, date.month, date.day, horario[1].split(":")[0], horario[1].split(":")[1], "00")
        fim = Time.local(date.year, date.month, date.day, horario[2].split(":")[0], horario[2].split(":")[1], "00")
        eventosHash << {:id => i, :start => inicio, :end => fim, :title => "Horário Livre"}
        i=i+1
      end
      
      render :json => eventosHash.to_json
  end
#Este método não está mais sendo utilizado. 
#Tirei o ajax e coloquei a busca na url, pra ter a opção de voltar numa busca anterior e tal..
=begin
  def search
    
    #Deixa o array de horario no formato [[1,'14:00','16:00'], [3, '14:00', '16:00']]
    horarios = []
    if params[:horario]
        params[:horario].count.times do |x|
            horarios << params[:horario]["#{x}"]
        end
    end
    
    
    @grades = Grade.find_all_by_usuario_id(current_usuario.id) if logged_in?
      

    @ofertas = Oferta.find_ofertas(:campus          => params[:campus],
                                   :departamento    => params[:departamento],
                                   :professor       => params[:professor],
                                   :curso_fluxo     => params[:curso_fluxo],
                                   :curso_curriculo => params[:curso_curriculo],
                                   :disciplina      => params[:disciplina],
                                   :horarios        => horarios
                                   )
    @ofertas_sem_pag = @ofertas                                   

    @ofertas = @ofertas.paginate(:per_page => 20, :page => params[:page])
                                   
    
                                       
    respond_to do |format|
        format.js
    end

  end
=end
  
  def show_ofertas
    @ofertas = Array.new
    @disciplina = Disciplina.find(params[:id])
    params[:ids].each do |id|
        of = Oferta.find_by_id_and_disciplina_id(id, params[:id])
        @ofertas << of unless of == nil
    end
  end

  helper_method :getOfertasPorHorario
  def getOfertasPorHorario (disc, ofertas)
      @ofertas = Array.new
      @disciplina = Disciplina.find(disc)
      ofertas.each do |oferta|
          of = Oferta.find_by_id_and_disciplina_id(oferta.id, disc.id)
          @ofertas << of unless of == nil
      end
      @ofertas
  end

  
  
  
  helper_method :getOfertasSemDisciplinasRepetidas
  def getOfertasSemDisciplinasRepetidas(ofertas)
      ofertas.collect {|oferta| oferta.disciplina_id }.uniq
  end
  
  
  helper_method :getDia
  def getDia(num)
       case num
          when 7
              return "Domingo"
          when 1
              return "Segunda"
          when 2
              return "Terça"
          when 3
              return "Quarta"
          when 4
              return "Quinta"
          when 5
              return "Sexta"
          when 6
              return "Sábado"
       end
  end
  
  helper_method :encontraDiaCerto
  def encontraDiaCerto(diaCerto)
    
     tempoCerto = Time.now
    
    if (diaCerto > 2)
      while (tempoCerto.wday != diaCerto)
        tempoCerto = tempoCerto.advance(:days => -1)
      end
    else
      while (tempoCerto.wday != diaCerto)
        tempoCerto = tempoCerto.advance(:days => 1)
      end
    end
    
    inicioDaSemana = Time.new
    while ( inicioDaSemana.wday != 1)
      inicioDaSemana = inicioDaSemana.advance(:days => -1)
    end
    fimDaSemana = Time.new
    while ( fimDaSemana.wday != 0 )
      fimDaSemana = fimDaSemana.advance(:days => 1)
    end
    
    if (tempoCerto > fimDaSemana)
      tempoCerto = tempoCerto.advance(:days => -7)
    else
        if (tempoCerto < inicioDaSemana)
          tempoCerto = tempoCerto.advance(:days => 7)
        end
    end
    
    return tempoCerto
    
  end
  

  
end
