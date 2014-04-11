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

	test 'should verify that Noticias and Videos sections are NOT shown when there is no content available for Agricultura Camponesa' do
		@browser.goto path_to('agricultura-camponesa')
		get_noticias_videos_section
		assert_not @noticias.exists?, "Noticias section is shown at Agricultura Camponesa page!"
		assert_not @videos.exists?, "Vídeos section is shown at Agricultura Camponesa page!"
	end

	test 'should verify that Noticias and Videos sections are NOT shown when there is no content available for Lutas e Mobilizações' do
		@browser.goto path_to('lutas-e-mobilizacoes')
		get_noticias_videos_section
		assert_not @noticias.exists?, "Noticias section is shown at Lutas e Mobilizações page!"
		assert_not @videos.exists?, "Vídeos section is shown at Lustas e Mobilização page!"
	end 

	test 'should verify that Noticias and Videos sections are NOT shown when there is no content available for Reforma Agrária' do
		@browser.goto path_to('reforma-agraria')
		get_noticias_videos_section
		assert_not @noticias.exists?, "Noticias section is shown at Reforma Agrária page!"
		assert_not @videos.exists?, "Vídeos section is shown at Reforma Agrária page!"
	end 

	test 'should verify that Noticias and Videos sections are NOT shown when there is no content available for Transgenicos' do
		@browser.goto path_to('transgenicos')
		get_noticias_videos_section
		assert_not @noticias.exists?, "Noticias section is shown at Transgenicos page!"
		assert_not @videos.exists?, "Vídeos section is shown at Transgenicos page!"
	end 
end
