require 'rails_helper'

describe 'Application show page' do
  it 'has the application information' do
    app = Application.create!(name: "Megan", street_address: "3400 Commander Ct", city: "Denver", state: "Colorado", zip_code: 80026)
    
    visit "/applications/#{app.id}"

    expect(page).to have_content("Name of Applicant: #{app.name}")
    expect(page).to have_content("Street Address: #{app.street_address}")
    expect(page).to have_content("City: #{app.city}")
    expect(page).to have_content("State: #{app.state}")
    expect(page).to have_content("Zip Code: #{app.zip_code}")
    expect(page).to have_content("Pets Applied For:")
    expect(page).to have_content("Status:")
  end

  it "has a search for pets field" do
    app = Application.create!(name: "Megan", street_address: "3400 Commander Ct", city: "Denver", state: "Colorado", zip_code: 80026)

    visit "/applications/#{app.id}"

    expect(page).to have_content("Add a Pet to this Application")
    expect(page).to have_button("Search")
    expect(page).to have_field(:search)
    expect(page).to have_no_content("Milo")
  end

  it "can search for pets" do
    app = Application.create!(name: "Megan", street_address: "3400 Commander Ct", city: "Denver", state: "Colorado", zip_code: 80026)

    shelter = Shelter.create!(name: "shelter", address: "12 fake st", city: "Denver", state: "Colorado", zip: 80020)
    
    milo = Pet.create!(name: "Milo", shelter_id: "#{shelter.id}", sex: 'male', description: "Pantheresque", approximate_age: 3)
    milly = Pet.create!(name: "Milly", shelter_id: "#{shelter.id}", sex: 'female', description: "Sample", approximate_age: 3)
    maddie = Pet.create!(name: "Maddie", shelter_id: "#{shelter.id}", sex: 'female', description: "3 Legs", approximate_age: 10)
    
    visit "/applications/#{app.id}"

    fill_in :search, with: "Mil"

    click_on 'Search'

    expect(page).to have_content("Milo")
    end

    it "can add searched pets" do
      app = Application.create!(name: "Megan", street_address: "3400 Commander Ct", city: "Denver", state: "Colorado", zip_code: 80026)

      shelter = Shelter.create!(name: "shelter", address: "12 fake st", city: "Denver", state: "Colorado", zip: 80020)
      
      milo = Pet.create!(name: "Milo", shelter_id: "#{shelter.id}", sex: 'male', description: "Pantheresque", approximate_age: 3)
      maddie = Pet.create!(name: "Maddie", shelter_id: "#{shelter.id}", sex: 'female', description: "3 Legs", approximate_age: 10)
      
      visit "/applications/#{app.id}"
  
      fill_in :search, with: "Milo"
  
      click_on 'Search'
  
      expect(page).to have_button("Add Pet")

      click_on 'Add Pet'

      # expect(current_path).to eq("/applications/#{app.id}")
    end
end