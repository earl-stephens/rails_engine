class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    # binding.pry
    render json: {"data" => {"attributes" => {"total_revenue" => (Merchant.revenue_by_date(params[:date])).to_s}}}
  end

end
