require 'net/http'

describe do
  HTTP_CODE_OK = '200'

  it "see with the website is on" do
    url = URI.encode(ENV['url_app'] || 'http://localhost:4000/site-novo/')
    res = Net::HTTP.get_response(URI.parse(url))

    res.code.should eql HTTP_CODE_OK
  end
end
