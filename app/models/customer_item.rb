class CustomerItem < ApplicationRecord
  has_many :customers
  has_many :items
end