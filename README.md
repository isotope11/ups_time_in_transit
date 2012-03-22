UPS Time In Transit API Client

Ruby 1.8.7

Usage:

    load "isotope/time_in_transit/time_in_transit.rb"

    options_hash = {
        :transit_from_political_division_1 => "Alabama",
        :transit_from_postcode_primary_low => "35071",
        :transit_to_political_division_1 => "Kentucky",
        :transit_to_postcode_primary_low => "42104",
        :weight => "23",
        :access_license_number => "ACCESS_KEY",
        :user_id => "USERNAME",
        :password => "PASSWORD",
        :transit_from_country_code => "US"}

    time_in_transit = Isotope::TimeInTransit.new options_hash
    time_in_transit.get_time_in_transit
