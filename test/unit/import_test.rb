require_relative "../../lib/import.rb"
require "test/unit"
require 'mocha/test_unit'
require "pry"
 
class ProcessPostTest < Test::Unit::TestCase

  def setup
    @post = { :nid => "node_id",
              :title => "title",
              :body => "body",
              :type => "type",
              :created => "created",
              :status => "status"}
  end


  def test_struct_size
    processPost = ProcessPost.new(@post)
    assert_equal processPost.struct_post.size, @post.size
  end

  def test_struct_is_published
    @post[:status] = 0 
    processPost = ProcessPost.new(@post)

    assert processPost.struct_post.is_published? == false

  end
end
