class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :description, :id, :merchant_id, :name, :unit_price
end
