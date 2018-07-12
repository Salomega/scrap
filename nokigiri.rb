require 'rubygems'
require 'nokogiri'
require 'open-uri'

PAGE_URL = "http://ruby.bastardsbook.com/files/hello-webpage.html"
page = Nokogiri::HTML(open(PAGE_URL))
puts page.css('title')
#puts page.css('li')
puts page.css('li')[0].text
puts page.css('li')[0]['href']
puts page.css("li[data-category='news']")
#puts page.css('div#funstuff')[0]
puts page.css('div#reference a')

def get_the_email_of_a_townhal_from_its_webpage (mairie_url)
	doc = Nokogiri::HTML(open(mairie_url))
	
	#puts doc.css('title')

	return doc.css('td')[7].text
	
	#marche aussi avec : puts doc.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
	#marche presque avec : puts doc.xpath("//td").select { |lestd| lestd.text if lestd.text.include?("@")}

end

p get_the_email_of_a_townhal_from_its_webpage("http://annuaire-des-mairies.com/95/vaureal.html")

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
	p tableau_emails_mairies
	
end

get_the_emails_of_all_townhals_of_val_doise