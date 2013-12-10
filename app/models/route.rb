class Route
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :locations
  accepts_nested_attributes_for :locations
  belongs_to :user

  field :start, type: Time
  field :stop, type: Time
  field :distance, type: BigDecimal
  field :total_points, type: Integer

end
