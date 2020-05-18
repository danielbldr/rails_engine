require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items.count).to eq(3)
    expect(items.first).to have_key('name')
  end

  it "returns data for specified merchant id" do
    create_list(:merchant, 3)

    get "/api/v1/merchants/#{Merchant.last.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item).to have_key('name')
  end
end
