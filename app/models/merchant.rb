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
    revenue = Invoice.joins(:invoice_items, :transactions)
                     .merge(Transaction.successful)
                     .where(:created_at => start..finish)
                     .sum('invoice_items.quantity * invoice_items.unit_price')
    revenue = (revenue.to_f)/100
  end

  def total_revenue(id)
    revenue = Merchant.joins(invoices: [:invoice_items, :transactions])
                      .where(id: id)
                      .merge(Transaction.successful)
                      .sum('invoice_items.quantity * invoice_items.unit_price')
                      # binding.pry
    revenue = (revenue.to_f)/100.round(2)
    revenue.to_s
  end

  def total_revenue_by_date(id, date)
    start_date = date.to_datetime
    end_date = date.to_datetime.end_of_day
    revenue = Merchant.joins(invoices: [:invoice_items, :transactions])
                      .where(id: id)
                      .where(invoices: {created_at: start_date..end_date})
                      .merge(Transaction.successful)
                      .sum('invoice_items.quantity * invoice_items.unit_price')
    revenue = (revenue.to_f)/100.round(2)
    revenue.to_s
  end

  def fave_customer(id)
    merch_fave = Customer.joins(invoices: [:merchant, :transactions])
                          .merge(Transaction.successful)
                          .where(merchants: {id: id})
                          .select('customers.*, count(invoices.id) as num_orders')
                          .group(:id)
                          .order('num_orders DESC')
                          .limit(1)
    merch_fave.first
  end
end
