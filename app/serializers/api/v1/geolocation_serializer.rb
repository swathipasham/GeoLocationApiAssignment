# app/serializers/api/v1/geolocation_serializer.rb
module Api
  module V1
    class GeolocationSerializer < ActiveModel::Serializer
      attributes :id, :ip_address, :ip_address_type, :continent_code, :continent_name, :country_code, :country,
                 :region_code, :region, :city, :zip, :latitude, :longitude, :created_at, :updated_at, :host_name,
                 :isp, :org, :timezone, :offset
    end
  end
end
