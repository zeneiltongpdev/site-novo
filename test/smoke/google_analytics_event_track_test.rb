require_relative '../test_helper.rb'
require 'watir-webdriver'

class GoogleAnalyticsEventTrackTest < ActiveSupport::TestCase
	def setup 
		@browser = Watir::Browser.new :phantomjs	
		@browser.goto path_to('agronegocio')
	end

	def teardown
		@browser.close
	end

	test 'Parceiros links should be accessible through the Selector defined for Google Analytics event track' do
		parceiros_links = @browser.article(class: "parceiros").ul.li.a.exists?
		assert parceiros_links, "Parceiros links are not accessible. This will break Google Analytics event track!"
	end

	test 'Social links should be accessible through the Selector defined for Google Analytics event track' do
		social_links = @browser.article(class: "social").ul.li.a.exists?
		assert social_links, "Social links are not accessible. This will break Google Analytics event track!"
	end

	test 'Amigos links should be accessible through the Selector defined for Google Analytics event track' do
		amigos_links = @browser.article(class: "amigos").ul.li.a.exists?
		assert amigos_links, "Amigos links are not accessible. This will break Google Analytics event track!"
	end

	test 'Links links should be accessible through the Selector defined for Google Analytics event track' do
		links_links = @browser.article(class: "links").ul.li.a.exists?
		assert links_links, "Links links are not accessible. This will break Google Analytics event track!"
	end

	test 'Mais Noticias link should be accessible through the Selector defined for Google Analytics event track' do
		mais_noticias_link = @browser.section(class: "noticias").p(class: "mais").a.exists?
		assert mais_noticias_link, "Mais Noticias link is not accessible. This will break Google Analytics event track!"
	end

	test 'Mais Videos link should be accessible through the Selector defined for Google Analytics event track' do
		mais_videos_link = @browser.section(class: "videos").p(class: "mais").a.exists?
		assert mais_videos_link, "Mais Videos link is not accessible. This will break Google Analytics event track!"
	end

	test 'Header links should be accessible through the Selector defined for Google Analytics event track' do
		header_links = @browser.nav.ul.li.a.exists?
		assert header_links, "Header links are not accessible. This will break Google Analytics event track!"
	end

	test 'Leia Mais link should be accessible through the Selector defined for Google Analytics event track' do
		leia_mais_link = @browser.details.summary.exists?
		assert leia_mais_link, "Leia mais link is not accessible. This will break Google Analytics event track!"
	end

	test 'Logotipo link should be accessible through the Selector defined for Google Analytics event track' do
		logotipo_link = @browser.header.a.exists?
		assert logotipo_link, "Logotipo link is not accessible. This will break Google Analytics event track!"
	end

	def path_to(page)
		"http://0.0.0.0:4000/#{page}/"
	end
end
