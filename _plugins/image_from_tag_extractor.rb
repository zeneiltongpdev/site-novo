
module Jekyll
  module ImageFromTagExtractor

    def extract_image_from_post_tag(site, post, stdout=false)
      post_tag = post["tags"].first.split(':').last
      site["pages"].find{ |page| page["tag"] == post_tag }["image"]
    end

  end
end 

Liquid::Template.register_filter(Jekyll::ImageFromTagExtractor)