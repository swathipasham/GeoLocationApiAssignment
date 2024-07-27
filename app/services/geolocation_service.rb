# Service to get geolocation data from an IP address or url
class GeolocationService
  # Initialize the service with an IP address and a service provider class
  # @param ip_address [String] the IP address to fetch geolocation data
  # @param service_provider_class [Class] the service provider class to fetch geolocation data
  def initialize(ip_address, service_provider_class)
    @ip_address = ip_address
    @service_provider = service_provider_class.new(ip_address)
  end

  # Fetch geolocation data from the service provider
  def call
    @service_provider.fetch_geolocation_data
  end
end
