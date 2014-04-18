require_relative '../test_helper.rb'

class ProcessPostTest < ActiveSupport::TestCase

  setup do
    @agent = Mechanize.new
  end

	test '/agronegocio is accessible' do
		res = @agent.get(uri('agronegocio'))
		assert res.code == '200', "/agronegocio is not accessible. response code: #{res.code}"
	end

	test '/agricultura-camponesa is accessible' do
		res = @agent.get(uri('agricultura-camponesa'))
		assert res.code == '200', "/agricultura-camponesa is not accessible. response code: #{res.code}"
	end

	test '/lutas-e-mobilizacoes is accessible' do
		res = @agent.get(uri('lutas-e-mobilizacoes'))
		assert res.code == '200', "/lutas-e-mobilizacoes is not accessible. response code: #{res.code}"
	end

	test '/reforma-agraria is accessible' do
		res = @agent.get(uri('reforma-agraria'))
		assert res.code == '200', "/reforma-agraria is not accessible. response code: #{res.code}"
	end

	test '/transgenicos is accessible' do
		res = @agent.get(uri('transgenicos'))							
		assert res.code == '200',"/transgenicos is not accessible. response code: #{res.code}"
	end

	test '/solidariedade-internacional is accessible' do
		res = @agent.get(uri('solidariedade-internacional'))							
		assert res.code == '200',"/solidariedade-internacional is not accessible. response code: #{res.code}"
	end

	test '/projeto-popular is accessible' do
		res = @agent.get(uri('projeto-popular'))							
		assert res.code == '200',"/projeto-popular is not accessible. response code: #{res.code}"
	end

	test '/educacao-cultura-e-comunicacao is accessible' do
		res = @agent.get(uri('educacao-cultura-e-comunicacao'))							
		assert res.code == '200',"/educacao-cultura-e-comunicacao is not accessible. response code: #{res.code}"
	end

end
