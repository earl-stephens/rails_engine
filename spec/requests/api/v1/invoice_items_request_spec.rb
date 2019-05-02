require "rails_helper"

describe 'InvoiceItems API' do
  it 'sends a list of invoice_items' do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    create_list(:invoice_item, 5, invoice_id: invoice.id, item_id: item.id)

    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(5)
  end

  it 'can show an individual invoice_item' do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    i_i = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)
# binding.pry
    get "/api/v1/invoice_items/#{i_i.id}"

    expect(response).to be_successful
  end
end
