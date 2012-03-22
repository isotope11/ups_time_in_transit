module Isotope
  module TimeInTransitMixins
    module HTTP
      include HTTParty

      def ups_api_call ups_xml
        response = self.class.post("https://wwwcie.ups.com/ups.app/xml/TimeInTransit", :body => ups_xml).parsed_response
        response["TimeInTransitResponse"]["TransitResponse"]["ServiceSummary"]
      end
    end
  end
end
