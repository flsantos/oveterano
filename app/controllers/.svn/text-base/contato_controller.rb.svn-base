class ContatoController < ApplicationController
  
  def index
  end
  
  def enviar_email_contato

    begin
      if params[:nome] == "(opcional)"
          params[:nome] = "Anônimo"
      end
      if params[:email] == "(opcional)"
          params[:email] = "Email Anônimo"
      end
  	  Mailer.deliver_envia_email_contato(params[:nome], params[:email], params[:mensagem])
  	  flash[:notice] = " Contato realizado. Obrigado!"
    rescue
      flash[:error] = " Serviço indisponível no momento. Por favor entre em contato via contato@oveterano.com"
    end

    redirect_to :back
  end

end

