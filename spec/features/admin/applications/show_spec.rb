require 'rails_helper'

RSpec.describe "admin application show page" do
  before(:each) do
    @app = create(:application)

    @pet1 = create(:pet)
    @pet2 = create(:pet)
    @pet3 = create(:pet)
    @pet4 = create(:pet)

    @app.pets << @pet1
    @app.pets << @pet2
    @app.pets << @pet3
    @app.pets << @pet4
  end
  
  describe "As a visitor" do
    it "lists the pets on the application with a button to approve the application for that pet" do
      visit "/admin/applications/#{@app.id}"
      
      expect(page).to have_content(@pet1.name)
      expect(page).to have_content(@pet2.name)
      expect(page).to have_content(@pet3.name)
      expect(page).to have_content(@pet4.name)
      
      within("#admin-application-pet-#{@pet1.id}") do
        expect(page).to have_button("Approve Pet")
      end
    end
    
    describe "When I click that button" do
      it "doesn't have a button next to the pet I approved instead it shows approval" do
        visit "/admin/applications/#{@app.id}"
        
        within("#admin-application-pet-#{@pet1.id}") do
          click_button("Approve Pet")
          expect(current_path).to eq admin_application_path(@app)
          expect(page).to have_content("has been approved")
          expect(page).to_not have_button("Approve Pet")
        end
      end      
    end
    
    it "has a button to reject a pets approval" do
      visit "/admin/applications/#{@app.id}"
      
      within("#admin-application-pet-#{@pet1.id}") do
        expect(page).to have_button("Reject Pet")
      end
      
    end
    
    it "shows a rejection and does not show an approve or reject button" do
      visit "/admin/applications/#{@app.id}"
      
      within("#admin-application-pet-#{@pet1.id}") do
        click_button("Reject Pet")
        expect(current_path).to eq(admin_application_path(@app))
        expect(page).to have_content("has been rejected")
        expect(page).to_not have_button("Reject Pet")
      end
    end
  end
end