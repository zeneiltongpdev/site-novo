# encoding: utf-8
require "html2markdown"

# monkey patching the HTML2Markdown::Converter
# I found that the original converter algorithm doesn't work like expected
# for italic block
module HTML2Markdown
  module Converter
    # wrap node with markdown
    def wrap_node(node,contents=nil)
      result = ''
      contents.strip! unless contents==nil
      # check if there is a custom parse exist
      if respond_to? "parse_#{node.name}"
        return self.send("parse_#{node.name}",node,contents)
      end
      # skip hidden node
      return '' if node['style'] and node['style'] =~ /display:\s*none/

      case node.name.downcase
      when 'i'
        result << "*#{contents}*\n"
      when 'script', 'style', 'li'
        result << "*#{contents}\n"
      when 'blockquote'
        contents.split('\n').each do |part|
          result << ">#{contents}\n"
        end
      when 'strong'
        result << "**#{contents}**\n"
      when 'h1'
        result << "##{contents}\n"
      when 'h2'
        result << "###{contents}\n"
      when 'h3'
        result << "####{contents}\n"
      when 'hr'
        result << "****\n"
      when 'br'
        result << "\n"
      when 'img'
        result << "![#{node['alt']}](#{node['src']})"
      when 'a'
        result << "[#{contents}](#{node['href']})"
      else
        blacklist = []
        blacklist << "[if gte mso 9]"
        blacklist << "<xml>"
        blacklist << "<mce:style>"
        blacklist << "[endif]"
        contents ||= ""

        result << "\n"
        result << contents unless blacklist.any?{|not_allowed| contents.include?(not_allowed) }
      end
      result
    end
  end
end
