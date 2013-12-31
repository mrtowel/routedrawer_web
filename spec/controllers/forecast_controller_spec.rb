require 'spec_helper'

describe ForecastController do

  describe "GET 'location'" do
    it "returns http success" do
      get 'location'
      response.should be_success
    end
  end

  describe "GET 'weather'" do
    it "returns http success" do
      get 'weather'
      response.should be_success
    end
  end

end
