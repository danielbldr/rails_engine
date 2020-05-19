require 'rails_helper'

describe "Merchant API Restful endpoints" do
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
end
