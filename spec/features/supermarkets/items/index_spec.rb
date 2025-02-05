require 'rails_helper'

RSpec.describe 'Supermarket Items Index' do
  it 'has unique list of supermarkets items' do
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

    visit "/supermarkets/#{king.id}/items"

    expect(page).to have_content("Toothpaste")
    expect(page).to have_content("Bread")
    expect(page).to have_content("Bagels")
    expect(page).to have_content("Pizza")
    expect(page).to_not have_content("Berries")
    expect(page).to_not have_content("Guac")
  end

  it 'has three most popular items based on customer associations' do
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

    visit "/supermarkets/#{king.id}"

    within "#most-popular" do
      within "#item-0" do
        expect(page).to have_content("Pizza")
      end
      within "#item-1" do
        expect(page).to have_content("Guac")
      end
      within "#item-2" do
        expect(page).to have_content("Berries")
      end  
    end
    expect(page).to_not have_content("Bagels")
    expect(page).to_not have_content("Bread")
    expect(page).to_not have_content("Toothpaste")
  end
end