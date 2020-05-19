require 'rails_helper'

describe "Items API Relationship Endpoints" do
  it "can return the merchant associated with an item" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}/merchant"

    items_merchant = JSON.parse(response.body)
    items_merchant_data = items_merchant['data']

    expect(response).to be_success
    expect(items_merchant.count).to eq(1)
    expect(items_merchant_data['attributes']['name']).to eq(merchant.name)
  end
end
