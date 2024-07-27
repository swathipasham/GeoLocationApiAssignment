# frozen_string_literal: true

module Api
  module V1
    class GeolocationsController < BaseController
      include IpValidation
      before_action :geolocation, only: %i[show destroy]

      # POST /api/v1/geolocations
      def create
        # this service will fetch the geolocation data from the IP address of a given service provider
        result_data = GeolocationService.new(@ip_address, IpstackService).call

        if result_data[:error]
          render json: result_data, status: :unprocessable_entity
          return
        end

        # this will create a new geolocation record
        geolocation = Geolocation.new(result_data)
        if geolocation.save
          render json: geolocation, serializer: Api::V1::GeolocationSerializer, status: :created
        else
          render json: geolocation.errors, status: :unprocessable_entity
        end
      end

      # GET /api/v1/geolocations/:ip_address
      def show
        if @geolocation
          render json: @geolocation, serializer: Api::V1::GeolocationSerializer, status: :ok
        else
          render json: { error: 'Geolocation not found' }, status: :not_found
        end
      end

      # DELETE /api/v1/geolocations/:ip_address
      def destroy
        @geolocation.destroy
        render json: { content: 'Successfully Deleted location.' }, status: '200'
      end

      private

      # Fetches the geolocation data from the IP address
      def geolocation
        @geolocation = Geolocation.find(params[:id])
        render json: { error: 'Geolocation not found' }, status: :not_found unless @geolocation
      end

      # Permitted params
      def permitted_params
        params.permit(:ip_address, :url)
      end
    end
  end
end
