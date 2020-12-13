class Application < ApplicationRecord
  has_many :pets
  validates_presence_of :name, 
                        :street_address, 
                        :city, 
                        :state, 
                        :zip_code

  def self.search(search, id)
    app = Application.find([id])
    result = Pet.find_by(name: search)
    # probably going to have to add a column for the search results that can be passed into the index action
    if result
      require 'pry'; binding.pry
    else
      app
    end
  end
end