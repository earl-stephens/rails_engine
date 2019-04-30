require 'csv'

namespace :import do
  desc 'rake import customer data from csv'
  task customer_data: :environment do
    CSV.foreach('db/data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_hash)
    end
  end

  desc 'rake import merchant data from csv'
  task merchant_data: :environment do
    CSV.foreach('db/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_hash)
    end
  end

  desc 'rake import item data from csv'
  task item_data: :environment do
    CSV.foreach('db/data/items.csv', headers: true) do |row|
      Item.create!(row.to_hash)
    end
  end

  desc 'rake import invoices from csv'
  task invoice_data: :environment do
    CSV.foreach('db/data/invoices.csv', headers: true) do |row|
      Invoice.create!(row.to_hash)
    end
  end

  desc 'rake import invoice_item data from csv'
  task invoice_item_data: :environment do
    CSV.foreach('db/data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end

  desc 'rake import transaction data from csv'
  task transaction_data: :environment do
    CSV.foreach('db/data/transactions.csv', headers: true) do |row|
      Transaction.create!(row.to_hash)
    end
  end
end
