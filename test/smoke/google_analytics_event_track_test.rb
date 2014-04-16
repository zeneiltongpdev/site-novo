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

	def path_to(page)
		"http://0.0.0.0:4000/#{page}/"
	end
end
