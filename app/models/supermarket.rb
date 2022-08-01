class Supermarket < ApplicationRecord
  has_many :customers
  has_many :customer_items, through: :customers
  has_many :items, through: :customer_items

  def distinct_items
    items.distinct
  end

  def most_popular
    items
    .select('items.*, count(items.*) as item_count')
    .group('items.id')
    .order('item_count desc')
    .limit(3)
  end
end