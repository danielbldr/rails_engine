require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].count).to eq(3)
    expect(items['data'].first['attributes']).to have_key('name')
    expect(items['data'].first['attributes']).to have_key('description')
    expect(items['data'].first['attributes']).to have_key('unit_price')
    expect(items['data'].first['attributes']).to have_key('merchant_id')
    expect(items['data'].first['attributes']).to_not have_key('updated_at')
    expect(items['data'].first['attributes']).to_not have_key('created_at')
  end

  it "returns data for a specified item" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get "/api/v1/items/#{Item.last.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item.count).to eq(1)
    expect(item['data']['attributes']).to have_key('name')
    expect(item['data']['attributes']).to have_key('description')
    expect(item['data']['attributes']).to have_key('unit_price')
    expect(item['data']['attributes']).to have_key('merchant_id')
    expect(item['data']['attributes']).to_not have_key('updated_at')
    expect(item['data']['attributes']).to_not have_key('created_at')
  end

  it "can create a new item" do
    merchant = create(:merchant)
    item_params = { name: 'Dark Roast', description: 'Burnt coffee',
                     unit_price: 4.50, merchant_id: merchant.id}

    post '/api/v1/items/', params: { item: item_params }

    item = Item.last

    expect(response).to be_successful
    expect(item.name).to eq(item_params[:name])
    expect(item.description).to eq(item_params[:description])
    expect(item.unit_price).to eq(item_params[:unit_price])
    expect(item.merchant_id).to eq(item_params[:merchant_id])
  end
end
