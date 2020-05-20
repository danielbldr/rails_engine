require 'rails_helper'

describe "Business Intelligence Endpoints" do
  before(:each) do
    @customer = create(:customer)
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant)
    @item1 = create(:item, merchant_id: @merchant1.id, unit_price: 10.00)
    @item2 = create(:item, merchant_id: @merchant2.id, unit_price: 5.00)
    @item3 = create(:item, merchant_id: @merchant3.id, unit_price: 1.00)
    @item4 = create(:item, merchant_id: @merchant4.id, unit_price: 10.00)
    @invoice1 = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant1.id, status: 'shipped', created_at: '2012-03-09')
    @invoice2 = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant2.id, status: 'shipped', created_at: '2012-03-14')
    @invoice3 = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant3.id, status: 'shipped', created_at: '2012-03-31')
    @invoice4 = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant4.id, status: 'shipped', created_at: '2012-03-14')
    InvoiceItem.create(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 5, unit_price: @item1.unit_price)
    InvoiceItem.create(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: @item2.unit_price)
    InvoiceItem.create(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 5, unit_price: @item3.unit_price)
    InvoiceItem.create(item_id: @item4.id, invoice_id: @invoice4.id, quantity: 1, unit_price: @item4.unit_price)
    Transaction.create!(invoice_id: @invoice1.id, credit_card_number: 1234567890, credit_card_expiration_date: '123', result: 'success')
    Transaction.create!(invoice_id: @invoice2.id, credit_card_number: 1234567890, credit_card_expiration_date: '123', result: 'success')
    Transaction.create!(invoice_id: @invoice3.id, credit_card_number: 1234567890, credit_card_expiration_date: '123', result: 'success')
    Transaction.create!(invoice_id: @invoice4.id, credit_card_number: 1234567890, credit_card_expiration_date: '123', result: 'failed')
  end
  it 'can find merchants with most revenue' do
    get '/api/v1/merchants/most_revenue?quantity=2'

    merchants = JSON.parse(response.body)
    merchant_names = merchants['data'].map {|merchant| merchant['attributes']['name']}

    expect(response).to be_success
    expect(merchants['data'].count).to eq(2)
    expect(merchant_names).to include(@merchant1.name)
    expect(merchant_names).to include(@merchant2.name)
    expect(merchant_names).to_not include(@merchant3.name)
    expect(merchant_names).to_not include(@merchant4.name)
  end

  it 'can return merchants with the most items sold' do
    get '/api/v1/merchants/most_items?quantity=2'

    merchants = JSON.parse(response.body)
    merchant_names = merchants['data'].map {|merchant| merchant['attributes']['name']}

    expect(response).to be_success
    expect(merchant_names).to include(@merchant1.name)
    expect(merchant_names).to include(@merchant3.name)
    expect(merchant_names).to_not include(@merchant2.name)
    expect(merchant_names).to_not include(@merchant4.name)
  end

  it 'can return total revenue across all merchants for given date range' do
    get '/api/v1/revenue?start=2012-03-09&end=2012-03-24'

    revenue = JSON.parse(response.body)

    expect(response).to be_success
    expect(revenue['data']['attributes']['revenue']).to eq(60)
  end

  it 'can return total revenue for a single merchant' do
    get "/api/v1/merchants/#{@merchant1.id}/revenue"

    revenue = JSON.parse(response.body)

    expect(response).to be_success
    expect(revenue['data']['attributes']['revenue']).to eq(50)
  end
end
