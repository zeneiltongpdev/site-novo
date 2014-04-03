require_relative '../test_helper.rb'
require_relative '../../lib/import.rb'
require 'date'
 
class ProcessPostTest < ActiveSupport::TestCase

  setup do
    @metadata = { :nid => 'node_id',
              :title => 'title',
              :body => 'body',
              :type => 'type',
              :created => 1262314800,
              :status => 'status',
              :tags => "tags:tags",
              :images => "vini.jpg"}
    @process = ProcessPost.new @metadata
  end

  test 'post size' do
    processmetadata = @process.prepare_post @metadata
    assert_equal 8,processmetadata.size
  end

  test 'url to post in jekyll' do
    expected = '/mst/2010/12/30/movimento-mst'

    @metadata[:title] = 'Movimento MST'
    @metadata[:created] = DateTime.new(2010,12,30,12,30).to_time.to_i

    @process = ProcessPost.new @metadata

    assert_equal expected, @process.post.url
  end

  test 'metadata is published' do
    @metadata[:status] = 0 
    processmetadata = @process.prepare_post @metadata

    assert processmetadata.is_published? == false

    @metadata[:status] = 1
    processmetadata = @process.prepare_post @metadata

    assert processmetadata.is_published?
  end

  test 'metadata title' do
    @metadata[:title] = 'Testin"g q"uotes'

    post = @process.prepare_post @metadata

    assert_equal 'Testing quotes', post.title
  end

  test 'content vars size' do
    content_vars = @process.content_vars
    assert_equal 3,content_vars.size
  end

  test 'content vars tags' do
    process = ProcessPost.new @metadata
    process.stubs(:post_tags).with(@metadata).returns('resultado')
    process.prepare_content_vars @metadata

    assert_equal  'resultado', process.content_vars.tags
  end

  test 'content vars images' do
    process = ProcessPost.new @metadata
    process.stubs(:post_images).returns('AB')
    process.prepare_content_vars @metadata

    assert_equal 'AB', process.content_vars.images
  end

  test 'post images when images from raw content is nil' do
    @metadata[:images] = nil
    process = ProcessPost.new @metadata

    assert_equal "", process.post_images(@metadata)
  end

  test 'content vars video when metadata type is not video' do
    @metadata[:type] = 'other'
    @process = ProcessPost.new @metadata

    assert_equal '', @process.content_vars.video
  end

  test 'post name without special caracters' do
    @metadata[:title] = 'MY STRANGE Title'
    @metadata[:created] = DateTime.new(2012,12,30,12,30).to_time.to_i

    @process = ProcessPost.new @metadata

    assert_equal '2012-12-30-my-strange-title.md', @process.post.name
  end

  test 'post tags are lowercase' do
    @metadata[:tags] = "Audio:FM|Video:Vimeo|Music:BYOB"
    result = {'audio' => 'fm', 'video' => 'vimeo', 'music' => 'byob'}

    process = ProcessPost.new @metadata

    assert_equal result, process.post_tags(@metadata)
  end

  test 'post images method' do
    @metadata[:images] = "vini.jpg"
    result = "#{ProcessPost::ADDRESS_IMAGES}vini.jpg"

    process = ProcessPost.new @metadata

    assert_equal result, process.post_images(@metadata)
  end
  
  test 'post name method' do
    @metadata[:title] = 'Congresso do MST'
    @metadata[:created] = 1293712200
    process = ProcessPost.new @metadata
    assert_equal "2010-12-30-congresso-do-mst.md", process.post_name(@metadata)
  end

  test 'format title removing & and &amp;' do
    title = "One & Two & Three &amp; Four"
    expected = "one-and-two-and-three-and-four"

    assert_equal expected, @process.format_title(title)
  end

  test 'format title removing special characteres' do
    title = "One;Two:Three[Four]"
    expected = "onetwothreefour"

    assert_equal expected, @process.format_title(title)
  end

  test 'format title removing duplicates underlines and dashes' do
    title = "One__Two--Three---Four__--Five"
    expected = "one-two-three-four-five"

    assert_equal expected, @process.format_title(title)
  end

  test 'format title removing underlines in the begining of title' do
    title = "_One"
    expected = "one"

    assert_equal expected, @process.format_title(title)
  end

  test 'format title removing underlines in the end of title' do
    title = "One_"
    expected = "one"

    assert_equal expected, @process.format_title(title)
  end

  test 'youtube video retrieve correct video id when the type is video' do
    real_video = '<object data="http://www.youtube.com/v/9mw5Wg02yAA&amp;feature" />'
    @metadata[:body] = real_video
    expected = '9mw5Wg02yAA'
    @metadata[:type] = 'video'

    process = ProcessPost.new @metadata
    
    assert_equal expected, process.youtube_video(@metadata)
  end

  test 'youtube video retrieve correct video id when it finish with single quotes' do
    @metadata[:body] = '<object href=\'https://www.youtube.com/v/IUdasiiu\' />'
    expected = 'IUdasiiu'
    @metadata[:type] = 'video'

    process = ProcessPost.new @metadata
    
    assert_equal expected, process.youtube_video(@metadata)
  end
end
