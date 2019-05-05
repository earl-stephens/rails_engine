class Api::V1::InvoicesController < ApplicationController

  def index
    if params[:merchant_id] == nil
      render json: InvoiceSerializer.new(Invoice.all)
    else
      merch = Merchant.find(params[:merchant_id])
      render json: InvoiceSerializer.new(Invoice.where(merchant_id: merch.id))
    end
  end

  def show
    render json: InvoiceSerializer.new(Invoice.find(params[:id]))
  end

end
