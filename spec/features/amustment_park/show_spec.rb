require 'rails_helper'

RSpec.describe 'Amusement Park Show Page', type: :feature do
  before :each do 
    @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
    @universal = AmusementPark.create!(name: 'Universal Studios', admission_cost: 80)
    
    @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
    @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
    @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)
    @jaws = @universal.rides.create!(name: 'Jaws', thrill_rating: 5, open: true)
    
    @mechanic_1 = Mechanic.create!(name: "Charlie Smith", years_experience: 4)
    @mechanic_2 = Mechanic.create!(name: "Michael Jones", years_experience: 20)
    @mechanic_3 = Mechanic.create!(name: "John Doe", years_experience: 12)
    
    ride_mechanic_1 = RideMechanic.create(mechanic_id: @mechanic_1.id, ride_id: @jaws.id)
    ride_mechanic_2 = RideMechanic.create(mechanic_id: @mechanic_2.id, ride_id: @scrambler.id)
    ride_mechanic_3 = RideMechanic.create(mechanic_id: @mechanic_2.id, ride_id: @hurler.id)
    ride_mechanic_4 = RideMechanic.create(mechanic_id: @mechanic_3.id, ride_id: @ferris.id)
  end

  describe 'US3 - Amusement Park Show page' do
    it 'Then I see the name and price of admissions for that amusement park' do 
      visit amusement_park_path(@six_flags)
      expect(page).to have_content("Admission: 75")
      expect(page).to have_content("Park: Six Flags")
      
      expect(page).to_not have_content("Universal Studios")
      expect(page).to_not have_content("Admission: 80")

    end

    it "has a unique list of the names of all mechanics that are working on that park's rides" do 
      visit amusement_park_path(@six_flags)
      save_and_open_page
      expect(page).to_not have_content("Charlie Smith")
      expect(page).to have_content("Michael Jones")
      expect(page).to have_content("John Doe")
    end
  end
end

