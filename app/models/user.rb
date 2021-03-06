require 'rubygems'
require 'bcrypt'
require 'data_mapper'
require 'dm-postgres-adapter'
require_relative 'victory'

class User

  attr_reader :weapon

  include DataMapper::Resource

  property :id,     Serial
  property :name,   String, required: true
  property :email,   String, required: true, unique: true
  property :password_digest, Text
  attr_reader :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password
  validates_format_of :email, as: :email_address

  has n, :victories, :defeats, :draws

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    user = first(email: email)
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end

  def user_weapon(weapon)
    @weapon = weapon
  end

  def first_name
    name.split(" ")[0]
  end
end
