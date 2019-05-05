class Api::V1::Merchants::SearchController < ApplicationController

  def show
    if params[:id] != nil
      render json: MerchantFinderSerializer.new(Merchant.find(params[:id]))
    elsif params[:name] != nil
      render json: MerchantFinderSerializer.new(Merchant.find_by(name: params["name"]))
    elsif params[:created_at] != nil
      render json: MerchantFinderSerializer.new(Merchant.find_by(created_at: params["created_at"]))
    elsif params[:updated_at] != nil
      render json: MerchantFinderSerializer.new(Merchant.find_by(updated_at: params["updated_at"]))
    end
  end

  private

  def merch_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end