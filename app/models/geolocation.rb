# frozen_string_literal: true

# app/models/geolocation.rb
class Geolocation < ApplicationRecord
  validates :ip_address, :continent_code, :continent_name, :country_code, :country, :region_code, :region, :city, :zip,
            :latitude, :longitude, presence: true
  validates :ip_address, uniqueness: true
  validates :latitude, :longitude, numericality: true
end
