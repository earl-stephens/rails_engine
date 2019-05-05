class ItemFinderSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id

  attribute :unit_price do |object|
    price = ((object.unit_price.to_f)/100)
    price = price.to_s
    # binding.pry
  end
end
