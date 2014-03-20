require 'minitest/autorun'
require 'net/http'

class SmokeTesti < Minitest::Unit::TestCase
  HTTP_OK = "200"

  def test_ok
    url = ENV['url_app']
    res = Net::HTTP.get_response(URI(url))
    assert_equal res.code, HTTP_OK, "The website is offline"
  end
end
