require 'logger'
require 'nokogiri'
require 'open-uri'

module Sldn
  class Slide
    attr_reader :name, :page_urls, :count

    def logger
      @logger ||= Logger.new(STDOUT)
    end

    def initialize(slide_url)
      logger.info("Open Url: #{slide_url}")
      html = Nokogiri::HTML.parse(open(slide_url))

      xml_url = extract_xml_url(html)
      @name = extract_name(xml_url)
      @count = Nokogiri::XML.parse(open(xml_url)).xpath('/Show/Slide').count

      raise 'slide pages not exists' if count.zero?

      @page_urls = (1..count).map { |i| "http://image.slidesharecdn.com/#{name}/95/slide-#{i}-1024.jpg" }
    end

    def pages
      @pages ||= page_urls.map { |url|
        logger.info("Download Image: #{url}")
        begin
          open(url)
        rescue OpenURI::HTTPError
          logger.warn("Download Error: #{url}")
          nil
        end
      }.compact
    end

    private

    def extract_xml_url(html)
      thumbnail_url = html.xpath('/html/head/meta[@name="thumbnail"]').first.attributes['content'].value
      thumbnail_url.gsub(%r{(^.+/)ss_thumbnails/(.+)-thumbnail.jpg\?(.+$)}, '\1\2.xml')
    end

    def extract_name(xml_url)
      xml_url.match(%r{.+cdn\.slidesharecdn\.com/(.+)\.xml}).captures.first
    end
  end
end
