require 'minitest/autorun'
require 'net/http'

class SmokeTest < Minitest::Unit::TestCase

  def test_ok
    url = URI.encode(ENV['url_app'] || 'http://localhost:4000/site-novo/')
    res = Net::HTTP.get_response(URI.parse(url))
    assert_equal '200', res.code, 'The website is offline'
  end

end
