class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def total_price
    price.to_i * quantity.to_i.to_d
  end
end
