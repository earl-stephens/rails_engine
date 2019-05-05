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

  def self.most_items_sold(quantity)
    Item.joins(invoice_items: [invoice: :transactions])
        .merge(Transaction.successful)
        .select('items.*, sum(invoice_items.quantity) as num_sold')
        .group(:id)
        .order('num_sold DESC')
        .limit(quantity)
    # binding.pry
  end
end
