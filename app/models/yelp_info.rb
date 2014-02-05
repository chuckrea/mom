class YelpInfo < ActiveRecord::Base
  attr_accessible :address, :cuisine_type, :restaurant_name, :user_id
  belongs_to :user




end

