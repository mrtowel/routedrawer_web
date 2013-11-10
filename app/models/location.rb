require 'enumerize'


class Location
  extend Enumerize
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  enumerize :provider, in: [:gps, :network]

  belongs_to :user

  field :lat, type: String
  field :lng, type: String
  field :provider
  field :accuracy, type: String
  field :measured_at, type: Time

  validates_presence_of :lat, :lng, :user

end
