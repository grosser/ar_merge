require 'rubygems'
require 'active_record'
require 'active_record/fixtures'

#create model table
ActiveRecord::Schema.define(:version => 1) do
  create_table :users do |t|
    t.string :name
    t.timestamps
  end

  create_table :counting_users do |t|
    t.integer :movies_count, :default=>0, :null=>false
    t.string :name
    t.timestamps
  end

  create_table :movies do |t|
    t.integer :user_id
    t.integer :counting_user_id
    t.timestamps
  end
end

#create model
class User < ActiveRecord::Base
  has_many :movies
end

class CountingUser < ActiveRecord::Base
  has_many :movies
end

class Movie < ActiveRecord::Base
  belongs_to :user
  belongs_to :counting_user, :counter_cache => true
end