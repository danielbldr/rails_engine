require 'rails_helper'

RSpec.describe Merchant do
  describe 'validations' do
    it { should validate_presence_of :name}
  end

  describe 'class methods' do
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

    it 'will return items based off of query param' do
      create_list(:merchant, 3)
      params = { "name" => Merchant.last.name[0..-4]}

      expect(Merchant.search(params).first).to eq(Merchant.last)
    end

    it 'will return activerecord relation for n number of highest earning merchants' do
      merchants = Merchant.highest_earning_merchants(2)

      expect(merchants.length).to eq(2)
      expect(merchants).to include(@merchant1)
      expect(merchants).to include(@merchant2)
    end

    it 'will return activerecord relation for n number of merchants that have sold the most items' do
      merchants = Merchant.most_items_sold(2)

      expect(merchants.length).to eq(2)
      expect(merchants).to include(@merchant1)
      expect(merchants).to include(@merchant3)
    end

    it 'will return total merchant revenue between two dates' do
      dates = { 'start' => '2012-03-09', 'end' => '2012-03-24'}
      rev = Merchant.all_merchant_revenue(dates)
      rev_in_json = RevenueSerializer.new(rev.first).to_json
      parsed_json = JSON.parse(rev_in_json)

      expect(parsed_json['data']['attributes']['revenue']).to eq(60)
    end
  end
end
