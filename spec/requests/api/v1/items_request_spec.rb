require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)['data']

    expect(items.count).to eq(3)
    expect(items.first['attributes']).to have_key('name')
    expect(items.first['attributes']).to have_key('description')
    expect(items.first['attributes']).to have_key('unit_price')
    expect(items.first['attributes']).to have_key('merchant_id')
    expect(items.first['attributes']).to_not have_key('updated_at')
    expect(items.first['attributes']).to_not have_key('created_at')
  end

  it "returns data for a specified item" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get "/api/v1/items/#{Item.last.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)
    item_data = item['data']

    expect(item.count).to eq(1)
    expect(item_data['attributes']).to have_key('name')
    expect(item_data['attributes']).to have_key('description')
    expect(item_data['attributes']).to have_key('unit_price')
    expect(item_data['attributes']).to have_key('merchant_id')
    expect(item_data['attributes']).to_not have_key('updated_at')
    expect(item_data['attributes']).to_not have_key('created_at')
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

  it "can find an item by it's name" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get "/api/v1/items/find?name=#{Item.last.name[0..-3]}"

    item = JSON.parse(response.body)
    item_data = item['data']

    expect(response).to be_success
    expect(item.count).to eq(1)
    expect(item_data['attributes']['name']).to eq(Item.last.name)
    expect(item_data['attributes']['description']).to eq(Item.last.description)
    expect(item_data['attributes']['unit_price']).to eq(Item.last.unit_price)
    expect(item_data['attributes']['merchant_id']).to eq(Item.last.merchant_id)
  end

  it "can find an item by it's description" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get "/api/v1/items/find?description=#{Item.last.description}"

    item = JSON.parse(response.body)
    item_data = item['data']

    expect(response).to be_success
    expect(item.count).to eq(1)
    expect(item_data['attributes']['name']).to eq(Item.last.name)
    expect(item_data['attributes']['description']).to eq(Item.last.description)
    expect(item_data['attributes']['unit_price']).to eq(Item.last.unit_price)
    expect(item_data['attributes']['merchant_id']).to eq(Item.last.merchant_id)
  end

  it "can find an item by it's unit price" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get "/api/v1/items/find?unit_price=#{Item.last.unit_price}"

    item = JSON.parse(response.body)
    item_data = item['data']

    expect(response).to be_success
    expect(item.count).to eq(1)
    expect(item_data['attributes']['name']).to eq(Item.last.name)
    expect(item_data['attributes']['description']).to eq(Item.last.description)
    expect(item_data['attributes']['unit_price']).to eq(Item.last.unit_price)
    expect(item_data['attributes']['merchant_id']).to eq(Item.last.merchant_id)
  end

  it "can find an item by it's merchant_id" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get "/api/v1/items/find_all?merchant_id=#{Item.last.merchant_id}"

    item = JSON.parse(response.body)
    item_data = item['data']

    expect(response).to be_success
    expect(item_data.count).to eq(3)
    expect(item_data.last['attributes']['name']).to eq(Item.last.name)
    expect(item_data.last['attributes']['description']).to eq(Item.last.description)
    expect(item_data.last['attributes']['unit_price']).to eq(Item.last.unit_price)
    expect(item_data.last['attributes']['merchant_id']).to eq(Item.last.merchant_id)
  end
end
