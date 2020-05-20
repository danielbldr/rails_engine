class Api::V1::Merchants::MerchantItemsController < ApplicationController
  def index
    merchants = Merchant.most_items_sold(params['quantity'])
    render json: MerchantSerializer.new(merchants)
  end
end
