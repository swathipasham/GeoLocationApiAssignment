require 'httparty'
# Service to get geolocation data from an IP address or url
class IpstackService
  include HTTParty
  BASE_URI = 'http://api.ipstack.com/'.freeze
  ACCESS_KEY = ENV['IPSTACK_ACCESS_API_KEY'].freeze

  # Initialize the service with an IP address
  # @param ip_address [String] the IP address to fetch geolocation data
  # @return [Hash] the geolocation data
  # @return [Hash] the error message
  def initialize(ip_address)
    @ip_address = ip_address
    @url = "#{BASE_URI}/#{@ip_address}?access_key=#{ACCESS_KEY}" # service provider url with access key
  end

  # Fetch geolocation data from the service provider
  def fetch_geolocation_data
    response = HTTParty.get(@url)
    return { error: response['error']['info'], code: response['error']['code'] } unless response['success']

    data(response.parsed_response)
  rescue HTTParty::Error => e
    { error: "HTTParty error: #{e.message}", code: 500 }
  end

  # Parse the response data
  def data(response)
    { ip_address: response['ip'],
      continent_code: response['continent_code'],
      continent_name: response['continent_name'],
      country_code: response['country_code'],
      country: response['country_name'],
      region_code: response['region_code'],
      region: response['region_name'],
      city: response['city'],
      zip: response['zip'],
      latitude: response['latitude'],
      longitude: response['longitude'],
      ip_address_type: response['type'] }
  end
end
