class Mailer < ActionMailer::Base
	
	def envia_email_contato(nome, email, mensagem)
		recipients "contato@oveterano.com.br"
		from email
    sent_on Time.now
		subject "Contato - OVeterano.com [#{nome}][#{email}]"
		body mensagem
  end
  
  def envia_email_denuncia(post, post_id, tipo, usuario)
    recipients "contato@oveterano.com.br"
    from "contato@oveterano.com.br"
    sent_on Time.now
    subject "Denuncia Comentário [#{tipo}][Post_ID=#{post_id}][Denunciador=#{usuario}]"
    body post
  end

  def envia_email_confirmacao(usuario)
    @usuario = usuario
    @url = "http://www.oveterano.com/usuarios/activate/#{usuario.activation_code}"
    recipients usuario.email
    #from "no-reply@oveterano.com"
    from "contato@oveterano.com.br"
    sent_on Time.now
    subject "Bem Vindo ao OVeterano.com"
  end
  
  def envia_email_conta_ativada(usuario)
    @usuario = usuario
    @url = "http://www.oveterano.com"
    recipients usuario.email
    #from "no-reply@oveterano.com"
    from "contato@oveterano.com.br"
    sent_on Time.now
    subject 'Sua conta foi ativada com sucesso!'
  end
  
  def envia_email_recuperacao(usuario)
    @usuario = usuario
    @url = "http://www.oveterano.com/reset/#{usuario.reset_code}"
    recipients usuario.email
    #from "no-reply@oveterano.com"
    from "contato@oveterano.com.br"
    sent_on Time.now
    subject "Recuperação de senha - OVeterano.com"
  end
  
	
end