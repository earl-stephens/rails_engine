class Api::V1::Items::SearchController < ApplicationController

  def show
    # binding.pry
    render json: ItemFinderSerializer.new(Item.find_by(item_params))
  end

  private

  def item_params
    # binding.pry
    if params[:unit_price]
      params[:unit_price] = ((params[:unit_price].to_f).round).to_i
      # binding.pry
    end
    params.permit(:id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id)

  end
end
