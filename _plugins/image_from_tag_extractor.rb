
module Jekyll
  module ImageFromTagExtractor

    def extract_image_from_post_tag(site, post, stdout=false)
      menu_tag = post["tags"].find{ |tag| tag.split(':').first == 'menu' }
      post_tag = menu_tag.split(':').last
      site["pages"].find{ |page| page["tag"] == post_tag }["image"]
    end

  end
end 

Liquid::Template.register_filter(Jekyll::ImageFromTagExtractor)