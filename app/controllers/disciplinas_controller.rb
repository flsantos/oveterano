class DisciplinasController < ApplicationController
  layout "application"

  def anexos
    
  end

  def anexar 
    @disciplina = Disciplina.find(params[:id])
    @assets = @disciplina.assets.paginate(:per_page => 15, :page => params[:page])
  end
  
  def anexando
    @disciplina = Disciplina.find(params[:disciplina_id])
    
    
    #if params[:descricao].size > 60 || params[:descricao].size < 4
    #    flash[:error] = "Descrição incorreta."
    #else
    #  if params[:data] == nil
    #      flash[:error] = "Selecione um anexo"
    #  else
        
    if validate_anexo(params)
      @asset = Asset.new
      @asset.usuario = current_usuario
      @asset.descricao = params[:descricao]
      @asset.data = params[:data]
      @disciplina.assets << @asset
      
      if (@disciplina.save)
          flash[:notice] = "Arquivo anexado com sucesso."
      else
          flash[:error] = "Não foi possível adicionar o anexo."
      end
     # end
    end
    redirect_to :action => "anexar", :id => @disciplina.id
  end
  
  def excluir_asset
    
      @asset = Asset.find(params[:id])
      if current_usuario.id == @asset.usuario.id
          @asset.destroy
      else
        flash[:error] = "Você não tem permissão para executar essa tarefa."
      end
      
      redirect_to :action => "anexar", :id => params[:disciplina_id]
  end

  def show
      #Alias igual a 1 significa que são posts de disciplinas
      #Alias igual a 2 significa que são posts de professores
      @disciplina = Disciplina.find(params[:id])
      @posts = Post.find(:all, :order => "created_at DESC", :conditions => ["alias = ? and alias_id = ?", 1, params[:id]]).paginate(:per_page => 10, :page => params[:page])
      @votosLike = Voto.find_all_by_alias_and_alias_id_and_voto(1, params[:id], 1).count
      @votosDislike = Voto.find_all_by_alias_and_alias_id_and_voto(1, params[:id], 0).count
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
    @post.alias = 1
    @post.alias_id = params[:id]
    @post.autor_id = current_usuario.id
    respond_to do |format|  
      if @post.save  
        #format.html { redirect_to :controller => "disciplinas", :action => "show_posts", :id => params[:id] }
        format.js
      else  
        flash[:error] = "Erro ao salvar comentário."
        format.html { redirect_to :controller => "disciplinas", :action => "show_posts", :id => params[:id] }  
      end  
    end  
  end 
  
  
=begin  
  def like
    if (Voto.find_by_alias_and_alias_id_and_autor_id(1,params[:id],current_usuario.id) == nil)
        @voto = Voto.new
        @voto.alias = 1#Alias 1 = Disciplina, Alias 2 = Professor, Alias 3 = Posts
        @voto.alias_id = params[:id]
        @voto.autor_id = current_usuario.id
        @voto.voto = 1# 1 Significa que o voto foi 'like'
        
        if @voto.save
            render :text => getRating(params[:id])
        else
            render :text => "Nota: 0"
        end
    else
      render :text => getRating(params[:id])
    end
  end
  
  def dislike
    if (Voto.find_by_alias_and_alias_id_and_autor_id(1,params[:id],current_usuario.id) == nil)
        @voto = Voto.new
        @voto.alias = 1 #Alias 1 = Disciplina, Alias 2 = Professor, Alias 3 = Posts
        @voto.alias_id = params[:id]
        @voto.autor_id = current_usuario.id
        @voto.voto = 0 # 0 Significa que o voto foi 'dislike'
        
        if @voto.save
            render :text => getRating(params[:id])
        else
            render :text => "Nota: 0"
        end
    else
      render :text => getRating(params[:id])
    end
  end
  
  
  helper_method :getRating
  def getRating(id_disc)
    votosLike = Voto.find_all_by_alias_and_alias_id_and_voto(1, id_disc, 1).count
    votosDislike = Voto.find_all_by_alias_and_alias_id_and_voto(1, id_disc, 0).count
    
    if votosLike == nil 
      votosLike = 0
    end
    if votosDislike == nil
      votosDislike = 0
    end
    
    if votosDislike + votosLike > 0
        @str = "Nota: #{sprintf("%.1f", (votosLike.to_f/(votosDislike.to_f + votosLike.to_f))*10).to_s}"
        @str = @str + "\nVotos: #{votosLike + votosDislike}"
    else 
        return "Sem votos"
    end
    
  end
=end



  def like
    if (Voto.find_by_alias_and_alias_id_and_autor_id(1,params[:id],current_usuario.id) == nil)
        @voto = Voto.new
        @voto.alias = 1#Alias 1 = Disciplina, Alias 2 = Professor, Alias 3 = Posts
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
    @votosLike = Voto.find_all_by_alias_and_alias_id_and_voto(1, params[:id], 1).count
    @votosDislike = Voto.find_all_by_alias_and_alias_id_and_voto(1, params[:id], 0).count
    
    render "like_dislike.js.erb"
  end
  
  def dislike
    if (Voto.find_by_alias_and_alias_id_and_autor_id(1,params[:id],current_usuario.id) == nil)
        @voto = Voto.new
        @voto.alias = 1 #Alias 1 = Disciplina, Alias 2 = Professor, Alias 3 = Posts
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
    @votosLike = Voto.find_all_by_alias_and_alias_id_and_voto(1, params[:id], 1).count
    @votosDislike = Voto.find_all_by_alias_and_alias_id_and_voto(1, params[:id], 0).count
    
    render "like_dislike.js.erb"
  end
  
  def images
    redirect_to "/images/"+params[:id]+"."+params[:format]
  end
  
  def denuncia
    user = current_usuario == nil ? "Anonimo" : current_usuario.id 
    Mailer.deliver_envia_email_denuncia(Post.find(params[:post_id]).mensagem, params[:post_id], "Disciplina", user)
    render :text => "Comentário denunciado para avaliação."
  end
  
  
  helper_method :getRating
  def getRating(id_disc)
    votosLike = Voto.find_all_by_alias_and_alias_id_and_voto(1, id_disc, 1).count
    votosDislike = Voto.find_all_by_alias_and_alias_id_and_voto(1, id_disc, 0).count
    
    if votosLike == nil 
      votosLike = 0
    end
    if votosDislike == nil
      votosDislike = 0
    end
    
    if votosDislike + votosLike > 0
        @str = "#{sprintf("%.1f", (votosLike.to_f/(votosDislike.to_f + votosLike.to_f))*10).to_s} "
        @str = @str + " #{votosLike + votosDislike}"
    else 
        return "-- 0"
    end
    
  end
  
  
  helper_method :validate_anexo
  def validate_anexo ( params )
    if params[:data] == nil
      flash[:error] = "Selecione um arquivo"
      return false
    end
    if params[:descricao].size < 5
      flash[:error] = "Informe uma descrição útil para quem for procurar este arquivo"
      return false
    end
    asset = Asset.new
    asset.data = params[:data]
    if asset.data_file_size > 1048576
      flash[:error] = "Arquivo muito grande (Max: 1MB)"
      return false
    end
    if params[:descricao].size > 200
      flash[:error] = "Descrição muito grande"
      return false
    end
    
    
    return true
  end

 
end
