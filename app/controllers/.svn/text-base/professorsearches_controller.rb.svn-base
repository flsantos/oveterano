class ProfessorsearchesController < ApplicationController
  layout 'application'
  

  def index
      @professorsearch = Professor.find_professores(session[:q], params[:page])
      respond_to do |format|
        format.js
      end
  end

  def new
  end

  def create
    params[:professorsearch][:nome] = "" if params[:professorsearch][:nome] == " Nome, departamento, disciplina..."
    @professorsearch = Professor.find_professores(params[:professorsearch][:nome], params[:page])
    session[:q] = params[:professorsearch][:nome]
    respond_to do |format|
        format.js
    end
  end

  
  def auto_complete
      @professorsearches = Professor.find(:all, :order => "nome ASC", :conditions => ["nome like ?", "%#{params[:q]}%"])
      respond_to do |format|
        format.js
      end
  end
  

  helper_method :getNota
  def getNota(id_prof)
    votosLike = Voto.find_all_by_alias_and_alias_id_and_voto(2, id_prof, 1).count
    votosDislike = Voto.find_all_by_alias_and_alias_id_and_voto(2, id_prof, 0).count

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
