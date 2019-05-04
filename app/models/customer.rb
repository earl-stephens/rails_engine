class Customer < ApplicationRecord
  has_many :invoices

  def fave_merchant(id)
    customer_fave = Merchant.joins(invoices: [:customer, :transactions])
                            .merge(Transaction.successful)
                            .where(customers: {id: id})
                            .select('merchants.*, count(invoices.id) as num_orders')
                            .group(:id)
                            .order('num_orders DESC')
                            .limit(1)
    customer_fave.first
  end
end
