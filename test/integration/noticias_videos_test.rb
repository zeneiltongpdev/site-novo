require_relative '../test_helper.rb'
require_relative '../methods.rb'
require 'watir-webdriver'

class IntegrationTest < ActiveSupport::TestCase
	def setup
		@browser = Watir::Browser.new :phantomjs
		move_out_posts_and_start_jekyll
	end

	def teardown
		@browser.close
		move_in_posts_and_kill_jekyll
	end

	test 'should verify that Noticias and Videos sections are NOT shown when there is no content available for Agronegocio' do
		@browser.goto path_to('agronegocio')
		get_noticias_videos_section
		assert_not @noticias.exists?, "Noticias section is shown at Agronegocio page!"
		assert_not @videos.exists?, "Vídeos section is shown at Agronegocio page!"
	end
end
