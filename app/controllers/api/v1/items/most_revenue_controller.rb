class Api::V1::Items::MostRevenueController < ApplicationController

  def index
    # binding.pry
    render json: ItemByRevenueSerializer.new(Item.most_revenue(params[:quantity]))
  end

end