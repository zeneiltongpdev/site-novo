
module Jekyll
  module FormatDate

    MESES = {
      1 => "janeiro",
      2 => "fevereiro",
      3 => "março",
      4 => "abril",
      5 => "maio",
      6 => "junho",
      7 => "julho",
      8 => "agosto",
      9 => "setembro",
      10 => "outubro",
      11 => "novembro",
      12 => "dezembro"
    }

    def pretty_date(obj, stdout=false)
      "#{obj.day} de #{MESES[obj.month]} de #{obj.year}"
    end

  end
end

Liquid::Template.register_filter(Jekyll::FormatDate)
