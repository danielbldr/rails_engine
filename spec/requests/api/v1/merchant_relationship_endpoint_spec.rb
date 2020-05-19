require 'rails_helper'

describe "Merchants API Relationship endpoints" do
  it "can return all items associated with the merchant" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    create_list(:item, 3, merchant_id: merchant1.id)
    create_list(:item, 4, merchant_id: merchant2.id)

    get "/api/v1/merchants/#{merchant1.id}/items"

    items = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(items.count).to eq(3)
  end
end
