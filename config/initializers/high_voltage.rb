# frozen_string_literal: true
# config/initializers/high_voltage.rb
# enables use of address without pages in it
# http://visitmeet.com/about versus
# http://visitmeet.com/pages/about
HighVoltage.configure do |config|
  config.route_drawer = HighVoltage::RouteDrawers::Root
end
