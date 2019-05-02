require "rails_helper"

describe 'Customers API' do
  it 'sends a list of customers' do
    create_list(:customer, 5)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(5)
  end

  it 'can show an individual customer' do
    customer1 = create(:customer)
    customer2 = create(:customer)
    customer3 = create(:customer)
# binding.pry
    get "/api/v1/customers/#{customer2.id}"

    expect(response).to be_successful
  end
end
