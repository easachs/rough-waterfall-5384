require 'rails_helper'

RSpec.describe 'Supermarket show' do
  it 'displays name, and has link to supermarkets item index' do
    king = Supermarket.create!(name: "King Soops", location: "Denver")

    visit "/supermarkets/#{king.id}"

    expect(page).to have_content("King Soops")
    expect(page).to have_link("King Soops Item Index")

    click_link("King Soops Item Index")

    expect(current_path).to eq("/supermarkets/#{king.id}/items")
  end
end