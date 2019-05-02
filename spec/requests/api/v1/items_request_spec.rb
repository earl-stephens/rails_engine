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
end
