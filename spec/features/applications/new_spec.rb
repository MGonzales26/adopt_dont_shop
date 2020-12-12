require 'rails_helper'

describe "New Application Page" do
  describe "it has the form for new application" do
    it "has fields" do
      visit "/applications/new"

      expect(page).to have_content("Your Name:")
      expect(page).to have_field(:name)
      expect(page).to have_content("Street Address:")
      expect(page).to have_field(:street_address)
      expect(page).to have_content("City:")
      expect(page).to have_field(:city)
      expect(page).to have_content("State:")
      expect(page).to have_field(:state)
      expect(page).to have_content("Zip Code:")
      expect(page).to have_field(:zip_code)
    end
  end
end