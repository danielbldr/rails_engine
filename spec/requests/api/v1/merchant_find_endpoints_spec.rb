require 'rails_helper'

describe "Items API Find endpoints" do
  it "can find a merchant by it's name" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant.name[0..-3]}"

    found_merchant = JSON.parse(response.body)
    merchant_data = found_merchant['data']

    expect(response).to be_success
    expect(found_merchant.count).to eq(1)
    expect(merchant_data['attributes']['name']).to eq(merchant.name)
  end

  it "can find a merchant by it's created at date" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?created_at=#{merchant.created_at}"

    found_merchant = JSON.parse(response.body)
    merchant_data = found_merchant['data']

    expect(response).to be_success
    expect(found_merchant.count).to eq(1)
    expect(merchant_data['attributes']['name']).to eq(merchant.name)
  end

  it "can find a merchant by it's updated at date" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?updated_at=#{merchant.updated_at}"

    found_merchant = JSON.parse(response.body)
    merchant_data = found_merchant['data']

    expect(response).to be_success
    expect(found_merchant.count).to eq(1)
    expect(merchant_data['attributes']['name']).to eq(merchant.name)
  end

  it "can find a merchant by multiple parameters" do
    merchant1 = Merchant.create(name: "Coffee Bar", updated_at: '2012-03-27 14:53:59 UTC', created_at: '2012-03-27 14:53:59 UTC')
    merchant2 = Merchant.create(name: "Coffee Club", updated_at: '2012-03-27 14:53:59 UTC', created_at: '2012-03-27 14:53:59 UTC')
    merchant3 = Merchant.create(name: "Peets", updated_at: '2012-03-27 14:53:59 UTC', created_at: '2012-03-27 14:53:59 UTC')
    merchant4 = Merchant.create(name: "Starbucks", updated_at: '2015-03-27 14:53:59 UTC', created_at: '2015-03-27 14:53:59 UTC')

    get "/api/v1/merchants/find_all?name=Coffee&updated_at=2012-03-27 14:53:59 UTC"

    found_merchants = JSON.parse(response.body)
    merchant_data = found_merchants['data']

    expect(response).to be_success
    expect(merchant_data.count).to eq(3)

    merchant_names = merchant_data.map { |merchant| merchant['attributes']['name'] }

    expect(merchant_names).to include(merchant1.name)
    expect(merchant_names).to include(merchant2.name)
    expect(merchant_names).to include(merchant3.name)
    expect(merchant_names).to_not include(merchant4.name)
  end
end
