require 'rails_helper'

RSpec.describe Supermarket, type: :model do
  describe 'relationships' do
    it { should have_many :customers }
  end

  describe 'instance methods' do
    it 'has distinct_items' do
      king = Supermarket.create!(name: "King Soops", location: "Denver")

      toothpaste = Item.create!(name: "Toothpaste", price: 1)
      bread = Item.create!(name: "Bread", price: 2)
      bagels = Item.create!(name: "Bagels", price: 3)
      pizza = Item.create!(name: "Pizza", price: 4)
      berries = Item.create!(name: "Berries", price: 5)
      guac = Item.create!(name: "Guac", price: 6)

      ed = king.customers.create!(name: "Ed")
      CustomerItem.create!(customer_id: ed.id, item_id: toothpaste.id)
      CustomerItem.create!(customer_id: ed.id, item_id: bread.id)
      CustomerItem.create!(customer_id: ed.id, item_id: bagels.id)

      edd = king.customers.create!(name: "Edd")
      CustomerItem.create!(customer_id: edd.id, item_id: toothpaste.id)
      CustomerItem.create!(customer_id: edd.id, item_id: pizza.id)

      eddy = king.customers.create!(name: "Eddy")
      CustomerItem.create!(customer_id: eddy.id, item_id: toothpaste.id)

      expect(king.distinct_items).to include(toothpaste)
      expect(king.distinct_items).to include(bread)
      expect(king.distinct_items).to include(bagels)
      expect(king.distinct_items).to include(pizza)
      expect(king.distinct_items).to_not include(berries)
      expect(king.distinct_items).to_not include(guac)
    end

    it 'has most_popular items' do
      king = Supermarket.create!(name: "King Soops", location: "Denver")

      toothpaste = Item.create!(name: "Toothpaste", price: 1) #0
      bread = Item.create!(name: "Bread", price: 2) #2
      bagels = Item.create!(name: "Bagels", price: 3) #1
      pizza = Item.create!(name: "Pizza", price: 4) #5 !
      berries = Item.create!(name: "Berries", price: 5) #3 !
      guac = Item.create!(name: "Guac", price: 6) #4 !

      ed = king.customers.create!(name: "Ed")
      CustomerItem.create!(customer_id: ed.id, item_id: pizza.id)
      CustomerItem.create!(customer_id: ed.id, item_id: bread.id)
      CustomerItem.create!(customer_id: ed.id, item_id: bagels.id)

      edd = king.customers.create!(name: "Edd")
      CustomerItem.create!(customer_id: edd.id, item_id: pizza.id)
      CustomerItem.create!(customer_id: edd.id, item_id: bread.id)
      CustomerItem.create!(customer_id: edd.id, item_id: guac.id)

      eddy = king.customers.create!(name: "Eddy")
      CustomerItem.create!(customer_id: eddy.id, item_id: pizza.id)
      CustomerItem.create!(customer_id: eddy.id, item_id: guac.id)
      CustomerItem.create!(customer_id: eddy.id, item_id: berries.id)

      bill = king.customers.create!(name: "Bill")
      CustomerItem.create!(customer_id: bill.id, item_id: pizza.id)
      CustomerItem.create!(customer_id: bill.id, item_id: guac.id)
      CustomerItem.create!(customer_id: bill.id, item_id: berries.id)

      ted = king.customers.create!(name: "Ted")
      CustomerItem.create!(customer_id: ted.id, item_id: pizza.id)
      CustomerItem.create!(customer_id: ted.id, item_id: guac.id)
      CustomerItem.create!(customer_id: ted.id, item_id: berries.id)

      expect(king.most_popular.length).to eq(3)
      expect(king.most_popular).to eq([pizza, guac, berries])
    end
  end
end