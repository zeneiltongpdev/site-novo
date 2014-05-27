require "pry"

module Jekyll
  module Between

    def between(obj, from, to, stdout=false)
      Array(obj).flatten[from..to]
    end

  end
end 

Liquid::Template.register_filter(Jekyll::Between)
