require 'rails_helper'

describe 'Application show page' do
  describe 'As a Visitor' do
    it 'has the application information' do
      app = Application.create!(name: "Megan", street_address: "3400 Commander Ct", city: "Denver", state: "Colorado", zip_code: 80026)
      
      visit "/applications/#{app.id}"

      expect(page).to have_content("Name of Applicant: #{app.name}")
      expect(page).to have_content("Street Address: #{app.street_address}")
      expect(page).to have_content("City: #{app.city}")
      expect(page).to have_content("State: #{app.state}")
      expect(page).to have_content("Zip Code: #{app.zip_code}")
      expect(page).to have_content("Pets Applied For:")
      expect(page).to have_content("Status: #{app.status}")
    end
  end
end