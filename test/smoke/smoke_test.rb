require_relative '../test_helper.rb'
require 'net/http'

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

	test '/transgenicos is accessible' do
		res = Net::HTTP.get_response(path_to('transgenicos'))							
		assert res.code == '200',"/transgenicos is not accessible. response code: #{res.code}"
	end

	test '/solidariedade-internacional is accessible' do
		res = Net::HTTP.get_response(path_to('solidariedade-internacional'))							
		assert res.code == '200',"/solidariedade-internacional is not accessible. response code: #{res.code}"
	end

	test '/projeto-popular is accessible' do
		res = Net::HTTP.get_response(path_to('projeto-popular'))							
		assert res.code == '200',"/projeto-popular is not accessible. response code: #{res.code}"
	end
	def path_to(page)
		URI.parse(URI.encode("http://0.0.0.0:4000/#{page}/"))
	end
end
