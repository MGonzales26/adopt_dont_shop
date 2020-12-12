class Application < ApplicationRecord
  has_many :pets
  validates_presence_of :name, 
                        :street_address, 
                        :city, 
                        :state, 
                        :zip_code
end