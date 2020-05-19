require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)['data']

    expect(merchants.count).to eq(3)
    expect(merchants.first['attributes']).to have_key('name')
  end

  it "returns data for specified merchant id" do
    create_list(:merchant, 3)

    get "/api/v1/merchants/#{Merchant.last.id}"

    merchant = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(merchant['attributes']).to have_key('name')
  end

  it "can create a new merchant" do
    merchant_params = { name: 'Starbucks'}

    expect{ post "/api/v1/merchants", params: merchant_params }.to change(Merchant, :count).by(1)

    merchant = Merchant.last

    expect(response).to be_successful
    expect(merchant.name).to eq('Starbucks')
  end

  it "can update an exisiting merchant" do
    merchant = create(:merchant)

    put "/api/v1/merchants/#{merchant.id}", params: { name: 'Boxcar Coffee'}

    merchant = Merchant.last

    expect(response).to be_successful
    expect(merchant.name).to eq('Boxcar Coffee')
  end

  it "can delete a merchant" do
    create_list(:merchant, 3)
    merchant = Merchant.last

    expect{ delete "/api/v1/merchants/#{merchant.id}" }.to change(Merchant, :count).by(-1)

    expect(response).to be_successful
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

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

  it "can find a merchant by it's name" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant.name[0..-3]}"

    found_merchant = JSON.parse(response.body)
    merchant_data = found_merchant['data']

    expect(response).to be_success
    expect(found_merchant.count).to eq(1)
    expect(merchant_data['attributes']['name']).to eq(merchant.name)
  end
end
