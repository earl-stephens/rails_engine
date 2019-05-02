class Api::V1::Merchants::MostItemsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.top_merch_by_num_sold(params[:quantity]))
  end

end
