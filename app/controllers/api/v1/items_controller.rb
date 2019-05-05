class Api::V1::ItemsController < ApplicationController

  def index
    # binding.pry
    if params[:merchant_id] == nil
      render json: ItemSerializer.new(Item.all)
    else
      merch = Merchant.find(params[:merchant_id])
      render json: ItemSerializer.new(Item.where(merchant_id: merch.id))
    end
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

end
