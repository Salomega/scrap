require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_cryptocurrency_rate
i=0
	while i<3
		doc = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
		array_des_cours = []
		doc.css('a[class = price]').each{ |taux| array_des_cours<< taux.text}

		array_des_monnaies = []
		doc.css('a[class = link-secondary]').each{ |monnaie| array_des_monnaies<< monnaie.text}

		hash_des_cours = Hash[array_des_monnaies.zip(array_des_cours)]
		p hash_des_cours	

		i = i+1
		sleep 3600 # attend 1h (3600 secondes) avant de redémarrer la boucle
	end

end

get_cryptocurrency_rate




