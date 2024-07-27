require 'rails_helper'

RSpec.describe GeolocationService do
  let(:ip_address) { '1.1.1.1' }
  let(:service_provider_class) { IpstackService }
  let(:geolocation_service) { described_class.new(ip_address, service_provider_class) }

  describe '#call' do
    context 'when geolocation data is successfully fetched' do
      let(:geolocation_data) do
        {
          ip_address:,
          continent_code: 'NA',
          continent_name: 'North America',
          country_code: 'US',
          country_name: 'United States',
          region_code: 'CA',
          region_name: 'California',
          city: 'Mountain View',
          zip: '94043',
          latitude: 37.386,
          longitude: -122.0838,
          type: 'ipv4'
        }
      end

      before do
        allow_any_instance_of(service_provider_class).to receive(:fetch_geolocation_data).and_return(geolocation_data)
      end

      it 'returns the geolocation data' do
        expect(geolocation_service.call).to eq(geolocation_data)
      end
    end
  end
end
