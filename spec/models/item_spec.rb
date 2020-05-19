require 'rails_helper'

RSpec.describe Item do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  describe 'relationships' do
    it { should belong_to :merchant}
  end

  describe 'class methods' do
    it 'will return items based off of query param' do
      merchant = create(:merchant)
      create_list(:item, 3, merchant_id: merchant.id)
      params = { "name" => Item.last.name[0..-4]}

      expect(Item.search(params).first).to eq(Item.last)
    end
  end
end
