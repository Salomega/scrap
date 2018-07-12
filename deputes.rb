require 'rubygems'
require 'nokogiri'
require 'open-uri'


def get_deputy_emails(deputy_page)
	doc = Nokogiri::HTML(open(deputy_page))
	dep_email =[]
	doc.css('a').select{  |link| dep_email<<link.text if link.to_s.include?("mailto")}

end
#get_deputy_emails("https://www.nosdeputes.fr/berangere-abba")

def get_dep_name
	doc = Nokogiri::HTML(open("https://www.nosdeputes.fr/deputes"))
	dep_names =[]
	doc.css('span[class = list_nom]').each{  |name| 
		dep_names<< name.text.to_s[7...-4]
		}
		return dep_names
end

#get_dep_name
@dep_webpages =[]
@dep_first_names =[]
@dep_last_names =[]
def get_first_last_name
	tableau = get_dep_name

	tableau.each {|name| 
		a = name.split
		first_name = a[1]
		last_name = a[0][0...-1]
		webpage = "https://www.nosdeputes.fr/#{first_name}-#{last_name}"
		@dep_webpages<<webpage
		@dep_first_names<< first_name
		@dep_last_names<< last_name
	}

end

get_first_last_name

 puts @dep_webpages[1].class
  p @dep_webpages[10]
# p @table_deputes

p get_deputy_emails(@dep_webpages[1])
 
@table_deputes =[]
def get_dep_complete
	doc = Nokogiri::HTML(open("https://www.nosdeputes.fr/deputes"))
	#hash_deputes=Hash.new 
		#i=0
		#while i<=10
			
		@dep_webpages.each { |page|  
			@table_deputes << get_deputy_emails(page)
			# hash_i["first_name :" ] = @dep_first_names[i]
			# hash_i["last_name :"] = @dep_last_names[i]
			#hash_i["email :"] = get_deputy_emails(page)	
		#@table_deputes << { "first_name :" => @dep_first_names[i] , "last_name :" => @dep_last_names[i] , "email :" => get_deputy_emails(page)  }			
		#i+=1
		}
	#end
	
end

#get_dep_complete
#  puts @dep_webpages[1].class
#   p @dep_webpages[10]
# # p @table_deputes

# get_deputy_emails(@dep_webpages[1])

# p @dep_first_names 
# p @dep_last_names 
=begin
def get_the_emails_of_all_townhals_of_val_doise
	
	tableau_emails_mairies = []

	tableau_url = get_all_the_urls_of_val_doise_townhalls 

	tableau_url.each { |page_url|
		email_mairie = get_the_email_of_a_townhal_from_its_webpage(page_url)
		tableau_emails_mairies << email_mairie	
		}
	

	noms_villes = []
	doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	doc.css('a[class = lientxt]').each{  |name|   noms_villes << name.text	}
	

	hash_des_villes = Hash[noms_villes.zip(tableau_emails_mairies)]
	p hash_des_villes
end

def get_dep_webpage
	tableau = get_dep_name
	dep_webpages =[]
	tableau.each {|name| 
		a = name.split
		first_name = a[0][0...-1]
		last_name = a[1]
		dep_webpages<<"https://www.nosdeputes.fr/#{}damien-abad"
	}
end



def get_the_email_of_a_townhal_from_its_webpage (mairie_url)
	doc = Nokogiri::HTML(open(mairie_url))

	#puts doc.css('title')

	return doc.css('td')[7].text
	
	#marche aussi avec : puts doc.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
	#marche presque avec : puts doc.xpath("//td").select { |lestd| lestd.text if lestd.text.include?("@")}

end

#p get_the_email_of_a_townhal_from_its_webpage("http://annuaire-des-mairies.com/95/vaureal.html")

def get_all_the_urls_of_val_doise_townhalls 
	doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	 #doc.css('a').map { |link| link['href'] }
			array_des_sites = []
			doc.css('a[class = lientxt]').each{  |link|
				lien = link['href']
				lien[0]= ''
				url = "http://annuaire-des-mairies.com#{lien}"
				array_des_sites << url
				}
		return array_des_sites
	# doc.xpath('//a[@class = "lientxt"]/@href').each do |lien|
	# 	link = lien.text
	# 	link[0] = ''
	# 	puts "http://annuaire-des-mairies.com#{lien}"
	#  end

end

#p get_all_the_urls_of_val_doise_townhalls

def get_the_emails_of_all_townhals_of_val_doise
	
	tableau_emails_mairies = []

	tableau_url = get_all_the_urls_of_val_doise_townhalls 

	tableau_url.each { |page_url|
		email_mairie = get_the_email_of_a_townhal_from_its_webpage(page_url)
		tableau_emails_mairies << email_mairie	
		}
	

	noms_villes = []
	doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	doc.css('a[class = lientxt]').each{  |name|   noms_villes << name.text	}
	

	hash_des_villes = Hash[noms_villes.zip(tableau_emails_mairies)]
	p hash_des_villes
end

#get_the_emails_of_all_townhals_of_val_doise

=end