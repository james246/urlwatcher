require 'nokogiri'
require 'uri'
require 'net/http'

class Page
  attr_accessor :url, :document

  def initialize(url)
    self.url = url
  end

  def uri
    @uri ||= URI.parse(self.url)
  end

  def get_html
    response  = Net::HTTP.get_response(uri)
    response.body
  end

  def document
    @document = Nokogiri::HTML(get_html)
  end
end