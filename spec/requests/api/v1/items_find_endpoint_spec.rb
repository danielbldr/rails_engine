require 'rails_helper'

describe "Items API Find endpoints" do
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

  it "can find an item by it's created at date" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/find?created_at=#{item.created_at}"

    found_item = JSON.parse(response.body)
    item_data = found_item['data']

    expect(response).to be_success
    expect(found_item.count).to eq(1)
    expect(item_data['attributes']['name']).to eq(item.name)
  end

  it "can find an item by it's updated at date" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/find?updated_at=#{item.updated_at}"

    found_item = JSON.parse(response.body)
    item_data = found_item['data']

    expect(response).to be_success
    expect(found_item.count).to eq(1)
    expect(item_data['attributes']['name']).to eq(item.name)
  end

  it "can find an item by multiple parameters" do
    merchant = create(:merchant)
    item1 = Item.create(name: "Pumpkin Spiced latte", description: 'coffee', unit_price: 3.50, merchant_id: merchant.id)
    item2 = Item.create(name: "Pumpkin latte", description: 'coffee', unit_price: 3.50, merchant_id: merchant.id)
    item3 = Item.create(name: "Pumpkins", description: 'coffee', unit_price: 10, merchant_id: merchant.id)
    item4 = Item.create(name: "French Vanilla", description: 'coffee', unit_price: 7.00, merchant_id: merchant.id)

    get "/api/v1/items/find_all?name=Pumpkin&unit_price=3.50"

    found_items = JSON.parse(response.body)
    item_data = found_items['data']

    expect(response).to be_success
    expect(item_data.count).to eq(3)

    item_names = item_data.map { |item| item['attributes']['name'] }

    expect(item_names).to include(item1.name)
    expect(item_names).to include(item2.name)
    expect(item_names).to include(item3.name)
    expect(item_names).to_not include(item4.name)
  end
end
