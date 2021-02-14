require 'rails_helper'

describe 'Application show page' do
  before(:each) do
    @app = create(:application)

    @pet = create(:pet)
  end
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
    
    describe "the application has not been submitted" do
      it "has a section to add a pet to the application" do
        visit "/applications/#{@app.id}"
        
        expect(page).to have_css('#pet-search')
        
        within("#pet-search") do
          expect(page).to have_content("Search for pets to add to your application:")
        end
      end
      
      it "has a section to search for pets by name"do 
        visit "/applications/#{@app.id}"
        
        expect(page).to have_css('#pet-search-bar')
        
        expect(page).to have_field(:pet_name)
        expect(page).to have_button("Search")
      end

      it "returns search results for the name of the pet" do
        pet = create(:pet, name: "Fido")

        visit "/applications/#{@app.id}"

        fill_in :pet_name, with: "Fido"
        click_on("Search")
        expect(current_path).to eq application_path(@app)

        expect(page).to have_content(pet.name)
      end
    end

    it "can add a searched for pet to the application" do
      visit "/applications/#{@app.id}"

      fill_in :pet_name, with: "#{@pet.name}"
      click_on("Search")

      within("#pet-search") do
        expect(page).to have_content(@pet.name)
        expect(page).to have_button("Adopt this Pet")
      end

      click_button("Adopt this Pet")
      expect(current_path).to eq(application_path(@app, @pet))

      within("#application-#{@app.id}") do
        expect(page).to have_content(@pet.name)
      end
    end
  end
end