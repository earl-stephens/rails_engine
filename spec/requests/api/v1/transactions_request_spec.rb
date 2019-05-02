require "rails_helper"

describe 'Transactions API' do
  it 'sends a list of transactions' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    create_list(:transaction, 5, invoice_id: invoice.id)

    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"].count).to eq(5)
  end

  it 'can show an individual transaction' do
    customer1 = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer1.id, merchant_id: merchant.id)
    transaction = create(:transaction, invoice_id: invoice.id)
# binding.pry
    get "/api/v1/transactions/#{transaction.id}"

    expect(response).to be_successful
  end
end
