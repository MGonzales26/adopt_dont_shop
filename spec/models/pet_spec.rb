require 'rails_helper'

describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to :shelter }
    it { should have_many :application_pets}
    it { should have_many(:applications).through(:application_pets) }
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :sex}
    it {should validate_numericality_of(:approximate_age).is_greater_than_or_equal_to(0)}

    it 'is created as adoptable by default' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(name: "Fluffy", approximate_age: 3, sex: 'male', description: 'super cute')
      expect(pet.adoptable).to eq(true)
    end

    it 'can be created as not adoptable' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(adoptable: false, name: "Fluffy", approximate_age: 3, sex: 'male', description: 'super cute')
      expect(pet.adoptable).to eq(false)
    end

    it 'can be male' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(sex: :male, name: "Fluffy", approximate_age: 3, description: 'super cute')
      expect(pet.sex).to eq('male')
      expect(pet.male?).to be(true)
      expect(pet.female?).to be(false)
    end

    it 'can be female' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: 'super cute')
      expect(pet.sex).to eq('female')
      expect(pet.female?).to be(true)
      expect(pet.male?).to be(false)
    end
  end

  describe 'Class methods' do
    describe '::search_for_pet' do
      it "returns a list of pets matching the name given" do
        pet = create(:pet)

        expect(Pet.search_for_pet(pet.name)).to eq ([pet])
      end

      it "returns more than one pet of the same name" do
        pet1 = create(:pet, name: "Fido")
        pet2 = create(:pet, name: "Fido")
        pet3 = create(:pet, name: "Fido")

        expected = [pet1, pet2, pet3]

        expect(Pet.search_for_pet("Fido")).to eq(expected)
      end

      it "returns a pet with a partial match" do
        pet1 = create(:pet, name: "Fido")
        
        expected = [pet1]
        
        expect(Pet.search_for_pet("Fi")).to eq(expected)
      end
      
      it "doesn't care about case" do
        pet1 = create(:pet, name: "Fido")
        pet2 = create(:pet, name: "FIdO")

        expected = [pet1, pet2]
        
        expect(Pet.search_for_pet("fi")).to eq(expected)
        expect(Pet.search_for_pet("fI")).to eq(expected)
        expect(Pet.search_for_pet("FI")).to eq(expected)
      end
    end
  end

  describe "Instance Methods" do
    describe "#approve_pet" do
      xit "changes the pets approved status to true" do
        pet = create(:pet)

        expect(pet.approved).to eq(false)
        expect(pet.approve_pet).to eq(true)
      end

      it "changes the application pet approved status to approved" do
        app = create(:application)
        pet = create(:pet)
        app.pets << pet
        
        pet.approve_pet(app.id, 1)
        expect(pet.application_pets[0].approval).to eq("approved")
      end
      
      it "changes the application pet approved status to rejected" do
        app = create(:application)
        pet = create(:pet)
        app.pets << pet
        
        pet.approve_pet(app.id, 2)
        expect(pet.application_pets[0].approval).to eq("rejected")
      end

      it "has an approval that is tbd" do
        app = create(:application)
        pet = create(:pet)
        app.pets << pet
        
        expect(pet.application_pets[0].approval).to eq("tbd")
      end
    end
  end
end

