class Api::V1::RevenueController < ApplicationController
  def index
    revenue = InvoiceItem.total_revenue(revenue_params['start'],
                                        revenue_params['end'])
    render json: RevenueSerializer.new(Revenue.new(revenue))
  end

  def show
    revenue = Merchant.revenue(revenue_params['merchant_id'])
    render json: RevenueSerializer.new(Revenue.new(revenue))
  end

  def revenue_params
    params.permit('start', 'end', 'merchant_id')
  end
end
