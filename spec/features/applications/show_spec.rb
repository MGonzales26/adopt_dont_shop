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
      
      it "does not show the submit button if there are no pets" do
        visit "/applications/#{@app.id}"
        
        expect(page).to_not have_content("Tell us why you would make a good home:")
        expect(page).to_not have_button("Submit Application")
        
        fill_in :pet_name, with: "#{@pet.name}"
        click_on("Search")
        click_on("Adopt this Pet")
        expect(current_path).to eq(application_path(@app))
        
        expect(page).to have_content("Tell us why you would make a good home:")
        expect(page).to have_button("Submit Application")
      end
      
      it "shows pets with partially matching search" do
        pet1 = create(:pet, name: "Fluff")
        pet2 = create(:pet, name: "Fluffy")
        pet3 = create(:pet, name: "Barroness Fluffers")
        pet4 = create(:pet, name: "Mr. Fluffy Flufferton")
        
        visit "/applications/#{@app.id}"
        
        fill_in :pet_name, with: "Fluff"
        click_on("Search")

        expect(page).to have_content(pet1.name)
        expect(page).to have_content(pet2.name)
        expect(page).to have_content(pet3.name)
        expect(page).to have_content(pet4.name)
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
      expect(current_path).to eq(application_path(@app))
      
      within("#application-#{@app.id}") do
        expect(page).to have_content(@pet.name)
      end
    end
    
    describe "has a section to submit when pets are added" do
      it "has a section I see an input to enter why I would make a good owner" do
        @app.pets << @pet 

        visit "/applications/#{@app.id}"
        
        within("#application-pets-list") do
          expect(page).to have_content(@pet.name)
        end
        
        expect(page).to have_field(:good_owner_statement)
      end
      
      it "has a button to submit this application" do 
        @app.pets << @pet 
  
        visit "/applications/#{@app.id}"

        expect(page).to have_button("Submit Application")
      end
    end

    describe "returns to the show page when submitted" do
      it "changes status to pending" do
        @app.pets << @pet 
  
        visit "/applications/#{@app.id}"

        fill_in :good_owner_statement, with: "I love pets!"
        
        click_on("Submit Application")
        expect(current_path).to eq(application_path(@app))
        
        expect(page).to have_content("Status: Pending")
      end
      
      it "lists the pets I want to adopt" do
        pet2 = create(:pet)
        pet3 = create(:pet)
        @app.pets << @pet 
        @app.pets << pet2 
        @app.pets << pet3 
        
        visit "/applications/#{@app.id}"
        
        within("#application-pets-list") do
          expect(page).to have_content(@pet.name)
          expect(page).to have_content(pet2.name)
          expect(page).to have_content(pet3.name)
        end
      end
      
      it "does not have a section to add more pets to this application" do
        @app.pets << @pet
        visit "/applications/#{@app.id}"
        
        fill_in :good_owner_statement, with: "I love pets!"
        
        click_on("Submit Application")
        expect(current_path).to eq(application_path(@app))
        
        expect(page).to_not have_content("Search for pets to add to your application:")
        expect(page).to_not have_button("Search")
        expect(page).to_not have_field(:good_owner_statement)
      end
    end
  end
end

