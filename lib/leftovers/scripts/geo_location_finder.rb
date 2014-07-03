module Leftovers
  class GeoLocationFinder
    def self.run(search)
      location = "30.274665,-97.74035"
      radius = "50000"
      keyword = search.gsub(" ","%20")
      key = "AIzaSyCOnpZgn-7iSwcokSBUF8qM-BC2kbrC-v8"

      api_url_base = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
      api_request_url = "#{api_url_base}location=#{location}&radius=#{radius}&keyword=#{keyword}&key=#{key}"

      place_ids_response = Unirest.get(api_request_url,
        headers: { "Accept" => "application/json" })

      geo_locations = []
      place_ids_response.body["results"].each do |info|
        if info["name"].downcase == search.downcase
          geo_locations << info["geometry"]["location"]
        end
      end

      return geo_locations
    end
  end
end