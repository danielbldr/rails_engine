class Api::V1::Merchants::SearchController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.search(query_params))
  end

  def show
    render json: MerchantSerializer.new(Merchant.search(query_params).first)
  end

  private

  def query_params
    params.permit('name', 'created_at', 'updated_at')
  end
end
