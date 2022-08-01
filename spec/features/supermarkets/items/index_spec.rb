require 'rails_helper'

RSpec.describe 'Supermarket Items Index' do
  it 'has unique list of supermarkets items' do
    king = Supermarket.create!(name: "King Soops", location: "Denver")
    safeway = Supermarket.create!(name: "Safeway", location: "Lakewood")

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

    visit "/supermarkets/#{king.id}/items"

    expect(page).to have_content("Toothpaste")
    expect(page).to have_content("Bread")
    expect(page).to have_content("Bagels")
    expect(page).to have_content("Pizza")
    expect(page).to_not have_content("Berries")
    expect(page).to_not have_content("Guac")
  end
end