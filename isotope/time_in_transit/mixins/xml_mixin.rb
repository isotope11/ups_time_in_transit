module Isotope
  module TimeInTransitMixins
    module XML
      def build_xml
        build_access_request_hash
        build_time_in_transit_request_hash

        xml_dec = "<?xml version='1.0' ?>"
        xml = ""
        xml << xml_dec.dup
        xml << "\n"
        xml << gsub_xml(XmlSimple.xml_out(@access_request_hash)).gsub("<opt>","\n<AccessRequest xml:lang='en-US'>").gsub("</opt>", "</AccessRequest>")
        xml << "\n"
        xml << xml_dec
        xml << "\n"
        xml << gsub_xml(XmlSimple.xml_out(@time_in_transit_hash)).gsub("<opt>","\n<TimeInTransitRequest xml:lang='en-US'>").gsub("</opt>","</TimeInTransitRequest>")
      end

      private

      def gsub_xml xml
        xml.gsub("<anon>","").gsub("</anon>","").gsub(" ", "").gsub("\n","")
      end

      # Check all the symbols in the array to make sure the corresponding instance variable is not nil, if it is raise
      def raise_errors_from_sym_array sym_array
        sym_array.each do |sym|
          if eval("@#{sym.to_s}.nil?")
            raise "#{sym.to_s} is required"
          end
        end
      end

      def build_access_request_hash
        #<?xml version="1.0" ?>
        #<AccessRequest xml:lang='en-US'> <AccessLicenseNumber>YOURACCESSLICENSENUMBER</AccessLicenseNumber> <UserId>YOURUSERID</UserId>
        #<Password>YOURPASSWORD</Password>
        #</AccessRequest>
        @access_request_hash = [{"AccessLicenseNumber" => [@access_license_number]}, {"UserId" => [@user_id]}, {"Password" => [@password] } ]
      end

      def build_time_in_transit_request_hash
        @time_in_transit_hash = [
                          xml_request_hash,
                          xml_transit_from,
                          xml_transit_to,
                          xml_shipment_weight,
                          {"TotalPackagesInShipment" => [@total_packages] },
                          {"InvoiceLineTotal"        => {"CurrencyCode"  => [@currency_code], "MonetaryValue" => [@monetary_value] }},
                          {"PickupDate"              => [@pickup_date] }
        ]
      end

      def xml_request_hash
        # Request part of the hash
        # Should look like:
        # <Request>
        #   <TransactionReference>
        #     <CustomerContext>TNT_D Origin Country Code</CustomerContext> 
        #     <XpciVersion>1.0002</XpciVersion>
        #   </TransactionReference>
        #   <RequestAction>TimeInTransit</RequestAction>
        # </Request>

        {"Request" => {
                        "TransactionReference" => {
                                        "CustomerContext" => [@origin_country_code],
                                        "XpciVersion" => ["1.0002"]
                                     },
                        "RequestAction"        => ["TimeInTransit"]
                      }
        }
      end

      def xml_transit_from
        # Transit from part of hash
        # Should look like:
        # <TransitFrom> 
        #   <AddressArtifactFormat>
        #     <PoliticalDivision1>CITY OF LONDON</PoliticalDivision1> 
        #     <CountryCode>GB</CountryCode> 
        #     <PostcodePrimaryLow>EC03</PostcodePrimaryLow>
        #   </AddressArtifactFormat> 
        # </TransitFrom>

        {"TransitFrom" => {"AddressArtifactFormat" => {
                                                        "PoliticalDivision1" => [@transit_from_political_division_1],
                                                        "CountryCode"         => [@transit_from_country_code],
                                                        "PostcodePrimaryLow"  => [@transit_from_postcode_primary_low]
                                                     }
                          }
        }
      end

      def xml_transit_to
        # Transit to part of hash
        # Should look like:
        # <TransitTo> 
        #   <AddressArtifactFormat>
        #     <PoliticalDivision1>CITY OF LONDON</PoliticalDivision1> 
        #     <CountryCode>GB</CountryCode> 
        #     <PostcodePrimaryLow>EC03</PostcodePrimaryLow>
        #   </AddressArtifactFormat> 
        # </TransitTo>

        {"TransitTo" => {"AddressArtifactFormat" => {
                                                        "PoliticalDivision1" => [@transit_to_political_division_1],
                                                        "CountryCode"         => [@transit_to_country_code],
                                                        "PostcodePrimaryLow"  => [@transit_to_postcode_primary_low]
                                                     }
                          }
        }
      end

      def xml_shipment_weight
        # Shipment Weight part of hash
        # Should look like:
        # <ShipmentWeight>
        #   <UnitOfMeasurement> 
        #     <Code>KGS</Code> 
        #     <Description>Kilograms</Description>
        #   </UnitOfMeasurement>
        #   <Weight>23</Weight>
        # </ShipmentWeight>

        {"ShipmentWeight" => {
                                "UnitOfMeasurement" => { "Code" => [@unit_of_measurement] },
                                "Weight"            => [@weight]
                             }
        }
      end
    end
  end
end
