require 'open-uri'
require 'json'

class ForecastController < ApplicationController

  def location
    @locations = JSON.parse geocode_name('lotnisko')
  end

  def weather
    if params['q'].nil?
      @weather = JSON.parse '{"error": "please provide q url parameter, ex. ?q=<location>"}'
      return
    end
    result = JSON.parse geocode_name(params['q'])
    if result['status'] == 'OK'
      result['results'].each do |address|
        lat = address['geometry']['location']['lat']
        lng = address['geometry']['location']['lng']
        @weather = JSON.parse forecast_weather(lat,lng)
      end
    end

  end

  private
    def geocode_name(name)
      open("http://maps.googleapis.com/maps/api/geocode/json?address=#{name},poland&sensor=true").read
    end

    def forecast_weather(lat,lng)
      open("https://api.forecast.io/forecast/#{ENV['FORECAST_API_KEY']}/#{lat},#{lng}?units=si").read
    end
end
