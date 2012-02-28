require 'rubygems'
require 'nokogiri'


url = "C:/Users/fernando/Desktop/professores_facebook.txt"
autor_id = -1 #Id do autor do post (Usuario Facebook)
doc = Nokogiri::HTML(File.open(url))



posts = []

doc.xpath('//div[@class = "storyContent"]').each do |node|

	profNodes = []
	node.xpath('.//span[@class = "messageBody"]').each do |prof_node|
		prof = prof_node.text
		if prof != nil
			if prof != ""
				if (prof.split("-").size > 1)
					prof = prof.split("-")[0]
				end
				prof = prof.strip

				
			end
		end
		profNodes << prof   
	end


	commentNodes = []
	node.xpath('.//span[@data-jsid = "text"]').each do |comment_node|
		msg = comment_node.text
		msg = msg.gsub(/\"/, "")
		commentNodes << msg
	end	
	
	
	posts << [profNodes, commentNodes]
	
end


posts.each do |p|
	puts "---->#{p[0][0]}"
	p[1].each do |y|
		puts "----------------------------->#{y}"
	end	
	puts "\n\n\n"
end



posts.each do |p|
	prof = Professor.find_by_sql("select * from professores where nome like \"%#{p[0][0]}%\"")
	prof = prof.first if prof.class == Array
	if prof != nil
		
		p[1].each do |msg|
			post = Post.new
			post.mensagem = msg
			post.alias = 2
			post.alias_id = prof.id
			post.autor_id = autor_id
			post.save
		end
	end
end
#require 'C:/Users/fernando/Desktop/prof_face.rb'