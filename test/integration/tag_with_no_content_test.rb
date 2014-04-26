require_relative '../test_helper.rb'

class TagWithNoContentTest < ActiveSupport::TestCase
  include IntegrationTestHelper

  setup do
    build_site(Tag.new('esporte'))
    @agent = Mechanize.new
  end

  test 'news section is not present' do
    page = @agent.get(uri('esporte'))
    section = page.search('section.news')
    assert section.empty?, 'news section is present.'
  end

  test 'videos section is not present' do
    page = @agent.get(uri('esporte'))
    section = page.search('section.videos')
    assert section.empty?, 'videos section is present.'
  end

end
