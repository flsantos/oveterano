class GradeshorariasController < ApplicationController
  before_filter :verifica_login
  
  def index
      @grades = Grade.all :conditions => {:usuario_id => current_usuario.id}, :order => "created_at desc"
  end
  
  def destroy
    @grade = Grade.find(params[:id])
    @grade.destroy

    respond_to do |format|
      flash[:notice] = "Grade horária excluída com sucesso!"
      format.html { redirect_to( gradeshorarias_path) }
    end
  end
  
  
  private
  def verifica_login
    flash[:error] = "Você precisa estar logado para acessar essa página" unless logged_in?
    redirect_to :controller => "inicio" unless logged_in?
  end
end
