require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should belong_to(:supermarket) }
    it { should have_many(:customer_items) }
    it { should have_many(:items).through(:customer_items) }
  end

  describe 'class methods' do
    it 'has total_price' do
      king = Supermarket.create!(name: "King Soops", location: "Denver")

      toothpaste = Item.create!(name: "Toothpaste", price: 1)
      bread = Item.create!(name: "Bread", price: 2)
      bagels = Item.create!(name: "Bagels", price: 3)
      pizza = Item.create!(name: "Pizza", price: 4)
      berries = Item.create!(name: "Berries", price: 5)

      ed = king.customers.create!(name: "Ed")
      CustomerItem.create!(customer_id: ed.id, item_id: toothpaste.id)
      CustomerItem.create!(customer_id: ed.id, item_id: bread.id)
      CustomerItem.create!(customer_id: ed.id, item_id: bagels.id)

      expect(ed.total_price).to eq(6)
    end
  end
end