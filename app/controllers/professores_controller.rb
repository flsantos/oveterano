class ProfessoresController < ApplicationController
  layout "application"

  
 def show
      #Alias igual a 1 significa que são posts de disciplinas
      #Alias igual a 2 significa que são posts de professores
      @professor = Professor.find(params[:id])
      @posts = Post.find(:all, :order => "created_at DESC", :conditions => ["alias = ? and alias_id = ?", 2, params[:id]]).paginate(:per_page => 10, :page => params[:page])
      @votosLike = Voto.find_all_by_alias_and_alias_id_and_voto(2, params[:id], 1).count
      @votosDislike = Voto.find_all_by_alias_and_alias_id_and_voto(2, params[:id], 0).count
      @result =  getRating(params[:id])
      respond_to do |format|  
          format.html  
          format.js
      end 
  end
  
  def create_posts 
    @post = Post.create(:mensagem => params[:mensagem])
    #Alias igual a 1 significa que são posts de disciplinas
    #Alias igual a 2 significa que são posts de professores
    @post.alias = 2
    @post.alias_id = params[:id]
    @post.autor_id = current_usuario.id
    respond_to do |format|  
      if @post.save  
        #format.html { redirect_to :controller => "professores", :action => "show_posts", :id => params[:id] }
        format.js
      else  
        flash[:error] = "Erro ao salvar comentário."
        format.html { redirect_to :controller => "professores", :action => "show_posts", :id => params[:id] }  
      end  
    end  
  end 
  
=begin  
  def like
    @prof = Professor.find(params[:id])
    @prof.votos_like+= 1 unless @prof == nil
    if @prof.save
        render :text => getRating(@prof)
    else
        render :text => "Nota: 0"
    end
  end
  
  def dislike
    @prof = Professor.find(params[:id])
    @prof.votos_dislike+= 1 unless @prof == nil
    if @prof.save
        render :text => getRating(@prof)
    else
        render :text => "Nota: 0"
    end
  end
  
  
  helper_method :getRating
  def getRating(obj)
    if obj.votos_dislike + obj.votos_like > 0
        @str = "Nota: #{sprintf("%.1f", (obj.votos_like.to_f/(obj.votos_dislike.to_f+obj.votos_like.to_f))*10).to_s}"
        @str = @str + "\nVotos: #{obj.votos_like + obj.votos_dislike}"
    else 
        return "0 votos"
    end
  end

=end
  def like
    if (Voto.find_by_alias_and_alias_id_and_autor_id(2,params[:id],current_usuario.id) == nil)
        @voto = Voto.new
        @voto.alias = 2#Alias 1 = Disciplina, Alias 2 = Professor, Alias 3 = Posts
        @voto.alias_id = params[:id]
        @voto.autor_id = current_usuario.id
        @voto.voto = 1# 1 Significa que o voto foi 'like'
        
        if @voto.save
            @result =  getRating(params[:id])
        else
            @result = "Nota: 0"
        end
    else
      @result = "#{getRating(params[:id])}<br/>Seu voto já foi computado."
    end
    @votosLike = Voto.find_all_by_alias_and_alias_id_and_voto(2, params[:id], 1).count
    @votosDislike = Voto.find_all_by_alias_and_alias_id_and_voto(2, params[:id], 0).count       
    
    render "like_dislike.js.erb"
  end
  
  def dislike
    if (Voto.find_by_alias_and_alias_id_and_autor_id(2,params[:id],current_usuario.id) == nil)
        @voto = Voto.new
        @voto.alias = 2 #Alias 1 = Disciplina, Alias 2 = Professor, Alias 3 = Posts
        @voto.alias_id = params[:id]
        @voto.autor_id = current_usuario.id
        @voto.voto = 0 # 0 Significa que o voto foi 'dislike'
        
        if @voto.save
            @result =  getRating(params[:id])
        else
            @result = "Nota: 0"
        end
    else
      @result = "#{getRating(params[:id])}<br/>Seu voto já foi computado."
    end
    @votosLike = Voto.find_all_by_alias_and_alias_id_and_voto(2, params[:id], 1).count
    @votosDislike = Voto.find_all_by_alias_and_alias_id_and_voto(2, params[:id], 0).count    
    
    render "like_dislike.js.erb"
  end
  
  
  def denuncia
    user = current_usuario == nil ? "Anonimo" : current_usuario.id
    Mailer.deliver_envia_email_denuncia(Post.find(params[:post_id]).mensagem, params[:post_id], "Professor", user)
    render :text => "Comentário denunciado para avaliação."
  end
  
  
  helper_method :getRating
  def getRating(id_prof)
    votosLike = Voto.find_all_by_alias_and_alias_id_and_voto(2, id_prof, 1).count
    votosDislike = Voto.find_all_by_alias_and_alias_id_and_voto(2, id_prof, 0).count
    
    if votosLike == nil 
      votosLike = 0
    end
    if votosDislike == nil
      votosDislike = 0
    end
    
    if votosDislike + votosLike > 0
        @str = "#{sprintf("%.1f", (votosLike.to_f/(votosDislike.to_f + votosLike.to_f))*10).to_s} "
        @str = @str + "#{votosLike + votosDislike}"
    else 
        return "-- 0"
    end
    
  end




end
