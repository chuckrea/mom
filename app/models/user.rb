class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :first_name, :location, :weather, :username, :to_phone_number
  attr_accessible :latitude, :longitude
  # attr_accessible :title, :body

  geocoded_by :location  
  after_validation :geocode

end
