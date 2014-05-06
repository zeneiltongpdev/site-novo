require_relative '../test_helper.rb'
require 'jekyll'
require_relative '../../_plugins/image_from_tag_extractor.rb'

class ImageFromTagExtractorTest < ActiveSupport::TestCase
  include Jekyll::ImageFromTagExtractor

  setup do
    @site = {
      'pages' => [{
      	'tag' => 'agricultura camponesa',
      	'image' => 'image.jpg'
      }]
    }
  end

  test '#extract_image_from_post_tag gets image from based on menu tag' do
    post = {
      'tags' => [
        'assuntos:produção',
        'destaque:destaque',
        'menu:agricultura camponesa'
      ]
    }
    assert extract_image_from_post_tag(@site, post) == 'image.jpg'
  end
  
  test '#extract_image_from_post_tag returns empty when tag page is not found' do
    post = {
      'tags' => [
        'assuntos:produção',
        'destaque:destaque',
        'menu:direitos humanos'
      ]
    }
    assert extract_image_from_post_tag(@site, post) == ''
  end

end
