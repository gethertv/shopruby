class Product < ApplicationRecord
  belongs_to :category
  belongs_to :unit_type
end
