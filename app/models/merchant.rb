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

  def self.top_merch_by_num_sold(limit = 5)
    # binding.pry
    select("merchants.*, SUM(invoice_items.quantity) AS total_count")
          .joins(invoices: [:invoice_items, :transactions])
          .where(transactions: {result: "success"})
          .group(:id)
          .order("total_count DESC")
          .limit(limit)
  end

  def self.revenue_by_date(date)
    start = date.to_datetime
    finish = date.to_datetime.end_of_day
    #Merchant.joins(invoices: :invoice_items).where(invoices: {created_at: start..finish})
    #InvoiceItem.joins(:invoice).select("invoice_items.*, sum(invoice_items.quantity * invoice_items.price) as revenue").group(:id)
    Invoice.joins(:invoice_items)
           .select("invoices.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
           .group(:id)
           .where(:created_at => start..finish)
    binding.pry
  end
end
