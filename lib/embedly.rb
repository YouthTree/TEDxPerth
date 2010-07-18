require 'net/http'
require 'uri'

class Embedly
  USER_AGENT   = "Mozilla/5.0 (compatible; TEDxPerth/0,1; +http://tedxperth.org/)"
  API_BASE_URL = "http://api.embed.ly/v1/api/oembed"

  attr_accessor :raw_body, :response

  def initialize(url, options = {})
    @loaded  = false
    @url     = url
    @options = options
  end
  
  def self.from_json(url, json)
    new(url).tap { |r| r.raw_body = json }
  end
  
  def to_hash
    load! if !@loaded
    @response.symbolize_keys
  end
  
  def to_json
    load! if !@loaded
    @raw_body
  end
  
  def load!
    url = self.to_api_url
    http = Net::HTTP.new(url.host, url.port)
    response, data = http.get(url.request_uri, {'User-Agent' => USER_AGENT})
    if response.is_a?(Net::HTTPSuccess)
      self.raw_body = response.response.body
    else
      self.raw_body = "{}"
    end
  end
  
  def raw_body=(value)
    @raw_body = value
    @response = ActiveSupport::JSON.decode(value)
    @loaded = true
  end
  
  def [](key)
    load! if !@loaded
    @response[key.to_s]
  end
  
  def self.[](url, options = {})
    new(url, options).tap { |i| i.load! }
  end
  
  def url_params
    params = {'url' => @url}
    params.merge('maxwidth'  => @options[:max_width]) if @options[:max_width]
    params.merge('maxheight' => @options[:max_height]) if @options[:max_height]
    params.merge('format'    => @options[:format])     if @options[:format]
    params_full = []
    params.each_pair do |k, v|
      params_full << "#{k}=#{URI.escape(v.to_s)}"
    end
    params_full.join("&")
  end
  
  def to_api_url
    u = URI.parse(API_BASE_URL)
    u.query = url_params
    u
  end
  
end