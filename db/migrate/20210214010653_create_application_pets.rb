class CreateApplicationPets < ActiveRecord::Migration[5.2]
  def change
    create_table :application_pets do |t|
      t.references :application
      t.references :pet

      t.timestamps
    end
  end
end
