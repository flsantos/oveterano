class DisciplinasearchesController < ApplicationController
  layout 'application'
  

  def new
  end

  def index
    @disciplinasearch = Disciplina.find_disciplinas(session[:q], params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end


  def create
    params[:disciplinasearch][:nome] = "" if params[:disciplinasearch][:nome] == " Código, nome, departamento, professor..."
    @disciplinasearch = Disciplina.find_disciplinas(params[:disciplinasearch][:nome], params[:page])
    session[:q] = params[:disciplinasearch][:nome]
    respond_to do |format|
        format.js #create.js.erb ou create.js.rjs
    end
  end


  def auto_complete
      @disciplinasearches = Disciplina.find(:all, :joins => :departamento, :conditions => ["disciplinas.nome like ? or disciplinas.codigo LIKE ? or departamentos.nome like ?", "%#{params[:q]}%" , "%#{params[:q]}%", "%#{params[:q]}%" ])
      respond_to do |format|
        format.js
      end
  end


    helper_method :getNota
  def getNota(id_disc)
    votosLike = Voto.find_all_by_alias_and_alias_id_and_voto(1, id_disc, 1).count
    votosDislike = Voto.find_all_by_alias_and_alias_id_and_voto(1, id_disc, 0).count

    if votosLike == nil
      votosLike = 0
    end
    if votosDislike == nil
      votosDislike = 0
    end

    if (votosLike + votosDislike) > 0
        num = sprintf("%.1f", (votosLike.to_f/(votosDislike.to_f + votosLike.to_f))*10)
    else
        "--"
    end

  end
  
end
