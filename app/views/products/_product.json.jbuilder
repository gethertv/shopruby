json.extract! product, :id, :name, :quantity, :price, :category_id, :unit_type_id, :created_at, :updated_at
json.url product_url(product, format: :json)
