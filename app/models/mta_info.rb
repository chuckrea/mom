class MtaInfoController < ActiveRecord::Base
  attr_accessible :line, :user_id
  belongs_to :user

end