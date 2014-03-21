require 'minitest/autorun'
require 'net/http'

class SmokeTesti < Minitest::Unit::TestCase

  def test_ok
    url = URI.encode(ENV['url_app'])
    res = Net::HTTP.get_response(URI.parse(url))
    assert_equal '200', res.code, 'The website is offline'
  end

end
