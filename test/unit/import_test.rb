require_relative '../test_helper.rb'
require_relative '../../lib/import.rb'
 
class ProcessPostTest < ActiveSupport::TestCase

  setup do
    @post = { :nid => 'node_id',
              :title => 'title',
              :body => 'body',
              :type => 'type',
              :created => 'created',
              :status => 'status'}
    @process = ProcessPost.new @post
  end


  test 'post size' do
    processPost = @process.prepare_post @post
    assert_equal processPost.size, @post.size
  end

  test 'post is published' do
    @post[:status] = 0 
    processPost = @process.prepare_post @post

    assert processPost.is_published? == false

    @post[:status] = 1
    processPost = @process.prepare_post @post

    assert processPost.is_published?
  end

  test 'post title' do
    @post[:title] = 'Testin"g q"uotes'

    processPost = @process.prepare_post @post

    assert_equal 'Testing quotes', processPost.title
  end

  test 'content vars size' do
    content_vars = @process.content_vars
    assert_equal content_vars.size, 4
  end

  test 'content vars tags' do
    @process.stubs(:post_tags).returns('resultado')

    assert_equal  'resultado', @process.content_vars.tags
  end

  test 'content vars images' do
    @process.stubs(:post_images).returns('A')
    @process.stubs(:content_images).returns('B')

    assert_equal 'AB', @process.content_vars.images
  end

  test 'content vars video when post type video' do
    @post[:type] = 'video'
    @process = ProcessPost.new @post
    assert_equal 'youtube.com/123', @process.content_vars.video
  end

  test 'content vars video when post type is not video' do
    @post[:type] = 'other'
    @process = ProcessPost.new @post

    assert_equal '', @process.content_vars.video
  end

  test 'content vars name without special caracters' do
    @post[:title] = 'MY STRANGE Title.'
    @post[:created] = '1262314800'

    @process = ProcessPost.new @post

    assert_equal '2010-12-30-my-strange-title.md', @process.content_vars.name
  end

end
