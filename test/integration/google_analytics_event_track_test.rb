require_relative '../test_helper.rb'

class GoogleAnalyticsEventTrackTest < ActiveSupport::TestCase
  include IntegrationTestHelper

	setup do
    tag = Tag.new('esporte')
    tag.add(Post.new(:news, tag))
    tag.add(Post.new(:video, tag))
    build_site(tag)
    @agent = Mechanize.new
	end

	test 'Parceiros links should be accessible through the Selector defined for Google Analytics event track' do
    page = @agent.get(uri('esporte'))
		links = page.search('.parceiros ul li a')
		assert links.count > 0, 'Parceiros links are not accessible. This will break Google Analytics event track!'
	end

	test 'Social links should be accessible through the Selector defined for Google Analytics event track' do
    page = @agent.get(uri('esporte'))
		links = page.search('.social ul li a')
		assert links.count > 0, 'Social links are not accessible. This will break Google Analytics event track!'
	end

	test 'Amigos links should be accessible through the Selector defined for Google Analytics event track' do
    page = @agent.get(uri('esporte'))
		links = page.search('.amigos ul li a')
		assert links.count > 0, 'Amigos links are not accessible. This will break Google Analytics event track!'
	end

	test 'Links links should be accessible through the Selector defined for Google Analytics event track' do
    page = @agent.get(uri('esporte'))
		links = page.search('.links ul li a')
		assert links.count > 0, 'Links links are not accessible. This will break Google Analytics event track!'
	end

	test 'Mais Noticias link should be accessible through the Selector defined for Google Analytics event track' do
    page = @agent.get(uri('esporte'))
		links = page.search('.news .more a')
		assert links.count > 0, 'Mais Noticias link is not accessible. This will break Google Analytics event track!'
	end

	test 'Mais Videos link should be accessible through the Selector defined for Google Analytics event track' do
    page = @agent.get(uri('esporte'))
		links = page.search('.videos .more a')
		assert links.count > 0, 'Mais Videos link is not accessible. This will break Google Analytics event track!'
	end

	test 'Header links should be accessible through the Selector defined for Google Analytics event track' do
    page = @agent.get(uri('esporte'))
		links = page.search('nav ul li a')
		assert links.count > 0, 'Header links are not accessible. This will break Google Analytics event track!'
	end

	test 'Leia Mais link should be accessible through the Selector defined for Google Analytics event track' do
    page = @agent.get(uri('esporte'))
		links = page.search('details summary')
		assert links.count > 0, 'Leia mais link is not accessible. This will break Google Analytics event track!'
	end

	test 'Logotipo link should be accessible through the Selector defined for Google Analytics event track' do
    page = @agent.get(uri('esporte'))
		links = page.search('header > a')
		assert links.count > 0, 'Logotipo link is not accessible. This will break Google Analytics event track!'
	end

end
