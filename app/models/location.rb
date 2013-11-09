class Location
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :lat, type: String
  field :lng, type: String

end
