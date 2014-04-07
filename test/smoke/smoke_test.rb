require_relative '../test_helper.rb'
require 'net/http'
require 'watir-webdriver'

class ProcessPostTest < ActiveSupport::TestCase

	test '/agronegocio is accessible' do
		res = Net::HTTP.get_response(path_to('agronegocio'))
		assert res.code == '200', "/agronegocio is not accessible. response code: #{res.code}"
	end

	test '/agricultura-camponesa is accessible' do
		res = Net::HTTP.get_response(path_to('agricultura-camponesa'))
		assert res.code == '200', "/agricultura-camponesa is not accessible. response code: #{res.code}"
	end

	test '/lutas-e-mobilizacoes is accessible' do
		res = Net::HTTP.get_response(path_to('lutas-e-mobilizacoes'))
		assert res.code == '200', "/lutas-e-mobilizacoes is not accessible. response code: #{res.code}"
	end

	test '/reforma-agraria is accessible' do
		res = Net::HTTP.get_response(path_to('reforma-agraria'))
		assert res.code == '200', "/reforma-agraria is not accessible. response code: #{res.code}"
	end

	test "should verify that Noticias and Videos sections are shown at Agronegocio page" do
		browser = Watir::Browser.new :phantomjs
		browser.goto "http://localhost:4000/agronegocio/"

		noticias = browser.section :class => "noticias"
		videos = browser.section :class => "videos"

		assert noticias.exists?, "Noticias section is not shown at Agronegocio page!"
		assert videos.exists?, "Vídeos section is not shown at Agronegocio page!"
	end

	def path_to(page)
		URI.parse(URI.encode("http://0.0.0.0:4000/#{page}/"))
	end

end
