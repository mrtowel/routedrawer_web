require 'bcrypt'

class User
  include Mongoid::Document
  extend Enumerize

  store_in collection: :users

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  SEX = [:male, :female]
  ROLES = [:admin, :staff, :default, :removed]

  enumerize :sex, in: SEX
  enumerize :role, in: ROLES

  ## Database authenticatable
  field :role, :default => :default
  field :email, :type => String
  field :encrypted_password, :type => String, :default => ''
  field :api_key, :type => String, :default => ''
  field :first_name, :type => String
  field :last_name, :type => String
  field :sex
  field :birth_date, :type => Time

  ## Recoverable
  field :reset_password_token, :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count, :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at, :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip, :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time


  validates_uniqueness_of :api_key
  validates_presence_of :role, :api_key

  before_create do
    self.sex ||= self.first_name.downcase[-1] == 'a' ? :female : :male unless self.first_name.nil?
  end

  before_validation do
    if self.api_key.length != 32 or self.api_key.nil?
      self.api_key = generate_token
    end
  end

  def to_s
    "<#{self.email}>"
  end

  private

    def generate_token
      seed = [('a'..'z'), ('A'..'Z'), (0..9)].map { |i| i.to_a }.flatten
      (0..31).map { seed[rand(seed.length)] }.join
    end
end
