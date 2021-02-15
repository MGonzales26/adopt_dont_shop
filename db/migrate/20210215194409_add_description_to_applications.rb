class AddDescriptionToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :description, :text
  end
end
