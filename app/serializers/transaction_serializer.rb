class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :credit_card_number, :id, :invoice_id, :result
end
