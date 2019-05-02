class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.top_merch_by_revenue(limit = 5)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
          .joins(invoices: [:invoice_items, :transactions])
          .where(transactions: {result: 'success'})
          .group(:id)
          .order("revenue DESC")
          .limit(limit)
  end
end
