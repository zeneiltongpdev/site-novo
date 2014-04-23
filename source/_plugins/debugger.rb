require "pry"

module Jekyll
  module Debugger

    def debug(obj, stdout=false)
      binding.pry
    end

  end
end 

Liquid::Template.register_filter(Jekyll::Debugger)
