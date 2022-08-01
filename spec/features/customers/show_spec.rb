require 'rails_helper'

RSpec.describe 'Customer Show' do
  it 'displays list of customers items and name of supermarket' do
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

    visit "/customers/#{ed.id}"

    expect(page).to have_content("King Soops")

    expect(page).to have_content("Toothpaste")
    expect(page).to have_content("Bread")
    expect(page).to have_content("Bagels")
    expect(page).to_not have_content("Pizza")
    expect(page).to_not have_content("Berries")
  end
end