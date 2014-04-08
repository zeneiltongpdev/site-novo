require_relative '../test_helper.rb'
require 'watir-webdriver'

class SmokeTest < ActiveSupport::TestCase
	def setup
		@browser = Watir::Browser.new :phantomjs
	end

	test 'should verify that Noticias and Videos sections are shown at Agronegocio page' do
		@browser.goto path_to('agronegocio')
		get_noticias_videos_section
		assert @noticias.exists?, "Noticias section is not shown at Agronegocio page!"
		assert @videos.exists?, "Vídeos section is not shown at Agronegocio page!"
	end

	test 'should verify that Noticias and Videos sections are shown at Agricultura Camponesa page' do
		@browser.goto path_to('agricultura-camponesa')
		get_noticias_videos_section
		assert @noticias.exists?, "Noticias section is not shown at Agricultura Camponesa page!"
		assert @videos.exists?, "Vídeos section is not shown at Agricultura Camponesa page!"
	end

	test 'should verify that Noticias and Videos sections are shown at Lutas e Mobilizações page' do
		@browser.goto path_to('lutas-e-mobilizacoes')
		get_noticias_videos_section
		assert @noticias.exists?, "Noticias section is not shown at Lutas e Mobilizações page!"
		assert @videos.exists?, "Vídeos section is not shown at Lustas e Mobilização page!"
	end 

	test 'should verify that Noticias and Videos sections are shown at Reforma Agrária page!' do
		@browser.goto path_to('reforma-agraria')
		get_noticias_videos_section
		assert @noticias.exists?, "Noticias section is not shown at Reforma Agrária page!"
		assert @videos.exists?, "Vídeos section is not shown at Reforma Agrária page!"
	end 

	def path_to(page)
		"http://localhost:4000/#{page}/"
	end

	def get_noticias_videos_section
		@noticias = @browser.section :class => "noticias"
		@videos = @browser.section :class => "videos"
	end
end
