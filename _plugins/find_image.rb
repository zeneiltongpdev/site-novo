require "pry"

module Jekyll
  module FindImage

    def find_image(post, size, stdout=false)
      key = "images"
      if size == "hd"
        key = "images_hd"
      end
      (post[key].empty?) ? get_image_from(post['content']) : post[key]
    end

    private

    def get_image_from body
      match = body.to_s.match(/\<img[^\>]*src=[\"\'](?<src>[^\"\']+)/)
      Array(match.captures).flatten.first
    end
  end
end 

Liquid::Template.register_filter(Jekyll::FindImage)
