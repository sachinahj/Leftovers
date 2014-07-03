module Leftovers
  class AddLatLng
    def self.run(session)
      restaurant_id = session[:restaurant_id]
      lat_lng = session[:lat_lng]
      coordinates = "#{session[:lat_lng]["lat"]},#{session[:lat_lng]["lng"]}"

      restaurant = Leftovers.orm.get_restaurant_by_id(restaurant_id)
      return false if restaurant.nil?

      restaurant.coordinates = coordinates
      restaurant.save
      return true
    end
  end
end