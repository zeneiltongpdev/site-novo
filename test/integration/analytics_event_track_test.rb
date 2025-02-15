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

	test 'link to mais videos is accessible through the selector defined for analytics event track' do
    page = @agent.get(uri('esporte'))
		links = page.search('.videos .more a')
		assert links.count > 0, 'link to mais videos is not accessible.'
	end

	test 'nav links are accessible through the selector defined for analytics event track' do
    page = @agent.get(uri('esporte'))
		links = page.search('nav ul li a')
		assert links.count > 0, 'nav links are not accessible.'
	end

	test 'link to leia mais is accessible through the selector defined for analytics event track' do
    page = @agent.get(uri('esporte'))
		links = page.search('details summary')
		assert links.count > 0, 'link to leia mais is not accessible.'
	end

	test 'logo link is accessible through the selector defined for analytics event track' do
    page = @agent.get(uri('esporte'))
		links = page.search('header > a')
		assert links.count > 0, 'logo link is not accessible.'
	end

end
