class Location
  include Mongoid::Document
  include Mongoid::Timestamps

  field :lat, type: String
  field :lng, type: String
end
