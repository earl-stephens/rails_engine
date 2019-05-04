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
    # binding.pry
    #Merchant.joins(invoices: :invoice_items).where(invoices: {created_at: start..finish})
    #InvoiceItem.joins(:invoice).select("invoice_items.*, sum(invoice_items.quantity * invoice_items.price) as revenue").group(:id)
    # returned_invoices = Invoice.joins(:invoice_items, :transactions)
    #                            .select("invoices.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
    #                            .where(transactions: {result: 'success'})
    #                            .where(:created_at => start..finish)
    Invoice.joins(:invoice_items, :transactions)
                     .where(transactions: {result: 'success'})
                     .where(:created_at => start..finish)
                     .sum('invoice_items.quantity * invoice_items.unit_price').round(2)
    # Invoice.joins(:invoice_items, :transactions).where(transactions: {result: 'success'}).where(:created_at => start..finish).select('invoices.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    # binding.pry
    # total_revenue = 0
    # returned_invoices.each do |invoice|
    #   total_revenue = total_revenue += invoice.revenue
    # end
    # total_revenue.to_f.round(2)
  end
end
