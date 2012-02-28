
class String
  alias_method :old_rapidito_upcase, :upcase
  def upcase
    self.gsub( /\303[\240-\277]/ ) do
      |match|
      match[0].chr + (match[1] - 040).chr
    end.old_rapidito_upcase
  end
  
  alias_method :old_rapidito_downcase, :downcase
  def downcase
    self.gsub( /\303[\200-\237]/ ) do
      |match|
      match[0].chr + (match[1] + 040).chr
    end.old_rapidito_downcase
  end
end
    
require 'rubygems'
require 'nokogiri'
require 'open-uri'

urlBuscaHabilitacao = "http://www.matriculaweb.unb.br/matriculaweb/graduacao/curso_dados.aspx?cod="
    
cont = 0
retries = 100

   Curso.all.each do |curso|
     
       puts cont
       cont = cont + 1

        begin
            doc = Nokogiri::HTML(open("#{urlBuscaHabilitacao}#{curso.codigo}"), nil, 'utf-8')
        rescue SystemCallError
            puts "Não foi possivel se conectar a página"
            retries = retries - 1;
            if retries > 0
                puts "Tentando novamente..."
                retry
            end
         end
        
        
        
        arrayNodes = []
        #esse comando pega do arquivo codigo, sigla, nome, codigo, sigla, nome... repetidamente
        #e vai guardando tudo isso em array
        doc.xpath('//table[@class = "FrameCinza"]//tr[@class = "PadraoBranco"]/td').each do |node|
            if node.text != ""
                array = node.text.split("-")
                
                cod = array.shift
                nome = array.to_s.strip.upcase
              
              
                arrayNodes << cod
                arrayNodes << nome
            end
        end
    
        num = (arrayNodes.count)/2
    
        j = 0
        num.times do |i|
            h = Habilitacao.new
                h.codigo = arrayNodes[j]
                h.nome = arrayNodes[j+1]
                h.curso_id = curso.id
                j = j + 2  
            h.save
        end
   end