class ApplicationPet < ApplicationRecord

  belongs_to :application
  belongs_to :pet

  enum approval: [:tbd, :approved, :rejected]

  def self.status
    if where(approval: "rejected")
      
    end
  end
end
