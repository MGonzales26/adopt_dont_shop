class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets
  validates_presence_of :name, :description, :approximate_age, :sex

  validates :approximate_age, numericality: {
              greater_than_or_equal_to: 0
            }

  enum sex: [:female, :male]

  def self.search_for_pet(name)
    where('lower(name) LIKE ?', "%#{name.downcase}%")
  end

  def approve_pet(id, approval)
    application_pets.where(application_id: id, pet_id: self.id)
    .update(approval: approval.to_i)
  end
end
