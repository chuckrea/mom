class FarmersMarket < ActiveRecord::Base
  attr_accessible :location, :market_name, :operation_hours

  belongs_to :user
end
