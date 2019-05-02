require "rails_helper"

describe 'Invoices API' do
  it 'sends a list of invoices' do
    merchant = create(:merchant)
    customer = create(:customer)
    create_list(:invoice, 5, merchant_id: merchant.id, customer_id: customer.id)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(5)
  end

  it 'can show an individual invoice' do
    customer1 = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer1.id)
# binding.pry
    get "/api/v1/invoices/#{invoice.id}"

    expect(response).to be_successful
  end
end
