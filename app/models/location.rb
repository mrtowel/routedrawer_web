require 'enumerize'


class Location
  extend Enumerize
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  embedded_in :route
  enumerize :provider, in: [:gps, :network]

  field :lat, type: BigDecimal
  field :lng, type: BigDecimal
  field :provider, type: String
  field :accuracy, type: BigDecimal
  field :measured_at, type: Time

  validates_presence_of :lat, :lng

end
