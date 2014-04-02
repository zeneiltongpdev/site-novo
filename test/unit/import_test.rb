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
    assert_equal 6,processmetadata.size
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
    assert_equal 4,content_vars.size
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

  test 'content vars video when metadata type video' do
    @metadata[:type] = 'video'
    @process = ProcessPost.new @metadata
    assert_equal 'youtube.com/123', @process.content_vars.video
  end

  test 'content vars video when metadata type is not video' do
    @metadata[:type] = 'other'
    @process = ProcessPost.new @metadata

    assert_equal '', @process.content_vars.video
  end

  test 'content vars name without special caracters' do
    @metadata[:title] = 'MY STRANGE Title'
    @metadata[:created] = DateTime.new(2012,12,30,12,30).to_time.to_i

    @process = ProcessPost.new @metadata

    assert_equal '2012-12-30-my-strange-title.md', @process.content_vars.name
  end

  test 'metadata tags method' do
    @metadata[:tags] = "Audio:FM|Video:Vimeo|Music:BYOB"
    result = {'Audio' => 'FM', 'Video' => 'Vimeo', 'Music' => 'BYOB'}

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
    assert_equal "2010-12-30-congresso-do-mst.md", process.post_name
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
end
