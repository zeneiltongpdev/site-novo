require_relative '../test_helper.rb'

class TagWithSomeContentTest < ActiveSupport::TestCase
  include IntegrationTestHelper

  setup do
    tag = Tag.new('esporte')
    4.times{ tag.add(Post.new(:news, tag)) }
    4.times{ tag.add(Post.new(:video, tag)) }
    build_site(tag)
    @agent = Mechanize.new
  end

  test 'noticias section displays 3 noticias' do
    page = @agent.get(uri('esporte'))
    noticias = page.search('section.noticias ul > li > .destaque') 
    assert noticias.count == 3, 'noticias section does not have 3 noticias'
  end

  test 'videos section displays 3 videos' do
    page = @agent.get(uri('esporte'))
    videos = page.search('section.videos ul > li > .destaque') 
    assert videos.count == 3, 'videos section does not have 3 videos'
  end

end

