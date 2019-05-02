class Api::V1::CustomersController < ApplicationController

  def index
    render json: CustomerSerializer.new(Customer.all)
  end

  def show
    # binding.pry
    render json: CustomerSerializer.new(Customer.find(params[:id]))
  end

end
