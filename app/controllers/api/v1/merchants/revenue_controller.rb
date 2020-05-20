class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    merchants = Merchant.highest_earning_merchants(params['quantity'].to_i)
    render json: MerchantSerializer.new(merchants)
  end
end
