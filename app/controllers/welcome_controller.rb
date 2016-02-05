class WelcomeController < ApplicationController
  layout false
  def index
    @products = Product.all
    # Use last_sign_in_ip from user and get the lat and lon from that.
    # @users = User.all
    # http://freegeoip.net/{format}/{ip_or_hostname}

    @map_hash = Gmaps4rails.build_markers(@products) do |product, marker|
      marker.lat product.latitude
      marker.lng product.longitude
      marker.infowindow product.title
    end
  end
end
