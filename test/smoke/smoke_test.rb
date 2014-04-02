require_relative '../test_helper.rb'
require 'net/http'

class ProcessPostTest < ActiveSupport::TestCase

  test 'site is running' do
    url = URI.encode(ENV['url_app'] || 'http://localhost:4000')
    res = Net::HTTP.get_response(URI.parse(url))
    assert res.code == '200'
  end

end
