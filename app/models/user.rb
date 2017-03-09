require 'rubygems'
require 'data_mapper'
require 'dm-postgres-adapter'

class User

  include DataMapper::Resource

  property :id,     Serial
  property :name,   String

end

DataMapper.setup(:default, "postgres://localhost/rock_paper_scissors")
DataMapper.finalize
DataMapper.auto_upgrade!
