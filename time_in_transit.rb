load 'mixins/xml_mixin.rb'

module Isotope
  class TimeInTransit

    include Isotope::TimeInTransit::Mixins::Xml

    def initialize options={}
      #Transit from variables
      @origin_country_code                  = options.fetch(:origin_country_code, "US")
      @transit_from_political_division_1    = options.fetch(:transit_from_political_division_1, nil) #State/Province
      @transit_from_postcode_primary_low    = options.fetch(:transit_from_postcode_primary_low, nil) #Zip Code

      raise_errors_from_sym_array [:origin_country_code, :transit_from_political_division_1, :transit_from_postcode_primary_low]

      #Transit to variables
      @transit_to_country_code              = options.fetch(:transit_to_country_code, "US")
      @transit_to_political_division_1      = options.fetch(:transit_to_political_division_1, nil) #State/Province
      @transit_to_postcode_primary_low      = options.fetch(:transit_to_postcode_primary_low, nil) #Zip Code

      raise_errors_from_sym_array [:transit_to_country_code, :transit_to_political_division_1, :transit_to_postcode_primary_low]

      @total_packages       = options.fetch(:total_packages, 1)
      @currency_code        = options.fetch(:currency_code, "USD")
      @monetary_value       = options.fetch(:monetary_value, "0")
      @pickup_date          = options.fetch(:pickup_date, Time.now.strftime("%Y%m%d"))
      @weight               = options.fetch(:weight, nil)
      @unit_of_measurement  = options.fetch(:unit_of_measurement, "LBS")

      raise_errors_from_sym_array [:total_packages, :currency_code, :monetary_value, :pickup_date, :weight, :unit_of_measurement]
    end
end
