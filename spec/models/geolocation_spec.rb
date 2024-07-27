# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Geolocation, type: :model do
  let(:geolocation) { FactoryBot.create(:geolocation) }

  it 'is valid with valid attributes' do
    expect(geolocation).to be_valid
  end

  it 'is invalid without latitude' do
    geolocation.latitude = nil
    expect(geolocation).not_to be_valid
  end

  it 'is invalid without longitude' do
    geolocation.longitude = nil
    expect(geolocation).not_to be_valid
  end

  it 'is invalid without city' do
    geolocation.city = nil
    expect(geolocation).not_to be_valid
  end

  it 'is invalid without zip' do
    geolocation.zip = nil
    expect(geolocation).not_to be_valid
  end

  it 'is invalid without country' do
    geolocation.country = nil
    expect(geolocation).not_to be_valid
  end

  it 'is invalid without country_code' do
    geolocation.country_code = nil
    expect(geolocation).not_to be_valid
  end

  it 'is invalid without continent_code' do
    geolocation.continent_code = nil
    expect(geolocation).not_to be_valid
  end

  it 'is invalid without continent_name' do
    geolocation.continent_name = nil
    expect(geolocation).not_to be_valid
  end

  it 'is invalid without region_code' do
    geolocation.region_code = nil
    expect(geolocation).not_to be_valid
  end

  it 'is invalid without region' do
    geolocation.region = nil
    expect(geolocation).not_to be_valid
  end

  it 'is invalid without ip_address' do
    geolocation.ip_address = nil
    expect(geolocation).not_to be_valid
  end
end
