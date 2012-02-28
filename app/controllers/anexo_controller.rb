class AnexoController < ApplicationController
  
  def index
  end

  def redir
    if (params[:disciplina_select] != '')
      redirect_to :controller => "disciplinas", :action => "anexar", :id => params[:disciplina_select]
    else
      flash['error'] = "Selecione uma disciplina"
      redirect_to :action => :index
    end
  end
  
end
