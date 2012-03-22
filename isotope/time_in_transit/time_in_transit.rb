require 'rubygems'
require 'httparty'
require 'xmlsimple'

load 'isotope/time_in_transit/mixins/xml_mixin.rb'
load 'isotope/time_in_transit/mixins/http_mixin.rb'

module Isotope
  class TimeInTransit

    include Isotope::TimeInTransitMixins::XML
    include Isotope::TimeInTransitMixins::HTTP
    include HTTParty

    def initialize options={}
      #Authentication
      @access_license_number                = options.fetch(:access_license_number, nil)
      @user_id                              = options.fetch(:user_id , nil)
      @password                             = options.fetch(:password , nil)

      #Transit from variables
      @transit_from_country_code            = options.fetch(:transit_from_country_code, "US")
      @transit_from_political_division_1    = options.fetch(:transit_from_political_division_1, nil) #State/Province
      @transit_from_postcode_primary_low    = options.fetch(:transit_from_postcode_primary_low, nil) #Zip Code

      #Transit to variables
      @transit_to_country_code              = options.fetch(:transit_to_country_code, "US")
      @transit_to_political_division_1      = options.fetch(:transit_to_political_division_1, nil) #State/Province
      @transit_to_postcode_primary_low      = options.fetch(:transit_to_postcode_primary_low, nil) #Zip Code

      #Misc
      @origin_country_code                  = options.fetch(:origin_country_code, "US")
      @total_packages                       = options.fetch(:total_packages, 1)
      @currency_code                        = options.fetch(:currency_code, "USD")
      @monetary_value                       = options.fetch(:monetary_value, "0")
      @pickup_date                          = options.fetch(:pickup_date, Time.now.strftime("%Y%m%d"))
      @weight                               = options.fetch(:weight, nil)
      @unit_of_measurement                  = options.fetch(:unit_of_measurement, "LBS")

      raise_errors_from_sym_array [:access_license_number, :user_id, :password, :transit_from_country_code, :transit_from_political_division_1, :transit_from_postcode_primary_low, :transit_to_country_code, :transit_to_political_division_1, :transit_to_postcode_primary_low, :origin_country_code, :total_packages, :currency_code, :monetary_value, :pickup_date, :weight, :unit_of_measurement]
    end

    def get_time_in_transit
      ups_api_call(build_xml)
    end

  end
end
