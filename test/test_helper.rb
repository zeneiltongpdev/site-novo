require 'minitest/autorun'
require 'minitest/pride'
require 'active_support/test_case'
require 'pry'
require 'mocha/mini_test'
require 'erubis'
require 'mechanize'

DIR = File.expand_path(File.dirname(__FILE__))
BASE_URL = 'http://0.0.0.0:4000'

def uri(resource)
  "#{BASE_URL}/#{resource}"
end

module IntegrationTestHelper
  require 'fakeweb'

  TEMPLATES = {
    :tag => File.join(DIR, 'fixtures', 'tag.html.erb'),
    :video => File.join(DIR, 'fixtures', 'video.md.erb'),
    :noticia => File.join(DIR, 'fixtures', 'noticia.md.erb')
  }

  def build_site(*tags)
    tags.each{ |tag| tag.compile }
    (`bundle exec jekyll build`)
    tags.each{ |tag| stub_requests(tag); tag.clear }
  end

  def stub_requests(tag)
    FakeWeb.register_uri(:get, uri(tag.name), 
      :body => File.read("_site/#{tag.path}"), 
      :content_type => 'text/html')
  end

  class Tag
    attr_accessor :name, :path

    def initialize(name)
      @name = name
      @path = "#{@name}/index.html"
      @posts = []
    end

    def add(post)
      @posts << post 
    end

    def compile
      FileUtils.mkdir_p(@name)
      template = File.read(TEMPLATES[:tag])
      result = Erubis::Eruby.new(template).result(:tag_name => @name)
      File.open(@path, 'w'){ |f| f.write(result) }
      @posts.each{ |post| post.compile }
    end

    def clear
      FileUtils.remove(@path)
      FileUtils.remove_dir(@name)
      @posts.each{ |post| post.clear }
    end
  end

  class Post
    def initialize(type, tag)
      @type = type
      @tag = tag
      @path = "_posts/2014-04-17-#{@tag.name}-#{@type.to_s}-#{Time.now.to_f}.md"
    end

    def compile
      template = File.read(TEMPLATES[@type])
      result = Erubis::Eruby.new(template).result(:tag_name => @tag.name)
      File.open(@path, 'w'){ |f| f.write(result) }
    end

    def clear
      FileUtils.remove(@path)
    end
  end
end

