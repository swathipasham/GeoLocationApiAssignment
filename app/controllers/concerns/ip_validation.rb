# frozen_string_literal: true

# app/controllers/concerns/ip_validation.rb
module IpValidation
  extend ActiveSupport::Concern
  require 'uri'
  require 'socket'

  included do
    before_action :validate_ip_or_url, only: %i[create]
  end

  private

  # Validates the IP address or URL
  def validate_ip_or_url
    param = params[:ip_address] || params[:url]
    @ip_address = valid_ip?(param) ? param : resolve_url_to_ip(param)

    render json: { error: 'Invalid IP address or URL' }, status: :unprocessable_entity unless @ip_address
  end

  # Validates the IP address
  def valid_ip?(ip)
    ip =~ Resolv::IPv4::Regex || ip =~ Resolv::IPv6::Regex ? true : false
  end

  # Validates the URl and  Resolves the URL to IP address
  def resolve_url_to_ip(url)
    uri = URI.parse(url)
    return false if uri.host.nil?

    begin
      Addrinfo.getaddrinfo(uri.host, nil).first.ip_address
      true
    rescue SocketError
      false
    end
  rescue URI::InvalidURIError
    false
  end
end
