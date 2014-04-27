require_relative '../test_helper.rb'

class AnalyticsEventTrackTest < ActiveSupport::TestCase
  include IntegrationTestHelper

	setup do
    tag = Tag.new('esporte')
    tag.add(Post.new(:news, tag))
    tag.add(Post.new(:video, tag))
    build_site(tag)
    @agent = Mechanize.new
	end

	test 'links to parceiros are accessible through the selector defined for analytics event track' do
    page = @agent.get(uri('esporte'))
		links = page.search('.parceiros ul li a')
		assert links.count > 0, 'links to parceiros are not accessible.'
	end

	test 'links to social are accessible through the selector defined for analytics event track' do
    page = @agent.get(uri('esporte'))
		links = page.search('.social ul li a')
		assert links.count > 0, 'links to social are not accessible.'
	end

	test 'links to amigos are accessible through the selector defined for analytics event track' do
    page = @agent.get(uri('esporte'))
		links = page.search('.amigos ul li a')
		assert links.count > 0, 'links to amigos are not accessible.'
	end

	test 'interesting links are accessible through the selector defined for analytics event track' do
    page = @agent.get(uri('esporte'))
		links = page.search('.links ul li a')
		assert links.count > 0, 'interesting links are not accessible.'
	end

	test 'link to mais noticias is accessible through the selector defined for analytics event track' do
    page = @agent.get(uri('esporte'))
		links = page.search('.news .more a')
		assert links.count > 0, 'link to mais noticias is not accessible.'
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
