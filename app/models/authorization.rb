class Authorization
  include Mongoid::Document

  belongs_to :user

  field :provider, type: String
  field :uid, type: String
end
