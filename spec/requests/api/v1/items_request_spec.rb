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

    post '/api/v1/items/', params: item_params

    item = Item.last

    expect(response).to be_successful
    expect(item.name).to eq(item_params[:name])
    expect(item.description).to eq(item_params[:description])
    expect(item.unit_price).to eq(item_params[:unit_price])
    expect(item.merchant_id).to eq(item_params[:merchant_id])
  end

  it "can update an item" do
    merchant = create(:merchant)
    original_item = create(:item, merchant_id: merchant.id)
    item_params = { name: "PSL" }

    put "/api/v1/items/#{original_item.id}", params: item_params
    item = Item.find_by(id: original_item.id)

    expect(response).to be_successful
    expect(item.name).to_not eq(original_item.name)
    expect(item.name).to eq(item_params[:name])
    expect(item.description).to eq(original_item.description)
    expect(item.unit_price).to eq(original_item.unit_price)
    expect(item.merchant_id).to eq(original_item.merchant_id)
  end

  it "can destroy an item" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    expect{ delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)

    expect(response).to be_success
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
