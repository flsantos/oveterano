# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
   before_filter :save_referer
   
   def save_referer
       unless logged_in?
           session['referer'] = request.env["HTTP_REFERER"] unless session['referer']
       end
   end


  # render new.erb.html
  def new
    redirect_to "/" if logged_in?
    session[:from_url] = headers['HTTP_REFERER']
  end

  def create
        
    logout_keeping_session!
    usuario = Usuario.authenticate(params[:login_email], params[:login_password])
    if usuario
      if Usuario.find_by_email(params[:login_email]).activation_code != nil
          flash[:error] = "Confirme o seu cadastro por email."
          render :update do |page|
                page.reload
          end
      else
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
          self.current_usuario = usuario
          new_cookie_flag = (params[:remember_me] == "1")
          handle_remember_cookie! new_cookie_flag
          #redirect_back_or_default(session['referer'])
          flash[:notice] = "Bem vindo #{current_usuario.nome}"
          render :update do |page|
              page.reload
          end
      end
    else
      note_failed_signin
      if ((params[:login_email] == "") or (params[:login_password] == ""))
          flash[:error] = "Os dois campos devem ser preenchidos."      
      else
          flash[:error] = "Email ou senha incorretos."
      end
      @email       = params[:email]
      @remember_me = params[:remember_me]
      respond_to do |format|
        format.js
      end
    end 
  end
  
  def create_2
        
    logout_keeping_session!
    usuario = Usuario.authenticate(params[:login_email], params[:login_password])
    if usuario
      if Usuario.find_by_email(params[:login_email]).activation_code != nil
          flash[:error] = "Confirme o seu cadastro por email."
          redirect_to :back
      else
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
          self.current_usuario = usuario
          new_cookie_flag = (params[:remember_me] == "1")
          handle_remember_cookie! new_cookie_flag
          #redirect_back_or_default(session['referer'])
          flash[:notice] = "Bem vindo #{current_usuario.nome}"
          redirect_to :back
      end
    else
      note_failed_signin
      if ((params[:login_email] == "") or (params[:login_password] == ""))
          flash[:error] = "Os dois campos devem ser preenchidos."      
      else
          flash[:error] = "Email ou senha incorretos."
      end
      @email       = params[:email]
      @remember_me = params[:remember_me]
      redirect_to :back
    end 
  end

  def destroy
    logout_killing_session!
    #flash[:notice] = "Você acaba de se deslogar."
    redirect_back_or_default('/')
  end

protected
  # Track failed login attempts
  def note_failed_signin
    logger.warn "Failed login for '#{params[:login_email]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
