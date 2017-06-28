require 'data_mapper'
require 'dm-postgres-adapter'
require_relative 'user'

class Defeat

  include DataMapper::Resource

  property :id,     Serial

  belongs_to :user

end
