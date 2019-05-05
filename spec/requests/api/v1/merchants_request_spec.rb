require "rails_helper"

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 5)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(5)
  end

  it 'can show an individual merchant' do
    merchant = create(:merchant)
# binding.pry
    get "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful
  end

  describe 'single finders' do
    before :each do
      @merchant1 = create(:merchant, created_at: "2019-05-04T14:54:05.000Z", updated_at: "2019-05-04T15:54:05.000Z")
      @merchant2 = create(:merchant, created_at: "2019-05-03T14:54:05.000Z", updated_at: "2019-05-03T15:54:05.000Z")
      @merchant3 = create(:merchant, created_at: "2019-05-02T14:54:05.000Z", updated_at: "2019-05-02T15:54:05.000Z")
    end

    it 'can find merchant by id' do
      get "/api/v1/merchants/find?id=#{@merchant2.id}"

      merch = JSON.parse(response.body)
# binding.pry
      expect(response).to be_successful
      expect(merch["data"]["attributes"]["id"]).to eq(@merchant2.id)
    end

    it 'can find merchant by name' do
      get "/api/v1/merchants/find?name=#{@merchant2.name}"

      merch = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merch["data"]["attributes"]["name"]).to eq(@merchant2.name)
    end

    it 'can find merchant by created at time' do
      get "/api/v1/merchants/find?created_at=#{@merchant1.created_at}"

      merch = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merch["data"]["attributes"]["name"]).to eq(@merchant1.name)
    end

    it 'can find merchant by updated at time' do
      get "/api/v1/merchants/find?updated_at=#{@merchant3.updated_at}"

      merch = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merch["data"]["attributes"]["name"]).to eq(@merchant3.name)
    end

    it 'can find a random merchant' do
      get '/api/v1/merchants/random'

      merch = JSON.parse(response.body)

      expect(response).to be_successful
    end
  end

  describe 'multi finders' do
    before :each do
      @merch1 = create(:merchant)
      @merch2 = create(:merchant, name: "Joe")
      @merch3 = create(:merchant, name: "Joe")
      @merch4 = create(:merchant, created_at: "2019-05-04T14:54:05.000Z", updated_at: "2019-05-04T15:54:05.000Z")
      @merch5 = create(:merchant, created_at: "2019-05-04T14:54:05.000Z", updated_at: "2019-05-03T15:54:05.000Z")
      @merch6 = create(:merchant, created_at: "2019-05-03T14:54:05.000Z", updated_at: "2019-05-03T15:54:05.000Z")
    end

    it 'finds all by id' do
      get "/api/v1/merchants/find_all?id=#{@merch1.id}"

      merch = JSON.parse(response.body)
      # binding.pry

      expect(response).to be_successful
      expect(merch["data"].first["attributes"]["name"]).to eq(@merch1.name)
    end

    it 'finds all by name' do
      get "/api/v1/merchants/find_all?name=#{@merch2.name}"

      merch = JSON.parse(response.body)
      # binding.pry

      expect(response).to be_successful
      expect(merch["data"].first["attributes"]["name"]).to eq(@merch2.name)
    end

    it 'finds all by created at' do
      get "/api/v1/merchants/find_all?created_at='2019-05-04T14:54:05.000Z'"

      merch = JSON.parse(response.body)
      # binding.pry

      expect(response).to be_successful
      expect(merch["data"].first["attributes"]["name"]).to eq(@merch4.name)
    end

    it 'finds all by updated at' do
      get "/api/v1/merchants/find_all?updated_at='2019-05-03T15:54:05.000Z'"

      merch = JSON.parse(response.body)
      # binding.pry

      expect(response).to be_successful
      expect(merch["data"].first["attributes"]["name"]).to eq(@merch5.name)
    end
  end

  describe 'biz intel methods' do
    before :each do
      @merch1 = create(:merchant)
      @merch2 = create(:merchant)
      @merch3 = create(:merchant)
      @merch4 = create(:merchant)
      @merch5 = create(:merchant)
      @merch6 = create(:merchant)
      @item1 = @merch1.items.create!(name: 'item1', description: 'first item', unit_price: 500)
      @item2 = @merch2.items.create!(name: 'item2', description: 'first item', unit_price: 1000)
      @item3 = @merch3.items.create!(name: 'item3', description: 'first item', unit_price: 1500)
      @item4 = @merch4.items.create!(name: 'item4', description: 'first item', unit_price: 2000)
      @item5 = @merch5.items.create!(name: 'item5', description: 'first item', unit_price: 2500)
      @item6 = @merch6.items.create!(name: 'item6', description: 'first item', unit_price: 3000)
      @customer = create(:customer)
      @customer2 = create(:customer, first_name: "Joe")
      @customer3 = create(:customer, first_name: "Jim")
      @invoice1 = @customer.invoices.create!(status: 'shipped', merchant_id: @merch1.id, created_at: '2019-02-07 12:54:24 -0500', updated_at: '2019-02-07 12:54:24 -0500')
      @invoice2 = @customer.invoices.create!(status: 'shipped', merchant_id: @merch2.id, created_at: '2019-02-07 12:54:24 -0500', updated_at: '2019-02-07 12:54:24 -0500')
      @invoice3 = @customer.invoices.create!(status: 'shipped', merchant_id: @merch3.id, created_at: '2019-02-08 12:54:24 -0500', updated_at: '2019-02-08 12:54:24 -0500')
      @invoice4 = @customer.invoices.create!(status: 'shipped', merchant_id: @merch4.id, created_at: '2019-02-08 12:54:24 -0500', updated_at: '2019-02-08 12:54:24 -0500')
      @invoice5 = @customer2.invoices.create!(status: 'shipped', merchant_id: @merch5.id, created_at: '2019-02-09 12:54:24 -0500', updated_at: '2019-02-09 12:54:24 -0500')
      @invoice6 = @customer2.invoices.create!(status: 'shipped', merchant_id: @merch6.id, created_at: '2019-02-10 12:54:24 -0500', updated_at: '2019-02-10 12:54:24 -0500')
      @invoice7 = @customer3.invoices.create!(status: 'shipped', merchant_id: @merch6.id, created_at: '2019-02-11 12:54:24 -0500', updated_at: '2019-02-11 12:54:24 -0500')
      @invoice8 = @customer3.invoices.create!(status: 'shipped', merchant_id: @merch6.id, created_at: '2019-02-12 12:54:24 -0500', updated_at: '2019-02-12 12:54:24 -0500')
      @invoice9 = @customer3.invoices.create!(status: 'shipped', merchant_id: @merch6.id, created_at: '2019-02-13 12:54:24 -0500', updated_at: '2019-02-13 12:54:24 -0500')
      @i_i1 = InvoiceItem.create!(quantity: 2, unit_price: 600, item_id: @item1.id, invoice_id: @invoice1.id)
      @i_i2 = InvoiceItem.create!(quantity: 4, unit_price: 800, item_id: @item2.id, invoice_id: @invoice2.id)
      @i_i3 = InvoiceItem.create!(quantity: 6, unit_price: 1000, item_id: @item3.id, invoice_id: @invoice3.id)
      @i_i4 = InvoiceItem.create!(quantity: 8, unit_price: 1200, item_id: @item4.id, invoice_id: @invoice4.id)
      @i_i5 = InvoiceItem.create!(quantity: 10, unit_price: 1400, item_id: @item5.id, invoice_id: @invoice5.id)
      @i_i6 = InvoiceItem.create!(quantity: 3, unit_price: 160, item_id: @item6.id, invoice_id: @invoice6.id)
      @i_i6 = InvoiceItem.create!(quantity: 5, unit_price: 170, item_id: @item5.id, invoice_id: @invoice7.id)
      @i_i6 = InvoiceItem.create!(quantity: 7, unit_price: 180, item_id: @item4.id, invoice_id: @invoice8.id)
      @i_i6 = InvoiceItem.create!(quantity: 9, unit_price: 190, item_id: @item3.id, invoice_id: @invoice9.id)
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

    it 'returns top 5 merchants by revenue' do
      get '/api/v1/merchants/most_revenue?quantity=4'

      merchants_data = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchants_data["data"].count).to eq(4)
      expect(merchants_data["data"].first["id"]).to eq(@merch5.id.to_s)
      expect(merchants_data["data"].second["id"]).to eq(@merch4.id.to_s)
    end

    it 'returns top 5 merchants by number of items sold' do
      get '/api/v1/merchants/most_items?quantity=4'

      merchants_data = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchants_data["data"].count).to eq(4)
      expect(merchants_data["data"].first["id"]).to eq(@merch6.id.to_s)
      expect(merchants_data["data"].second["id"]).to eq(@merch5.id.to_s)
      expect(merchants_data["data"].third["id"]).to eq(@merch4.id.to_s)
    end

    it 'returns total revenue for a particular date' do
      get '/api/v1/merchants/revenue?date=2019-02-07'

      expect(response).to be_successful
    end

    it 'gives total revenue for a single merchant' do
      get "/api/v1/merchants/#{@merch3.id}/revenue"

      revenue = JSON.parse(response.body)

      expect(response).to be_successful
      expect(revenue["data"]["attributes"]["revenue"]).to eq("60.0")
    end

    it 'gives total revenue for a single merchant on a particular day' do
      get "/api/v1/merchants/#{@merch2.id}/revenue?date=2019-02-07"

      revenue = JSON.parse(response.body)

      expect(response).to be_successful
      expect(revenue["data"]["attributes"]["revenue"]).to eq("32.0")
    end

    it 'shows favorite customer for a particular merchant' do
      get "/api/v1/merchants/#{@merch6.id}/favorite_customer"
# binding.pry
      customer = JSON.parse(response.body)

      expect(response).to be_successful
      expect(customer["data"]["attributes"]["id"]).to eq(@customer3.id)

      get "/api/v1/merchants/#{@merch5.id}/favorite_customer"

      customer2 = JSON.parse(response.body)
      expect(customer2["data"]["attributes"]["id"]).to eq(@customer2.id)
      # binding.pry
    end
  end
end
