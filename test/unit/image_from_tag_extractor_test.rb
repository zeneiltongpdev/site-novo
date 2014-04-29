require_relative '../test_helper.rb'
require 'jekyll'
require_relative '../../_plugins/image_from_tag_extractor.rb'

class ImageFromTagExtractorTest < ActiveSupport::TestCase
  
  include Jekyll::ImageFromTagExtractor

  test 'gets image from post tag' do

  	IMAGE_URL = "mst.org.br/agronegocio.jpg"

    site = {
      'pages' => [{
      	'tag' => 'agronegocio',
      	'image' => IMAGE_URL
      }]
    }
    
    post = {
     'tags' => ['menu:agronegocio', 'assunto:mst'] 
    }
    
    image_url = extract_image_from_post_tag(site, post)
    assert image_url == IMAGE_URL
  end
end