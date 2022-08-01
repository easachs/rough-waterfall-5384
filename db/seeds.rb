# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
CustomerItem.create!(customer_id: edd.id, item_id: berries.id)

eddy = king.customers.create!(name: "Eddy")
CustomerItem.create!(customer_id: eddy.id, item_id: toothpaste.id)
CustomerItem.create!(customer_id: eddy.id, item_id: guac.id)

bill = safeway.customers.create!(name: "Bill")
ted = safeway.customers.create!(name: "Ted")
