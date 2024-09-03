require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection
class User < ActiveRecord::Base
    has_secure_password
    has_many :history
    has_many :good, through: :history
end

class Good < ActiveRecord::Base
    has_many :history
    has_many :user, through: :history
end

class History < ActiveRecord::Base
    belongs_to :user
    belongs_to :good
end