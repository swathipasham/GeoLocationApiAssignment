require 'rails_helper'

RSpec.describe 'Api::V1::Geolocations', type: :request do
  let(:headers) { { 'Authorization' => "Bearer #{ENV['API_TOKEN']}", 'Content-Type' => 'application/json' } }

  describe 'POST #create' do
    context 'with invalid token' do
      it 'returns an error' do
        post api_v1_geolocations_path, params: { ip_address: '8.8.8.8' }.to_json,
                                       headers: { 'Authorization' => 'Bearer cc', 'Content-Type' => 'application/json' }
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq('Unauthorized')
      end
    end

    context 'with IP address' do
      it 'creates a new geolocation with valid IP address' do
        allow(GeolocationService).to receive(:new).and_return(instance_double(GeolocationService,
                                                                              call: geolocation_data))
        post(api_v1_geolocations_path, params: { ip_address: '8.8.8.8' }.to_json, headers:)

        expect(response).to have_http_status(:created)
        expect(Geolocation.count).to eq(1)
        expect(JSON.parse(response.body)['city']).to eq('Glenmont')
      end

      it 'returns an error with invalid IP address' do
        post(api_v1_geolocations_path, params: { ip_address: '0.9.9.0.8.4.5.6' }.to_json, headers:)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(Geolocation.count).to eq(0)
        expect(JSON.parse(response.body)['error']).to eq('Invalid IP address or URL')
      end

      it 'returns an error when invalid ip' do
        post(api_v1_geolocations_path, params: { ip_address: 'invalid_ip' }.to_json, headers:)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Invalid IP address or URL')
      end

      it 'returns an error when missing params or empty params' do
        post api_v1_geolocations_path, params: { ip_address: '{}', headers: }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Invalid IP address or URL')
      end
    end

    context 'with Url' do
      before do
        allow(GeolocationService).to receive(:new).and_return(instance_double(GeolocationService,
                                                                              call: geolocation_data))
      end
      it 'creates a new geolocation' do
        post(api_v1_geolocations_path, params: { url: 'https://www.example.com' }.to_json, headers:)
        expect(response).to have_http_status(:created)
        expect(Geolocation.count).to eq(1)
        expect(JSON.parse(response.body)['city']).to eq('Glenmont')
      end

      it 'returns an error with invalid Url format' do
        post(api_v1_geolocations_path, params: { url: 'ww.xx.cc' }.to_json, headers:)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(Geolocation.count).to eq(0)
        expect(JSON.parse(response.body)['error']).to eq('Invalid IP address or URL')
      end

      it 'returns an error with URL missing http' do
        post(api_v1_geolocations_path, params: { url: 'example.com' }.to_json, headers:)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(Geolocation.count).to eq(0)
        expect(JSON.parse(response.body)['error']).to eq('Invalid IP address or URL')
      end
    end
  end

  describe 'GET #show' do
    let(:geolocation) { FactoryBot.create(:geolocation) }

    it 'returns geolocation data' do
      get(api_v1_geolocation_path(geolocation), headers:)
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['city']).to eq(geolocation.city)
    end

    it 'returns an error when geolocation not found' do
      get(api_v1_geolocation_path('123.23'), headers:)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'DELETE #destroy' do
    let(:geolocation) { FactoryBot.create(:geolocation) }
    it 'deletes geolocation' do
      delete(api_v1_geolocation_path(geolocation), headers:)
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['content']).to eq('Successfully Deleted location.')
      expect(Geolocation.count).to eq(0)
    end

    it 'returns an error when geolocation not found' do
      delete(api_v1_geolocation_path('123.23'), headers:)
      expect(response).to have_http_status(:not_found)
    end
  end

  private

  def geolocation_data
    {
      ip_address: '8.8.8.8',
      country: 'United States',
      continent_code: 'NA',
      continent_name: 'North America',
      country_code: 'US',
      region_code: 'OH',
      region: 'Ohio',
      city: 'Glenmont',
      zip: '44628',
      latitude: 40.5369987487793,
      longitude: -82.12859344482422,
      ip_address_type: 'ipv4'
    }
  end
end
