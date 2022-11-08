require 'rails_helper'

RSpec.describe AmusementPark, type: :model do
  describe 'relationships' do
    it { should have_many(:rides) }
  end

  describe 'model test' do 
    it 'has distinct mechanics' do 
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
        
      expect(@six_flags.distinct_mechanics).to eq([@mechanic_2, @mechanic_3])
    end
  end
end