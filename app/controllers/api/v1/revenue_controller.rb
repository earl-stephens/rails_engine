class Api::V1::RevenueController < ApplicationController

  def show
    merch = Merchant.find(params[:merchant_id])
    if params["date"] == nil
      render json: {"data" => {"attributes" => {"revenue" => merch.total_revenue(merch.id)}}}
    else
      # binding.pry
      render json: {"data" => {"attributes" => {"revenue" => merch.total_revenue_by_date(merch.id, params["date"])}}}
    end
  end

end
