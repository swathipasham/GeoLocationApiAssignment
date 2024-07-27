FactoryBot.define do
  factory :geolocation do
    ip_address { '8.4.8.8' }
    country { 'United States' }
    continent_code { 'NA' }
    continent_name { 'North America' }
    country_code { 'US' }
    region_code { 'OH' }
    region { 'Ohio' }
    city { 'Glenmont' }
    zip { '44628' }
    latitude { 40.5369987487793 }
    longitude { -82.12859344482422 }
    ip_address_type { 'ipv4' }
  end
end
