class Api::V1::RevenueController < ApplicationController
  def index
    revenue = Merchant.all_merchant_revenue(revenue_params)
    render json: RevenueSerializer.new(revenue.first)
  end

  def revenue_params
    params.permit('start', 'end')
  end
end
