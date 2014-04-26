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

  test 'news section displays 3 headlines' do
    page = @agent.get(uri('esporte'))
    news = page.search('section.news ul > li > .headline') 
    assert news.count == 3, 'news section does not have 3 headlines'
  end

  test 'videos section displays 3 headlines' do
    page = @agent.get(uri('esporte'))
    videos = page.search('section.videos ul > li > .headline') 
    assert videos.count == 3, 'videos section does not have 3 headlines'
  end

end

