class Api::V1::Items::SearchController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.search(query_params))
  end

  def show
    render json: ItemSerializer.new(Item.search(query_params).first)
  end

  private

  def query_params
    params.permit('name', 'description', 'unit_price', 'merchant_id',
                  'created_at', 'updated_at')
  end
end
