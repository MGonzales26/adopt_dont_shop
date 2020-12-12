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

    it "links to the show page with new Application" do
      visit "/applications/new"

      fill_in :name, with: "Megan"
      fill_in :street_address, with: "456 Fake St"
      fill_in :city, with: "Denver"
      fill_in :state, with: "Colorado"
      fill_in :zip_code, with: 80026

      click_on 'Submit Application'

      expect(page).to have_content("Megan")
      expect(page).to have_content("456 Fake St")
      expect(page).to have_content("Denver")
      expect(page).to have_content("Colorado")
      expect(page).to have_content(80026)
      expect(page).to have_content("In Progress")
    end

    it "redirects if one of the fields is blank" do
      visit "/applications/new"

      click_on 'Submit Application'

      expect(page).to have_content("Submission not accepted: Required information missing.")
      expect(page).to have_button("Submit Application")
    end
  end
end