require "rails_helper"

describe 'Items API' do
  it 'sends a list of items' do
    merchant = create(:merchant)
    create_list(:item, 5, merchant_id: merchant.id)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(5)
  end

  it 'can show an individual item' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
# binding.pry
    get "/api/v1/items/#{item.id}"

    expect(response).to be_successful
  end

  describe 'biz intel methods' do
    before :each do
      @merch1 = create(:merchant)
      @item1 = @merch1.items.create!(name: 'item1', description: 'first item', unit_price: 500)
      @item2 = @merch1.items.create!(name: 'item2', description: 'first item', unit_price: 1000)
      @item3 = @merch1.items.create!(name: 'item3', description: 'first item', unit_price: 1500)
      @item4 = @merch1.items.create!(name: 'item4', description: 'first item', unit_price: 2000)
      @item5 = @merch1.items.create!(name: 'item5', description: 'first item', unit_price: 2500)
      @item6 = @merch1.items.create!(name: 'item6', description: 'first item', unit_price: 3000)
      @customer = create(:customer)
      @invoice1 = @customer.invoices.create!(status: 'shipped', merchant_id: @merch1.id, created_at: '2019-02-07 12:54:24 -0500', updated_at: '2019-02-07 12:54:24 -0500')
      @invoice2 = @customer.invoices.create!(status: 'shipped', merchant_id: @merch1.id, created_at: '2019-02-07 12:54:24 -0500', updated_at: '2019-02-07 12:54:24 -0500')
      @invoice3 = @customer.invoices.create!(status: 'shipped', merchant_id: @merch1.id, created_at: '2019-02-08 12:54:24 -0500', updated_at: '2019-02-08 12:54:24 -0500')
      @invoice4 = @customer.invoices.create!(status: 'shipped', merchant_id: @merch1.id, created_at: '2019-02-08 12:54:24 -0500', updated_at: '2019-02-08 12:54:24 -0500')
      @invoice5 = @customer.invoices.create!(status: 'shipped', merchant_id: @merch1.id, created_at: '2019-02-09 12:54:24 -0500', updated_at: '2019-02-09 12:54:24 -0500')
      @invoice6 = @customer.invoices.create!(status: 'shipped', merchant_id: @merch1.id, created_at: '2019-02-10 12:54:24 -0500', updated_at: '2019-02-10 12:54:24 -0500')
      @invoice7 = @customer.invoices.create!(status: 'shipped', merchant_id: @merch1.id, created_at: '2019-02-11 12:54:24 -0500', updated_at: '2019-02-11 12:54:24 -0500')
      @invoice8 = @customer.invoices.create!(status: 'shipped', merchant_id: @merch1.id, created_at: '2019-02-12 12:54:24 -0500', updated_at: '2019-02-12 12:54:24 -0500')
      @invoice9 = @customer.invoices.create!(status: 'shipped', merchant_id: @merch1.id, created_at: '2019-02-13 12:54:24 -0500', updated_at: '2019-02-13 12:54:24 -0500')
      @i_i1 = InvoiceItem.create!(quantity: 2, unit_price: 600, item_id: @item1.id, invoice_id: @invoice1.id)
      @i_i2 = InvoiceItem.create!(quantity: 4, unit_price: 800, item_id: @item2.id, invoice_id: @invoice2.id)
      @i_i3 = InvoiceItem.create!(quantity: 6, unit_price: 1000, item_id: @item3.id, invoice_id: @invoice3.id)
      @i_i4 = InvoiceItem.create!(quantity: 7, unit_price: 1200, item_id: @item4.id, invoice_id: @invoice4.id)
      @i_i5 = InvoiceItem.create!(quantity: 10, unit_price: 1400, item_id: @item5.id, invoice_id: @invoice5.id)
      @i_i6 = InvoiceItem.create!(quantity: 3, unit_price: 160, item_id: @item6.id, invoice_id: @invoice6.id)
      @i_i6 = InvoiceItem.create!(quantity: 5, unit_price: 170, item_id: @item5.id, invoice_id: @invoice7.id)
      @i_i6 = InvoiceItem.create!(quantity: 7, unit_price: 180, item_id: @item4.id, invoice_id: @invoice8.id)
      @i_i6 = InvoiceItem.create!(quantity: 7, unit_price: 190, item_id: @item3.id, invoice_id: @invoice9.id)
      @transaction1 = @invoice1.transactions.create!(credit_card_number: 1234, credit_card_expiration_date: Time.now, result: 'success')
      @transaction2 = @invoice2.transactions.create!(credit_card_number: 2345, credit_card_expiration_date: Time.now, result: 'success')
      @transaction3 = @invoice3.transactions.create!(credit_card_number: 3456, credit_card_expiration_date: Time.now, result: 'success')
      @transaction4 = @invoice4.transactions.create!(credit_card_number: 4567, credit_card_expiration_date: Time.now, result: 'success')
      @transaction5 = @invoice5.transactions.create!(credit_card_number: 5678, credit_card_expiration_date: Time.now, result: 'success')
      @transaction6 = @invoice6.transactions.create!(credit_card_number: 6789, credit_card_expiration_date: Time.now, result: 'success')
      @transaction7 = @invoice7.transactions.create!(credit_card_number: 6789, credit_card_expiration_date: Time.now, result: 'success')
      @transaction8 = @invoice8.transactions.create!(credit_card_number: 6789, credit_card_expiration_date: Time.now, result: 'success')
      @transaction9 = @invoice9.transactions.create!(credit_card_number: 6789, credit_card_expiration_date: Time.now, result: 'success')
    end

    it 'shows top 5 items by total revenue generated' do
      get "/api/v1/items/most_revenue?quantity=5"

      items = JSON.parse(response.body)

      expect(response).to be_successful
      expect(items["data"].first["attributes"]["id"]).to eq(@item5.id)
      expect(items["data"].first["attributes"]["name"]).to eq(@item5.name)
    end

    it 'shows top 5 items by total number sold' do
      get "/api/v1/items/most_items?quantity=5"

      items = JSON.parse(response.body)

      expect(response).to be_successful
      expect(items["data"].first["attributes"]["id"]).to eq(@item5.id)
      expect(items["data"].first["attributes"]["name"]).to eq(@item5.name)
    end
  end
end
