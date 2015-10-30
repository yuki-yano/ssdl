require 'prawn'

module Ssdl
  class Generator
    def self.generate(slide, name: "#{slide.name}.pdf")
      Prawn::Document.generate(name, page_size: [1024,768], margin:0) do
        slide.pages.map do |page|
          image(page, fit: [1024, 768])
          start_new_page
        end
      end
    end
  end
end
