class GradesController < ApplicationController
  before_filter :verifica_login
  
  def index
  end

 
  def new
    @grade = Grade.new
  end
  
  def edit
    @grade = Grade.find(params[:id])
  end
  
  
  def create
    
    @grade = Grade.new :usuario_id => current_usuario.id,
                       :semestre   => params[:semestre_select],
                       :nome       => params[:nome_grade]

    respond_to do |format|
      if @grade.save
        flash[:notice] = 'Grade horária criada com sucesso!'
        format.html { redirect_to( grades_path) }
      else
        flash[:error] = "Erro ao criar a grade horária."
        format.html { redirect_to :back }
      end
    end    
  end
  
  
  def update
    @grade = Grade.find(params[:id])

    respond_to do |format|
      if @grade.update_attributes(params[:grade])
        flash[:notice] = "Grade horária atualizada com sucesso"
        format.html { redirect_to grades_path }
      else
        flash[:error] = "Erro ao atualizar as informações da grade horária"
        format.html { render :action => "edit" }
      end
    end 
  end
  
  def destroy
    @grade = Grade.find(params[:idGrade])
    if @grade.ofertas.include?(Oferta.find(params[:idTurma]))
        @grade.ofertas.delete(Oferta.find(params[:idTurma]))
    end
    render :text => "Disciplina removida da grade horária."
  end

  
  
  
  def getgradedata
      @grade_atual = Grade.find(params[:idGrade])
      
      #setGradeAtual(@grade.id)
      session[:grade_atual] = nil
      session[:grade_atual] = @grade_atual.id
      
      eventosHash = []
      ofertas = @grade_atual.ofertas
      ofertas.each do |oferta|
          oferta.horarios.each do |horario|
              date = encontraDiaCerto(horario.dia)
              inicio = Time.local(date.year, date.month, date.day, horario.horario_ini[0,2], horario.horario_ini[3,5], "00")
              fim = Time.local(date.year, date.month, date.day, horario.horario_fim[0,2], horario.horario_fim[3,5], "00")
              disc = Disciplina.find(oferta.disciplina_id)
              eventosHash << {:id => horario.id, :start => inicio, :end => fim, :title => "#{disc.nome} <br/>=<br/> Turma #{oferta.turma}"}
          end
      end
      
      render :json => eventosHash.to_json
  end

  def geteventos
    #Evento.create! :titulo => "Evt3", :corpo => "Corpo do Evt3", :inicio => Time.new, :fim => Time.new
    #eventos = [{:id => 1, :title => "Evt1", :body => "Corpo do Evt1", :start => "2011-06-05T13:00:00.000+10:00", :end => "2011-06-05T14:00:00.000+10:00"}].to_json
    
    #eventosHash = []
    #@grades = Grades.find_all_by_usuario_id(current_usuario.id)
    #@grades.each do |evento|
    #  alteraData (evento)
    #  eventosHash << {:id => evento.id, :start => evento.inicio, :end => evento.fim, :title => evento.titulo}
    #end


    #"[{\"id\":1, \"start\":\"2011-06-05T13:00:00.000+10:00\", \"end\":\"2011-06-05T14:00:00.000+10:00\", \"title\":\"Lunch with Mike\", \"body\":\"Teste\"}]"
    #render :json => eventosHash.to_json

    
    respond_to do |format|
      format.js
    end
  end
  
  
  def getdisciplinas
    disciplinas = Disciplina.find_by_sql("select id, nome from disciplinas order by nome asc")
    
    result = ""
    disciplinas.each do |disciplina|
        if disciplina.nome == params[:disciplina_nome]
          result.concat "<option selected=\"selected\" value=\"#{disciplina.id}\">#{disciplina.nome}</option> "
        else
          result.concat "<option value=\"#{disciplina.id}\">#{disciplina.nome}</option> "
        end
    end
    
    render :text => result
  end
  
  
  
  def getturmas
    ofertas = Oferta.find_all_by_disciplina_id(params[:id])
    
    result = ""
    ofertas.each do |oferta|
        if oferta.turma == params[:turma_selecionada]
            result.concat "<option selected=\"selected\" value=\"#{oferta.id}\">#{oferta.turma}</option> "  
        else
            result.concat "<option value=\"#{oferta.id}\">#{oferta.turma}</option> "
        end
    end
    
    render :text => result
  end
  
  
  
  def createevento
    @grade = Grade.find(params[:idGrade])
    oferta = Oferta.find(params[:idTurma])
    @grade.ofertas << oferta
    
    respond_to do |format|
      if @grade.save
        flash[:notice] = 'Disciplina adicionada com sucesso!'
        format.html { redirect_to( grades_path) }
      else
        flash[:error] = "Erro ao adicionar a disciplina."
        format.html { redirect_to :back }
      end
    end    
  end
  

  
  
  helper_method :getGradeAtual
  def getGradeAtual
     render :text => session[:grade_atual] 
  end
  
  helper_method :setGradeAtual
  def setGradeAtual(grade_id)
    session[:grade_atual] = grade_id
  end

  
  
  helper_method :getSemestres
  def getSemestres
      ano = Time.now.year - 1
      
      semestres = []
      50.times do |x|
          semestres << "1/#{ano + x}"
          semestres << "2/#{ano + x}"
      end
      
      return semestres
  end
  
  
  private
  def alteraData (evento)
    
    diaCerto = evento.inicio.wday
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
    
    evento.inicio = Time.local(tempoCerto.year, tempoCerto.month, tempoCerto.day, evento.inicio.hour, evento.inicio.min, evento.inicio.sec)
    evento.fim = Time.local(tempoCerto.year, tempoCerto.month, tempoCerto.day, evento.fim.hour, evento.fim.min, evento.fim.sec)
    
  end
  
  
  
  
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


  def verifica_login
    flash[:error] = "Você precisa estar logado para acessar essa página" unless logged_in?
    redirect_to :controller => "inicio" unless logged_in?
  end
  
end
