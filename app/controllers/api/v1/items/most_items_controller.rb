class Api::V1::Items::MostItemsController < ApplicationController

  def  index
    render json: ItemByRevenueSerializer.new(Item.most_items_sold(params[:quantity]))
  end

end
