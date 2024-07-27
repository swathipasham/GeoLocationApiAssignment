require 'rails_helper'

RSpec.describe IpstackService, type: :service do
  let(:ip_address) { '8.8.8.8' }
  let(:service) { IpstackService.new(ip_address) }

  describe '#fetch_geolocation_data' do
    context 'when an invalid API key is provided' do
      let(:service) { IpstackService.new(ip_address) }

      before do
        allow(HTTParty).to receive(:get).and_return(
          { 'error' => { 'info' => 'Invalid API key',
                         'code' => 401 } }, success: false
        )
      end

      it 'returns an invalid API key error' do
        result = service.fetch_geolocation_data
        expect(result).to eq({ error: 'Invalid API key', code: 401 })
      end
    end
    context 'when the API response is successful' do
      let(:response_data) do
        {
          'ip' => '8.8.8.8',
          'continent_code' => 'NA',
          'continent_name' => 'North America',
          'country_code' => 'US',
          'country_name' => 'United States',
          'region_code' => 'CA',
          'region_name' => 'California',
          'city' => 'Mountain View',
          'zip' => '94043',
          'latitude' => 37.386,
          'longitude' => -122.0838,
          'type' => 'ipv4'
        }
      end

      before do
        allow(HTTParty).to receive(:get).and_return(OpenStruct.new(parsed_response: response_data, success: true))
      end

      it 'returns geolocation data' do
        result = service.fetch_geolocation_data
        expected_result = {
          ip_address: '8.8.8.8',
          continent_code: 'NA',
          continent_name: 'North America',
          country_code: 'US',
          country: 'United States',
          region_code: 'CA',
          region: 'California',
          city: 'Mountain View',
          zip: '94043',
          latitude: 37.386,
          longitude: -122.0838,
          ip_address_type: 'ipv4'
        }
        expect(result).to eq(expected_result)
      end
    end

    context 'when the API returns  error message and code ' do
      let(:service) { IpstackService.new('203.0.113.1') }

      it 'returns an error for nonexistent resource' do
        allow(HTTParty).to receive(:get).and_return({ 'error' => { 'info' => 'The requested resource does not exist.',
                                                                   'code' => 404 } }, success: false)
        result = service.fetch_geolocation_data
        expect(result).to eq({ error: 'The requested resource does not exist.', code: 404 })
      end

      it 'returns an error when limit reached' do
        allow(HTTParty).to receive(:get).and_return({ 'error' => { 'info' => 'The maximum allowed amount of monthly API
         requests has been reached.', 'code' => 104 } }, success: false)

        result = service.fetch_geolocation_data
        expect(result).to eq({ error: 'The maximum allowed amount of monthly API
         requests has been reached.', code: 104 })
      end
    end

    context 'when HTTParty raises an error' do
      before do
        allow(HTTParty).to receive(:get).and_raise(HTTParty::Error.new('Connection error'))
      end

      it 'returns an HTTParty error message' do
        result = service.fetch_geolocation_data
        expect(result).to eq({ error: 'HTTParty error: Connection error', code: 500 })
      end
    end
  end
end
