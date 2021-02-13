class Application < ApplicationRecord
  validates_presence_of :name, 
                        :street_address, 
                        :city, 
                        :state, 
                        :zip_code

  has_many :pets
end