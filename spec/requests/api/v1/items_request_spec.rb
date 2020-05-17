require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items.count).to eq(3)
    expect(items.first).to have_key('name')
    expect(items.first).to have_key('description')
    expect(items.first).to have_key('unit_price')
    expect(items.first).to have_key('merchant_id')
  end
end
