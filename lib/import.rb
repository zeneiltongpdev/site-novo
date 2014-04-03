# encoding: utf-8
require "mysql"
require "jekyll-import"
require "open-uri"
require_relative "html2markdown_monkeypatch"
require "yaml"

# monkey patching the drupal 6 importer
# adding more metadatas ( tags and images ) do each post
module JekyllImport
  module Importers
    class Drupal6 < Importer
      REFRESH_HTML = "\
        <!DOCTYPE html> \
          <html> \
            <head> \
            <meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\" /> \
            <meta http-equiv=\"refresh\" content=\"0;url={{ page.refresh_to_post_id }}.html\" /> \
          </head>
        </html>"
      
      def self.require_deps
        JekyllImport.require_with_fallback(%w[
          rubygems
          sequel
          fileutils
          safe_yaml
        ])
      end

      def self.load_query_file
        YAML.load_file(File.dirname(__FILE__) + "/queries.yml")
      end

      def self.markdonify(content)
        content = content.force_encoding("UTF-8")
        content.gsub!(/\*/, '\\*')
        content.gsub!(/\#/, '\\#')
        content.gsub!(/[`´]/, '"')

        page = HTMLPage.new(:contents => content)
        page.markdown.force_encoding("UTF-8")
      end

      def self.configure_dirs 
        FileUtils.remove_dir "_posts"        
        
        FileUtils.mkdir_p "_posts"
        FileUtils.mkdir_p "_drafts"
        FileUtils.mkdir_p "_layouts"

        # Create the refresh layout
        # Change the refresh url if you customized your permalink config
        File.open("_layouts/refresh.html", "w") do |f|
          f.puts REFRESH_HTML
        end
      end

      def self.prepare_database(options)
        dbname = options.fetch('dbname')
        user   = options.fetch('user')
        pass   = options.fetch('password', "")
        host   = options.fetch('host', "localhost")

        Sequel.mysql(dbname, :user => user, :password => pass, :host => host, :encoding => 'utf8')
      end

      def self.prepare_sql(options)
        prefix = options.fetch('prefix', "")
        queries = load_query_file
        sql = queries['retrieve_news_and_videos_from_tags'].gsub('#ids#', '336, 382, 347')
        
        if prefix != ''
          sql[" node "] = " " + prefix + "node "
          sql[" node_revisions "] = " " + prefix + "node_revisions "
          sql[" term_node "] = " " + prefix + "term_node "
          sql[" term_data "] = " " + prefix + "term_data "
          sql[" vocabulary "] = " " + prefix + "vocabulary "
          sql[" content_type_story "] = " " + prefix + "content_type_story "
        end
        sql
      end

      def self.create_file_to_redirect_old_drupal(post, db, options)
        prefix = options.fetch('prefix', "")

        aliases = db["SELECT CONCAT('_pages/',dst) as dst FROM #{prefix}url_alias WHERE src = ?", "node/#{post.node_id}"].all

        aliases.push(:dst => "_pages/node/#{post.node_id}")

        aliases.each do |url_alias|
          FileUtils.mkdir_p url_alias[:dst]
          File.open("#{url_alias[:dst]}/index.md", "w") do |f|
            f.puts "---"
            f.puts "layout: refresh"
            f.puts "refresh_to_post_id: #{post.url}"
            f.puts "---"
          end
        end
      end

      def self.process(options)
        configure_dirs
        db = prepare_database(options)
        sql = prepare_sql(options)

        db[sql].each do |raw|

          content_markdown = markdonify(raw[:body])
          post_process = ProcessPost.new(raw)
          post = post_process.post
          content_vars = post_process.content_vars

          # Get the relevant fields as a hash, delete empty fields and convert
          # to YAML for the header
          data = {
            'layout' => 'post',
            'title' => post.title,
            'legacy_url' => "http://www.mst.org.br/node/#{post.node_id}",
            'created' => post.created,
            'images' => content_vars.images,
            'video' => content_vars.video,
            'tags' => content_vars.tags.values
          }.each_pair {
            |k,v| ((v.is_a? String) ? v.force_encoding("UTF-8") : v)
          }

          puts "importing: #{post.title}"

          # Write out the data and content to file
          File.open("_posts/#{post.name}", "w") do |f|
            f.puts data.merge(content_vars.tags).to_yaml()
            f.puts "---"
            f.puts content_markdown
          end

          # Make a file to redirect from the old Drupal URL
          create_file_to_redirect_old_drupal(post, db, options) if post.is_published?
        end
      end
    end
  end
end


class ProcessPost
  attr_reader :post, :content_vars
  
  Struct.new("Post", :node_id, :title, :content, :type, :created, :is_published?, :name, :url)
  Struct.new("Vars", :tags, :images, :video)

  PUBLISHED = 1
  ADDRESS_IMAGES = 'http://www.mst.org.br/sites/default/files/imagecache/foto_destaque/' #don't forget slash in the end

  def initialize raw_content
    prepare_post raw_content
    prepare_content_vars raw_content
  end

  def prepare_post raw_content
    @post = Struct::Post.new(
      raw_content[:nid],
      raw_content[:title].gsub(/"/, ''),
      raw_content[:body],
      raw_content[:type],
      raw_content[:created],
      (raw_content[:status] == PUBLISHED),
      post_name(raw_content),
      post_url(raw_content)
    )
  end

  def prepare_content_vars raw_content
    @content_vars = Struct::Vars.new(
      post_tags(raw_content),
      post_images(raw_content),
      youtube_video(raw_content)
    )
  end

  def post_tags raw_content
    return "" if raw_content[:tags].empty?
    tags = raw_content[:tags].split('|').reduce({}) do |result, pair|
      result.merge(Hash[*pair.force_encoding("UTF-8").split(':')]) 
    end
    tags['Type'] = raw_content[:type]
    tags
  end
  
  def post_images raw_content
    return "" if raw_content[:images].nil? or raw_content[:images].empty? 
    ADDRESS_IMAGES + raw_content[:images]
  end

  def post_name raw_content
    time = Time.at(raw_content[:created].to_i).strftime "%Y-%m-%d"
    title = format_title raw_content[:title]
     "#{time}-#{title}.md"
  end

  def post_url raw_content
    time = Time.at(raw_content[:created].to_i).strftime "%Y/%m/%d"
    title = format_title raw_content[:title]
     "/mst/#{time}/#{title}"
  end

  def format_title title
    title.downcase.split.join("-").
      gsub(/(&amp;|&)/, 'and').  
      gsub(/[^\w-]/, '').
      gsub(/[-_]{1,}/, '-').
      gsub(/^[-_]/, '').
      gsub(/[-_]$/, '')
  end

  def youtube_video raw_content
    return "" unless @post[:type] == 'video'
    body = raw_content[:body]
    regex = /^.*(youtube\/|v\/|e\/|u\/\w+\/|embed\/|v=)(?<id>[^#\&\?\"]*).*("|')/
    match =  body.match(regex)
    (match) ? match[:id].to_s : ""
  end

end
