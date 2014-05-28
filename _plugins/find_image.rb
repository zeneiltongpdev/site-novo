module Jekyll
  module FindImage
    def find_image(post, size, stdout=false)
      key = size == 'hd' ? 'images_hd' : 'images'
      (post[key].nil? || post[key].empty?) ? get_image_from(post['content']) : post[key]
    end

    private

    def get_image_from body
      match = body.to_s.match(/\<img[^\>]*src=[\"\'](?<src>[^\"\']+)/)
      match && Array(match.captures).flatten.first
    end
  end
end 

Liquid::Template.register_filter(Jekyll::FindImage)
