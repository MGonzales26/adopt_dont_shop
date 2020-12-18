class Application < ApplicationRecord
  has_many :pets
  has_many :pets, through: :application_pets
  validates_presence_of :name, 
                        :street_address, 
                        :city, 
                        :state, 
                        :zip_code

  def self.search(search)
    Pet.where("name like ?", "%#{search}%")
  end
end