class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(quantity)
  Item.joins(invoice_items: [invoice: :transactions])
        .merge(Transaction.successful)
        .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
        .group(:id)
        .order('revenue DESC')
        .limit(quantity)
  end
end
